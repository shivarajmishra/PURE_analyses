/****************************************************************************/
/*****************************Figure 1 & Table 2****************************/
/**Analysis for smoking cessation and taking anti hypertensive medication**/
/*********This program has a mix of proc steps and data steps*************/

libname abc "C:\Users\USER\OneDrive - The University of Sydney (Staff)\analysis plan + mock up papers\WARC\PURE Health Literacy\Analysis\Data";

data abc.Literacy_data;
set litfactor04;
if smoke1yr = 3 then smoke_2cat=.;
else smoke_2cat=smoke1yr;
run;

data check1;
set abc.Literacy_data;run;

proc freq data=check1;table  smoke1yr pct33wealthc*smoke_2cat incCtry*smoke_2cat asex ;run;
proc freq data=check1;table  smoke1yr smoke_2cat ;run;

/*******************************************************************************8***/
/*Table 2: individual associations of knoweledge variables with smoking cesssation*/
/*********************************************************************************/
/*Unadjusted model*/
%let var=
eheclund_2cat ehehdis_2cat ehediab_2cat 
ehestrok_2cat ehearth_2cat ehelucan_2cat
ehemocan_2cat ehehdnsm_2cat eheprebi_2cat ehelbirw_2cat;

%macro mymacro;
%do i=1 %to 10;
proc glimmix data=check1;
Ods output OddsRatios=var&i ParameterEstimates=ParameterEstimates;
model smoke_2cat (ref="2") = %scan(&var,&i) / dist=binary link=logit ddfm=bw solution oddsratio  or(label);
random commid / solution;
estimate 'Yes vs No' %scan(&var,&i) 1 -1 / or;
run;

%end;
%mend;
%mymacro;

data merged_all;
set var1-var10;
keep label estimate lower upper;
run;

proc print data=merged_all;run;

/*Fully adjusted model*/
%let var=
eheclund_2cat ehehdis_2cat ehediab_2cat 
ehestrok_2cat ehearth_2cat ehelucan_2cat
ehemocan_2cat ehehdnsm_2cat eheprebi_2cat ehelbirw_2cat;

%macro mymacro;
%do i=1 %to 10;
proc glimmix data=check1;
Ods output OddsRatios=var&i ParameterEstimates=ParameterEstimates;
class pct33wealthc educ incCtry lit_3cat;
model smoke_2cat (ref="2") = educ %scan(&var,&i) pct33wealthc
age asex location bmi_2cat incCtry/ dist=binary link=logit ddfm=bw solution oddsratio  or(label);
random commid / solution;
estimate 'Yes vs No' %scan(&var,&i) 1 -1/ or;
run;

data var&i;
set var&i;
if _n_=3; run;

%end;
%mend;
%mymacro;

data merged_all;
set var1-var10;
keep label estimate lower upper;
run;

proc print data=merged_all;run;

/*Table 4: Nested models for the relationship between health literacy and smoking 
cessation (yes, no).*/
/*Model 1*/
proc glimmix data=check1;
Ods output OddsRatios=var&i ParameterEstimates=ParameterEstimates;
model smoke_2cat (ref="2") = %scan(&var,&i) / dist=binary link=logit ddfm=bw solution oddsratio  or(label);
random commid / solution;
estimate 'Yes vs No' %scan(&var,&i) 1 -1 / or;
run;

proc means data=check1;var kscore1;run;


proc rank data=check1 out=litfactor1 Groups=3;
var kscore1;
ranks lit1;
run;

proc freq data=litfactor1; where smoke_2cat ne .;table lit_3cat smoke_2cat;run;

proc format;
value litf
0 = 'Low health literacy'
1= 'Moderate health literacy'
2= 'High health literacy'
;run;

/*Model 1*/
/*health literacy*/
proc glimmix data=litfactor1;
Ods output OddsRatios=OddsRatios ParameterEstimates=ParameterEstimates;
class litw_3cat (ref='Low health literacy');
model smoke_2cat (ref="2") = litw_3cat age asex location bmi_2cat incCtry/ dist=binary link=logit ddfm=bw solution oddsratio  or(label);
random commid / solution;
estimate 'Yes vs No' litw_3cat -1 1 1 / or;
format litw_3cat litf.;
run;

data OddsRatios;
set OddsRatios;
or_ci=catt(put(Estimate ,4.2)," (", put(Lower,4.2),", ", put(Upper,4.2), ')');
keep label estimate lower upper or_ci;

data OddsRatios;
set OddsRatios;
if _n_ in (1,2);
run;

proc print data=OddsRatios;run;

/*education*/
proc freq data=litfactor1;table educ*smoke_2cat;run;
proc glimmix data=litfactor1;
Ods output OddsRatios=OddsRatios ParameterEstimates=ParameterEstimates;
class educ (ref=first);
model smoke_2cat (ref="2") = educ age asex location bmi_2cat incCtry/ dist=binary link=logit ddfm=bw solution oddsratio  or(label);

run;

data OddsRatios;
set OddsRatios;
or_ci=catt(put(Estimate ,4.2)," (", put(Lower,4.2),", ", put(Upper,4.2), ')');
keep label estimate lower upper or_ci;
run;

data OddsRatios;
set OddsRatios;

if _n_ in (1,2);

run;

proc print data=OddsRatios;run;

/*wealth index*/
proc freq data=litfactor1;table pct33wealthc;run;
proc glimmix data=litfactor1;
Ods output OddsRatios=OddsRatios ParameterEstimates=ParameterEstimates;
class pct33wealthc (ref='Windex Tertile 1');
model smoke_2cat (ref="2") = pct33wealthc age asex location bmi_2cat incCtry/ dist=binary link=logit ddfm=bw solution oddsratio  or(label);
random commid / solution;
run;

data OddsRatios;
set OddsRatios;
or_ci=catt(put(Estimate ,4.2)," (", put(Lower,4.2),", ", put(Upper,4.2), ')');
keep label estimate lower upper or_ci;
run;

data OddsRatios;
set OddsRatios;

if _n_ in (1,2);

run;

proc print data=OddsRatios;run;

/*Model 2*/
/*health literacy*/
proc glimmix data=litfactor1;
Ods output OddsRatios=OddsRatios ParameterEstimates=ParameterEstimates;
class litw_3cat (ref='Low health literacy') educ (ref=first);
model smoke_2cat (ref="2") = litw_3cat educ age asex location bmi_2cat incCtry/ dist=binary link=logit ddfm=bw solution oddsratio  or(label);
random commid / solution;
estimate 'Yes vs No' litw_3cat -1 1 1 / or;
format litw_3cat litf.;
run;

data OddsRatios;
set OddsRatios;
or_ci=catt(put(Estimate ,4.2)," (", put(Lower,4.2),", ", put(Upper,4.2), ')');
keep label estimate lower upper or_ci;
run;

data OddsRatios;
set OddsRatios;

if _n_ in (1:4);

run;

proc print data=OddsRatios;run;

/**Cells data to fill Table 4**/
proc freq data=litfactor1;where smoke_2cat ne .; table litw_3cat educ pct33wealthc;run; 

/*Model 2*/
/*health literacy*/
proc glimmix data=litfactor1;
Ods output OddsRatios=OddsRatios ParameterEstimates=ParameterEstimates;
class litw_3cat (ref='Low health literacy') educ (ref=first) pct33wealthc (ref=first);
model smoke_2cat (ref="2") = litw_3cat educ pct33wealthc age asex location bmi_2cat incCtry/ dist=binary link=logit ddfm=bw solution oddsratio  or(label);
random commid / solution;
estimate 'Yes vs No' litw_3cat -1 1 1 / or;
format litw_3cat litf.;
run;

data OddsRatios;
set OddsRatios;
or_ci=catt(put(Estimate ,4.2)," (", put(Lower,4.2),", ", put(Upper,4.2), ')');
keep label estimate lower upper or_ci;
run;

data OddsRatios;
set OddsRatios;

if _n_ in (1:6);

run;

proc print data=OddsRatios;run;

/**********Relative ranking health literacy variables****************************/
/***********This was developed in place of Table 2, but later reinstated as Table*
********Figure ranking individual regression for Q8 and Q18 variables***********/
/******************************************************************************/
%let dpi=300;
%let w=5.5in;
%let h=3.0in;

data SubgroupData;
 input Subgroup  $1-45 pr mean CIL CIU Indent ;
 if mean not in (.) then do;

HRCI = put(mean, 4.2) || " (" || put(CIL, 4.2) || ", "
|| put(CIU, 4.2) || ")";
/* Determine the marker size based on population size */
SquareSize = log(1/((log(CIU)- log(CIL)/3.92)**2));
 end;

 if mean eq 1 then do;
 SquareSize=.001;
	end;
 row = _n_;
datalines;
Health effects of smoking 						.	.	.	.	0
Premature birth with smoking during pregnancy	69.6	1.05	0.82	 1.36	1
Mouth and throat cancer							88.2	1.22	0.81	 1.84	1
Diabetes 										59.5	1.24	0.98	 1.57	1
Arthritis 										66.4	1.25	0.97	 1.61	1
Low birth weight babies with smoking			69	1.29	1.00	 1.67	1
Chronic lung disease							95.1	1.31	0.76	 2.26	1
Stroke											66.9	1.34	1.02	 1.77	1
Heart disease in non-smokers exposed			74.4	1.35	1.02	 1.80	1
Lung cancer										93.7	1.46	0.86	 2.46	1
Heart disease									82.5	1.62	1.13	 2.32	1
Actions to prevent CVD							.	.	.	.	0
Drinking less coffee 							29.1	1.08 	0.93	1.26	1
Quit smoking 									95.3	1.09 	0.93	1.28	1
Eat more green vegetables						92	1.19 	1.03	1.38	1
Eating more dairy products						48.9	1.22 	0.97	1.53	1
Eating more fruit								90	1.25 	1.02	1.52	1
Reduced meat intake 							22.5	1.26 	1.05	1.50	1
Eating more fish								75.5	1.27 	0.99	1.63	1
Reducing fat in meals							86.3	1.31	0.76	 2.26	1
Doing more exercise								87.8	1.48 	1.22	1.80	1
Reducing salt in meals							85.9	1.62	1.13	 2.32	1
;
run;


data SubgroupData;
set SubgroupData;
row = _n_;


if mean not in (.,1) then do;
se=(log(CIU)-log(CIL))/3.92;
z=log(mean)/se;
z1 = input(z, 8.3);
pvalue=exp(-0.717*z1 - 0.416*z1**2);
indent=1;

if pvalue <0.001 then do; pvalue=0.00001;end;
end;
run;

/*--Used for Subgroup labels in column 1--*/
data anno(drop=indent);
set SubgroupData(keep=row Subgroup indent rename=(row=y1));
retain Function 'Text ' ID 'id1' X1Space 'DataPercent'
Y1Space 'DataValue ' x1 x2 2 TextSize 7 Width 100 Anchor 'Left ';
if indent;
label = tranwrd(Subgroup, '>=', '(*ESC*){Unicode ''2265''x}');
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
columns=4 columnweights=(0.40 0.25 .30 .16);

/*--Column headers--*/
sidebar / align=top;
layout lattice /
rows=2 columns=4 columnweights=(0.01 0.3 0.42 .12)
 backgroundcolor=_headercolor opaque=true;
entry " ";
entry textattrs=(size=8 weight=bold) halign=left "Health Knowledge";
entry textattrs=(size=8 weight=bold) halign=left "Adjusted ORs";
/*entry textattrs=(size=8 weight=bold) halign=left "Country";*/
entry textattrs=(size=8 weight=bold) halign=left "P-value";
endlayout;
endsidebar;

/*--First Subgroup column, shows only the Y2 axis--*/
layout overlay / walldisplay=none xaxisopts=(display=none)
yaxisopts=(reverse=true type=discrete display=none
tickvalueattrs=(weight=bold));
annotate / id='id1';
referenceline y=ref / lineattrs=(thickness=_thk color=_color);
axistable y=row value=subgroup / indentweight=indent 
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
           labelattrs=(size=.1) tickvalueattrs=(size=7pt) linearopts=(tickvaluepriority=true 
tickvaluelist=(5 8 10 12 14 16 18 20) viewmin=5 viewmax=20))
yaxisopts=(reverse=true type=discrete display=none labelattrs=(size=12pt)) walldisplay=none ;
entry halign=left textattrs=(color=black size=7pt) "" halign=right textattrs=(color=black size=7pt) "" /location=outside valign=bottom;
referenceline y=ref / lineattrs=(thickness=_thk color=_color);
scatterplot y=row x=mean / xerrorlower=CIL xerrorupper=CIU
sizeresponse=SquareSize sizemin=12 sizemax=18
markerattrs=(symbol=squarefilled size=3px) ERRORBARCAPSHAPE=none;
referenceline x=1/ lineattrs=(color=black thickness=.1px pattern=solid);
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
entryfootnote halign=left textattrs=(size=7) '';
endgraph;
end;
run;

proc format;
  value misblank
    . =' '
	0.00001='<0.001';
run;

/*---------*/
ods rtf file='1.rtf';
ods html close;
ods listing gpath="C:\Users\USER\OneDrive - The University of Sydney (Staff)\analysis plan + mock up papers\WARC\Output" image_dpi=300;
ods graphics / reset noscale IMAGEFMT=png
width=&w height=&h imagename='bfGraph';
/*--Render Forest Plot with horizontal bands--*/
ods graphics / reset width=7.5in height=5.4in imagename='KnowGRAPH' border;
proc sgrender data=Forest2 template=Forest sganno=anno ;
format  pvalue misblank.;
dynamic _color='Azure' _headercolor="lightblue" _thk=26 ;
run;
ods rtf close;

/*Figure 3: Proportion of people with smoking and antihypertensive medication*/

/*liteducation_3catw*/
proc freq data=litfactor1; 
table hewealth*bpmedm hewealthw*bpmedm liteducation_3cat*bpmedm liteducation_3catw*bpmedm/
 nocol nopercent ;run;

 proc freq data=litfactor1; 
table hewealthw*smoke_2cat liteducation_3catw*smoke_2cat/
 nocol nopercent ;run;

proc glimmix data=litfactor1;
Ods output OddsRatios=OddsRatios ParameterEstimates=ParameterEstimates;
class hewealthw (ref=first);
model smoke_2cat (ref="2") = hewealthw age asex location bmi_2cat incCtry/ dist=binary link=logit ddfm=bw solution oddsratio  or(label);
random commid / solution;
run;

data OddsRatios;
set OddsRatios;
or_ci=catt(put(Estimate ,4.2)," (", put(Lower,4.2),", ", put(Upper,4.2), ')');
keep label estimate lower upper or_ci;
run;

/*data OddsRatios;*/
/*set OddsRatios;*/
/**/
/*if _n_ in (1,2);*/
/**/
/*run;*/

proc print data=OddsRatios;run;

/*hewealthw*/
proc glimmix data=litfactor1;
Ods output OddsRatios=OddsRatios ParameterEstimates=ParameterEstimates;
class liteducation_3catw (ref=first);
model smoke_2cat (ref="2") = liteducation_3catw age asex location bmi_2cat incCtry/ dist=binary link=logit ddfm=bw solution oddsratio  or(label);
random commid / solution;
run;

data OddsRatios;
set OddsRatios;
or_ci=catt(put(Estimate ,4.2)," (", put(Lower,4.2),", ", put(Upper,4.2), ')');
keep label estimate lower upper or_ci;
run;

/*data OddsRatios;*/
/*set OddsRatios;*/
/**/
/*if _n_ in (1,2);*/
/**/
/*run;*/
/*litw_3cat*/

proc print data=OddsRatios;run;
proc freq data=check1;table litw_3cat pct33wealthc educ ;run;
proc freq data=litfactor1;where smoke_2cat ne .; table lit_3cat;run;
