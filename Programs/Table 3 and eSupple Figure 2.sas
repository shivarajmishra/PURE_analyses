/*******************************************************************/
/*****************Calculation of smoking cessation*****************/
/*****************************************************************/
/*******This program has a mix of proc and data steps************/


/*Methods outline here :
Just want to confirm the definition of smoking cessation and calculation methods. There is no variable called ‘smoking cessation/quitting’
in EPOCH. So, I followed your paper (reference below) and calculated smoking cessation/quitting (yes, former smoker vs current smokers) for 
each individual i in community j. Smoking cessation, Pr (Cij=1), was assumed to be binomially distributed (either 0 or 1) with health knowledge 
variables, adjusted for covariates and a random effect to account for clustering at the community j.
Reference: Chow CK, Corsi DJ, Gilmore AB, Kruger A, Igumbor E, Chifamba J, Yang W, Wei L, Iqbal R, Mony P, Gupta R. Tobacco control environment: 
cross-sectional survey of policy implementation, social unacceptability, knowledge of tobacco health harms and relationship to quit ratio in 17 
low-income, middle-income and high-income countries. BMJ open. 2017 Mar 1;7(3):e013817.*/
/*confirmed with Clara on 9.05.2023*/

/*we are starting with dataset litfactor04 derived in previous step*/
proc contents data=litfactor04;run;
proc freq data=litfactor04;table  smoke1yr*pct33wealthc smoke1yr*incCtry;run;

data check1;
set litfactor04;
if smoke1yr = 3 then smoke_2cat=.;
else smoke_2cat=smoke1yr;
run;

proc freq data =check1; table smoke_2cat;run;
proc freq data=check1;table  pct33wealthc*smoke_2cat incCtry*smoke_2cat asex ;run;

/*Individual association with knowledge questions (10 questions)*/
/***************************************************************/
%let myvar=
eheclund_2cat ehehdis_2cat ehediab_2cat 
ehestrok_2cat ehearth_2cat ehelucan_2cat
ehemocan_2cat ehehdnsm_2cat eheprebi_2cat ehelbirw_2cat;

%mymacro;
%do i=1 %to 10;
proc glimmix data=check1;
 class pct33wealthc educ incCtry lit_3cat;
 model smoke_2cat (ref="2") = educ %scan(&var,&i) pct33wealthc
age asex location ADHYPE ADCHD ADSTROK ADDIAB bmi_2cat incCtry/ dist=binary link=logit ddfm=bw solution oddsratio  or(label);
 random commid / solution;
 estimate 'Former vs current' pct33wealthc 1 0 -1 / or;
run;
%end;
%mend;
%mymacro;

proc glimmix data=check1;
 class pct33wealthc educ incCtry lit_3cat;
 model smoke_2cat (ref="2") = educ lit_3cat pct33wealthc
age asex location ADHYPE ADCHD ADSTROK ADDIAB bmi_2cat incCtry/ dist=binary link=logit ddfm=bw solution oddsratio  or(label);
 random commid / solution;
 estimate 'Former vs current' pct33wealthc 1 0 -1 / or;
run;

/*variables to adjust*/
proc freq data=litfactor04;table bpmedm;run;
proc freq data=test7;table bpmedm;run;
proc freq data=test8;table bpmedm;run;
proc freq data=test9;table bpmedm;run;

/*lets do that seperately for men and women*/
/*men*/
proc glimmix data=check1;
where asex=2;
 class pct33wealthc educ incCtry lit_3cat ;
 model smoke_2cat (ref="2") = educ lit_3cat pct33wealthc
age location ADHYPE ADCHD ADSTROK ADDIAB bmi_2cat incCtry/ dist=binary link=logit ddfm=bw solution oddsratio  or(label);
 random commid / solution;
 estimate 'Former vs current' pct33wealthc 1 0 -1 / or;
run;

proc glimmix data=check1;
/*women*/
where asex=1;
 class pct33wealthc educ incCtry lit_3cat ;
 model smoke_2cat (ref="2") = educ pct33wealthc lit_3cat 
age location ADHYPE ADCHD ADSTROK ADDIAB bmi_2cat incCtry/ dist=binary link=logit ddfm=bw solution oddsratio  or(label);
 random commid / solution;
 estimate 'Former vs current' pct33wealthc 1 0 -1 / or;
run;

%let dpi=300;
%let w=5.5in;
%let h=3.0in;


/*****************************************************************/
/******************eSupple Figure 2 forrestplot graph**************/
/*****************************************************************/
data SubgroupData;
 input Subgroup  $1-33 HR CIL CIU Indent ;
 if HR not in (.) then do;

HRCI = put(HR, 4.2) || " (" || put(CIL, 4.2) || ", "
|| put(CIU, 4.2) || ")";
/* Determine the marker size based on population size */
SquareSize = abs(log(1/((log(CIU)- log(CIL)/3.92)**2)));
 end;

 if HR eq 1 then do;
 SquareSize=.01;
	end;
 row = _n_;

datalines;
Education							.	.	.	0
None, Primary, or Unknown 			0.802	0.607	1.061	1
.									0.485	0.308	0.763	1
Secondary/High/Higher secondary		0.686	0.536	0.879	1
.									0.629	0.43	0.92	1
Trade or college/Uniersity			1	1	1	1
Health knowledge Score*				.	.	.	0
Tertile 1 (low)						0.543	0.380	0.775	1
.									0.776	0.442	1.362	1
Tertile 2							0.718	0.520	0.991	1
.									1.703	1.058	2.742	1
Tertile 3 (high)					1	1	1	1
Wealth index						.	.	.	0
Tertile 1 (low)						0.603	0.471	0.771	1
.									0.611	0.419	0.893	1
Tertile 2							0.843	0.671	1.06	1
.									0.995	0.686	1.442	1
Tertile 3 (high)					1	1	1	1
Regions								.	.	.	0
HIC 								6.284	4.115	9.595	1
.									6.16	1.868	20.312	1
UMIC 								2.775	1.863	4.135	1
.									2.01	0.634	6.38	1
LMIC 								1.178	0.784	1.772	1
.									1.164	0.33	4.108	1
LIC									1	1	1	1
;
run;

data subgroupdata (rename=(subgroup1=subgroup));
set subgroupdata;

subgroup1=strip(subgroup);
drop subgroup;run;

Data subgroupdata1;
set subgroupdata;

if Subgroup eq " " and row not in (1,6,13,19,12,18,26) then do;
	HR1=HR;
	cil1=cil;
	ciu1=ciu;
end;

if Subgroup  ne " " and row not in (1,6,13,19,12,18,26) then do;
	HR2=HR;
	cil2=cil;
	ciu2=ciu;
end;
run;


data SubgroupData1 ;
set SubgroupData1;

row = _n_;

if HR not in (.,1) then do;
se=(log(CIU)-log(CIL))/3.92;
z=abs(log(HR)/se);
pvalue=exp(-0.717*z - 0.416*z**2)
;

if pvalue <0.001 then do; pvalue=0.0001;end;
end;

run;

/*--Used for Subgroup labels in column 1--*/
data anno(drop=indent);
set SubgroupData1(keep=row Subgroup indent rename=(row=y1));
retain Function 'Text ' ID 'id1' X1Space 'DataPercent'
Y1Space 'DataValue ' x1 x2 2 TextSize 7 Width 100 Anchor 'Left ';
if indent;
label = tranwrd(Subgroup, '>=', '(*ESC*){Unicode ''2265''x}');
run;

data subgroupdata ;
set subgroupdata1;

if HRCI="1.00 (1.00, 1.00)" then do; HRCI="Reference"; end;

run;
/*
/*--Used for text under x axis of HR scatter plot in column 7--*
data anno2;
retain Function 'Arrow' ID 'id2' X1Space X2Space 'DataValue'
FIllTransparency 0 Y1Space Y2Space 'GraphPercent'
Scale 1e-40 LineThickness 1 y1 y2 7.0 Width 100
FillStyleElement 'GraphWalls' LineColor 'Black';
x1 = 0.90; x2 = 0.25; output;
x1 = 2.10; x2 = 3.6; output;
function = 'Text'; y1 = 7.0; y2 = 7.0;
x1 = 0.92; anchor = 'Right'; label = 'Pioglitazone Better'; Textsize=8;
output;
x1 = 1.07; Anchor = 'Left '; label = 'Placebo Better'; Textsize=8; output;
run;


data anno; set anno anno2; run;*/

data forest2(drop=flag);
set SubgroupData nobs=nobs;
Head = not indent;
retain flag 2;
if head then flag = mod(flag + 1, 2);
if flag then ref=row;
if indent then Subgroup = ' ';
run;


/*--Define template for Forest Plot--*/
/*--Template uses a Layout Lattice of 8 columns--*/
proc template;
define statgraph Forest;
dynamic _show_bands _color _thk _bandcolor _headercolor _subgroupcolor;
begingraph;
legenditem type=text name="b" /textattrs=(size=12pt) LABELATTRS=(size=12pt)
text="" ;
discreteattrmap name='text';
value '1' / textattrs=(color=black weight=bold ); value other;
enddiscreteattrmap;
discreteattrvar attrvar=type var=head attrmap='text';
layout lattice /
columns=4 columnweights=(0.25 0.15 .30 .16);

/*--Column headers--*/
sidebar / align=top;
layout lattice /
rows=2 columns=4 columnweights=(0.01 0.19 0.35 .12)
 backgroundcolor=_headercolor opaque=true;
entry " ";
entry textattrs=(size=8 weight=bold) halign=left "Factors";
entry textattrs=(size=8 weight=bold) halign=left "Adjusted ORs";
entry textattrs=(size=8 weight=bold) halign=left "P-value";
endlayout;
endsidebar;

/*--First Subgroup column, shows only the Y2 axis--*/
layout overlay / walldisplay=none xaxisopts=(display=none)
yaxisopts=(reverse=true type=discrete display=none
tickvalueattrs=(weight=bold));
annotate / id='id1';
referenceline y=ref / lineattrs=(thickness=_thk color=_color);
axistable y=row value=Subgroup / indentweight=indent 
display=(values) textgroup=type;
endlayout;

/*--Sixth column showing PCIGroup--*/
 layout overlay / x2axisopts=(display=none)
 yaxisopts=(reverse=true type=discrete display=none) walldisplay=none;
 referenceline y=ref / lineattrs=(thickness=_thk color=_color);
 axistable y=row value=HRCI / display=(values);
 endlayout;

/*--third column showing Hazard ratio graph with 95% error bars--*/
layout overlay /xaxisopts=(type=log label=' '  
           labelattrs=(size=.1) tickvalueattrs=(size=8pt) linearopts=(tickvaluepriority=true 
tickvaluelist=(0 1 5) viewmin=1 viewmax=5))
yaxisopts=(reverse=true type=discrete display=none labelattrs=(size=12pt)) walldisplay=none ;
entry halign=left textattrs=(color=black size=7pt) "" halign=right textattrs=(color=black size=7pt) "" /location=outside valign=bottom;
referenceline y=ref / lineattrs=(thickness=_thk color=_color);
scatterplot y=row x=HR1 / xerrorlower=cil1 xerrorupper=ciu1
sizeresponse=SquareSize sizemin=10 sizemax=15
markerattrs=(symbol=squarefilled size=7 color=blue) ERRORBARCAPSHAPE=none name='a' legendlabel='Men';

scatterplot y=row x=HR2 / xerrorlower=cil2 xerrorupper=ciu2
sizeresponse=SquareSize sizemin=10 sizemax=15
markerattrs=(symbol=squarefilled size=7 color=red) ERRORBARCAPSHAPE=none name='b' legendlabel='Women';

/*scatterplot y=row x=OverallValue1 / xerrorlower=lcl3 xerrorupper=ucl3 ERRORBARCAPSHAPE=none markerattrs=(symbol=squarefilled size=10 color=blue) sizeresponse=SquareSize2 sizemin=7 sizemax=12; /**this is what I added to get the diamond filled 'overall' column*/
/*scatterplot y=row x=OverallValue2 / xerrorlower=lcl4 xerrorupper=ucl4 ERRORBARCAPSHAPE=none markerattrs=(symbol=squarefilled size=10 color=red) sizeresponse=SquareSize1 sizemin=7 sizemax=12; /**this is what I added to get the diamond filled 'overall' column*/
referenceline x=1/ lineattrs=(pattern=solid thickness=.01 color=black);
legend;
endlayout;

/*--Sixth column showing PCIGroup--*/
layout overlay / xaxisopts=(display=none)
yaxisopts=(reverse=true type=discrete display=none) walldisplay=none;
referenceline y=ref / lineattrs=(thickness=_thk color=_color);
axistable y=row value=pvalue /display=(values)
valuejustify = center;
endlayout;

 sidebar /align=bottom;
discretelegend "a" "b" / autoitemsize=true backgroundcolor=lightblue itemsize=(linelength=30 fillheight=8) border=false ;
endsidebar;

endlayout;
entryfootnote halign=left textattrs=(size=7) '*Knowledge of health effects of smoking (10 questions)';
endgraph;
end;
run;

proc format;
  value misblank
    .=" ";

  value pformat
  0.0001="<0.001"
  .=" ";

run;

/*---------*/
ods rtf file='1.rtf';
ods html close;
ods listing gpath="C:\Users\USER\OneDrive - The University of Sydney (Staff)\analysis plan + mock up papers\WARC\PURE Health Literacy\Analysis" image_dpi=&dpi;
ods graphics / reset noscale IMAGEFMT=png
width=&w height=&h imagename='bfGraph';
/*--Render Forest Plot with horizontal bands--*/
ods graphics / reset width=8.5in height=5.4in imagename='graph' border;
proc sgrender data=Forest2 template=Forest sganno=anno ;
format HR misblank7.4  pvalue pformat.; 
dynamic _color='Azure' _headercolor="lightblue" _thk=20 ;
title;
run;
ods rtf close;




