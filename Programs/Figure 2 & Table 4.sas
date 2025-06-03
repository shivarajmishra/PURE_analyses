/******************************************************************************************/
/***************************This program has a mix of proc and data steps*****************/
/**********************************Figure 2 and Table 4**********************************/


libname ab "C:\Users\USER\OneDrive - The University of Sydney (Staff)\analysis plan + mock up papers\Data";
options nofmterr nodate nonumber orientation=landscape ;
%include "C:\Users\USER\OneDrive - The University of Sydney (Staff)\analysis plan + mock up papers\WARC\PURE Health Literacy\Analysis\Derived data programs from Simone\format.sas";
%include "C:\Users\USER\OneDrive - The University of Sydney (Staff)\analysis plan + mock up papers\WARC\PURE Health Literacy\Analysis\Derived data programs from Simone\AllFUFormats.sas";
%include "C:\Users\USER\OneDrive - The University of Sydney (Staff)\analysis plan + mock up papers\WARC\PURE Health Literacy\Analysis\Derived data programs from Simone\demographics_format.sas";
%include "C:\Users\USER\OneDrive - The University of Sydney (Staff)\analysis plan + mock up papers\WARC\PURE Health Literacy\Analysis\Derived data programs from Simone\formatAdult2.sas";
%include "C:\Users\USER\OneDrive - The University of Sydney (Staff)\analysis plan + mock up papers\WARC\PURE Health Literacy\Analysis\Derived data programs from Simone\medications_format.sas";
%include "C:\Users\USER\OneDrive - The University of Sydney (Staff)\analysis plan + mock up papers\WARC\PURE Health Literacy\Analysis\Derived data programs from Simone\format.sas";
%include "C:\Users\USER\OneDrive - The University of Sydney (Staff)\analysis plan + mock up papers\WARC\PURE Health Literacy\Analysis\Derived data programs from Simone\AllFUFormats.sas";
%include "C:\Users\USER\OneDrive - The University of Sydney (Staff)\analysis plan + mock up papers\WARC\PURE Health Literacy\Analysis\Derived data programs from Simone\demographics_format.sas";
%include "C:\Users\USER\OneDrive - The University of Sydney (Staff)\analysis plan + mock up papers\WARC\PURE Health Literacy\Analysis\Derived data programs from Simone\formatAdult2.sas";
%include "C:\Users\USER\OneDrive - The University of Sydney (Staff)\analysis plan + mock up papers\WARC\PURE Health Literacy\Analysis\Derived data programs from Simone\medications_format.sas";

options nofmterr;
data test7;set check1.pure_literacy;run;
proc freq data=test7;table country;run;
proc freq data=test7;table country;run;
proc print data=test7 (obs=1000);where country in ('Philipines','Tanzania');var country incCtry;run;
proc freq data=test7;table  ehehdis*bpmedm ehehdis_2cat*bpmedm/chisq or;run;
proc freq data=test7;table hyp*bpmedm; format _all_;run;


/*********************Table 4 results from regression analysis******************************/
/******************************************************************************************/

/*lets make two scores, first base on Q8: 10 questions, second based on Q18: 11 questions*/

%let vars=
 eheclund ehehdis ehediab ehestrok ehearth ehelucan ehemocan ehehdnsm eheprebi ehelbirw 
edomexe eeatmfru eeatmgve eeatmdpr eeatmfis  eredfatm eredsalt ;
%macro my_crosstab;
%do i=1 %to 17;

    data test7;
	set test7;

	if %scan(&vars,&i) =0 then %scan(&vars,&i)_2cat=.;
	else if %scan(&vars,&i) in (1,3) then %scan(&vars,&i)_2cat=0;
	else if %scan(&vars,&i) eq 2 then %scan(&vars,&i)_2cat=1;

    format %scan(&vars,&i)_2cat yesno. %scan(&vars,&i) yesnof.;

    run;
  %end;
%mend;
%my_crosstab;

/*for four variables from Q18 reversing the scoring, i.e. those saying 1 = 'no' have better health literacy*/
%let vars=
 eeatmmea edrkmcof esmoking egainwgt;
%macro my_crosstab;
%do i=1 %to 4;

    data test7;
	set test7;

	if %scan(&vars,&i) =0 then %scan(&vars,&i)_2cat=.;
	else if %scan(&vars,&i) in (2,3) then %scan(&vars,&i)_2cat=0;
	else if %scan(&vars,&i) eq 1 then %scan(&vars,&i)_2cat=1;

    format %scan(&vars,&i)_2cat yesno. %scan(&vars,&i) yesnof.;

    run;
  %end;
%mend;
%my_crosstab;

proc format;
value knowledgef
1= "HL yes"
0 = "HL no"
;run; 

%let vars= eheclund ehehdis ehediab ehestrok ehearth ehelucan ehemocan ehehdnsm eheprebi ehelbirw 
edomexe eeatmfru eeatmgve eeatmmea edrkmcof eeatmdpr eeatmfis esmoking eredfatm eredsalt egainwgt;
%macro myfreq;
%do i=1 %to 21;
proc freq data=test7;table 
%scan(&vars,&i) %scan(&vars,&i)_2cat;
format %scan(&vars,&i)_2cat knowledgef. %scan(&vars,&i) yesnof.;
run;
%end;
%mend;


%myfreq;

proc freq data=test7;table eheclund;run;

/*lets make two scores, first base on Q8: 10 questions, second based on Q18: 11 questions*/
data test8;
set test7;

if eheclund_2cat ne . and  
ehehdis_2cat ne . and 
ehediab_2cat ne . and 
ehestrok_2cat ne . and 
ehearth_2cat ne . and  
ehelucan_2cat ne . and  
ehemocan_2cat ne . and  
ehehdnsm_2cat ne . and  
eheprebi_2cat ne . and  
ehelbirw_2cat  ne . and 
edomexe_2cat  ne . and 
eeatmfru_2cat  ne . and 
eeatmgve_2cat  ne . and 
eeatmmea_2cat  ne . and 
edrkmcof_2cat  ne . and 
eeatmdpr_2cat  ne . and 
eeatmfis_2cat  ne . and 
esmoking_2cat  ne . and 
eredfatm_2cat  ne . and 
eredsalt_2cat  ne . and 
egainwgt_2cat ne .;

/*complete case analysis*/

kscore1=sum(eheclund_2cat, ehehdis_2cat, ehediab_2cat, ehestrok_2cat, ehearth_2cat, ehelucan_2cat, ehemocan_2cat, ehehdnsm_2cat, eheprebi_2cat, ehelbirw_2cat);
kscore2=sum(edomexe_2cat, eeatmfru_2cat, eeatmgve_2cat, eeatmmea_2cat, edrkmcof_2cat, eeatmdpr_2cat, eeatmfis_2cat, esmoking_2cat, eredfatm_2cat, eredsalt_2cat, egainwgt_2cat);
kscore_all=kscore1+kscore2;
run;

proc univariate data=test8;var kscore1 kscore2 kscore_all;run;

proc freq data=test8; table 
/*Number of years since cardiovascular disease */ /*CVD*/ cvd_years_4cat*hyp  /*HTN*/ htn_years_4cat
/*Previous hypertension*/ ADHYPE*hyp 
/*Previous coronary artery disease*/ ADCHD*hyp 
/*Previous stroke*/ ADSTROK*hyp 
/*Hypertension*/hyp*cvd 
/*Taking BP lowering medication*/ bpmedm
/*severe CVD*/ severeCVD
/*CVD*/ CVD
/*severe cvd 2cat*/ SevereCVD_2cat
;run;

proc freq data=test8; table cvd cvd1;run;

/*There are 576 people with severe cvd, 1039 with composite of all cvd,
 131 with previous stroke, 398 with previous CHD, 1886 with previous hypertension*/

data test8a;
set test8;

if CVD = 1 then cvd_2cat=1;
else cvd_2cat=0;

hcvd=cvd_2cat+hyp; /**those with hypertension or current cvd*/

if hcvd in (1,2) then hcvd_2cat=1;
else hcvd_2cat=0;
run;

proc freq data=test8a;table hcvd hcvd_2cat;run;

/*knowledge score 1*/
/*trying with glm first*/
proc glm data=test8a  PLOTS(MAXPOINTS= none);
class incCtry;
model bpmedm=kscore1 incCtry hyp ;
random  incCtry;
run;

data test8;
set test8a;
if hcvd=0 then delete;
run;

proc freq data=test8;table asex;run;
proc freq data=test8;table hcvd hcvd_2cat bpmedm;run;

/*going with logistic regression analysis*/
proc logistic data = test8a ;
  model bpmedm (event='yes') = kscore1 incCtry hyp ;
  output out = m2 p = prob xbeta = logit;
  ods output ParameterEstimates = model_ks;
run;

proc sort data = m2;
  by incCtry;
run;
/*now cool plots*/
symbol1 i = join v=star l=32  c = black;
symbol2 i = join v=circle l = 1 c=black;
proc gplot data = m2;
  plot logit*incCtry = kscore1;
  plot prob*incCtry = kscore1;
run;
quit;

/*now going with logistic regression analysis*/
/*knowledge score 2*/
proc logistic data = test8 ;
  model bpmedm (event='yes') = kscore2 incCtry ;
  output out = m2 p = prob xbeta = logit;
  ods output ParameterEstimates = model_ks;
run;

proc sort data = m2;
  by incCtry;
run;
/*now cool plots*/
symbol1 i = join v=star l=32  c = black;
symbol2 i = join v=circle l = 1 c=black;
proc gplot data = m2;
  plot logit*incCtry = kscore2;
  plot prob*incCtry = kscore2;
run;
quit;

/*knowledge score all*/
proc logistic data = test8 ;
weight incCtry;
  model bpmedm (event='yes') = kscore_all incCtry ;
  output out = m2 p = prob xbeta = logit;
  ods output ParameterEstimates = model_ks;
run;

proc sort data = m2;
  by incCtry;
run;
/*now cool plots*/
symbol1 i = join v=star l=32  c = black;
symbol2 i = join v=circle l = 1 c=black;
proc gplot data = m2;
  plot logit*incCtry = kscore_all;
  plot prob*incCtry = kscore_all;
run;
quit;

/**********Frequencies of variables in Table 1**********/
/******************************************************/
proc freq data=test8;table/*Gender*/ asex
/*Education*/ educ
/*Smoking*/ smoke1yr
/*Number of household members*/
/*Setting/rurality*/ location
/*country - high, middle,low income*/ incCtry country
/*Number of years since cardiovascular disease */ /*CVD*/ cvd_years_4cat /*HTN*/ htn_years_4cat
/*Previous hypertension*/ ADHYPE
/*Previous coronary artery disease*/ ADCHD
/*Previous stroke*/ ADSTROK
/*Hypertension*/hyp 
/*Taking BP lowering medication*/ bpmedm
/*Diabetes*/ ADDIAB
/*Cholesterol*//*mean SD*/  ADMEDCLD
/*BMI*/ bmi_2cat
/*Number of household members*/ /*probably not, number of household members have nothing to do with either the eposure or outcome variables*/
/*Occupation*//*occupgrp*//*AMOCUPG*/ /*which group describes your main occupation*/ /*occupation would be hard to classify therefore not used in this analysis*/
/*AINCOME /*how much do you earn on average in a month?*/ /*this uses $CHAR50. string format*//*need to convert that to numeric format*/
/*Wealthgn*/ /*or pct33wealthc*/;run;

/***********Individual regression for Q8 (binary) and Q18 (binary) variables ********/
/***********************************************************************************/
proc contents data=test7;run;
proc freq data=test8;table eheclund_2cat ehehdis_2cat ehediab_2cat 
ehestrok_2cat ehearth_2cat ehelucan_2cat
ehemocan_2cat ehehdnsm_2cat eheprebi_2cat ehelbirw_2cat
edomexe_2cat eeatmfru_2cat eeatmgve_2cat 
eeatmmea_2cat edrkmcof_2cat eeatmdpr_2cat eeatmfis_2cat
esmoking_2cat eredfatm_2cat eredsalt_2cat egainwgt_2cat;run;

PROC surveyLOGISTIC DATA = test8; 
cluster country;

MODEL bpmedm (event='Yes' order=internal) =egainwgt_2cat /*we create lot of missing variables in egain2cat*/
age asex educ location smoke1yr 
 incCtry/LINK=LOGIT ;
run;

%let myvar=
eheclund_2cat ehehdis_2cat ehediab_2cat 
ehestrok_2cat ehearth_2cat ehelucan_2cat
ehemocan_2cat ehehdnsm_2cat eheprebi_2cat ehelbirw_2cat
edomexe_2cat eeatmfru_2cat eeatmgve_2cat 
eeatmmea_2cat edrkmcof_2cat eeatmdpr_2cat eeatmfis_2cat
esmoking_2cat eredfatm_2cat eredsalt_2cat egainwgt_2cat;

/*%macro myfreq;*/
/*%do i=1 %to 21;*/
/*proc freq data=test8;table %scan(&myvar,&i)/nocol nopercent ci;run;*/
/*%end;*/
/*%mend;*/
/*%myfreq;*/

%macro myindreg;
%do i=1 %to 21;
PROC surveyLOGISTIC DATA = test8; 
cluster country;
ods output OddsRatios=%scan(&myvar,&i) ParameterEstimates=ParameterEstimates;
CLASS  asex (ref='Male')
educ (ref='None, Primary, or Unknown') 
location (ref='Urban')
incCtry (ref='1.HIC')
/PARAM=REF order=internal;
MODEL bpmedm (event='Yes' order=internal) = %scan(&myvar,&i)
age asex educ location smoke1yr bmi_2cat incCtry/LINK=LOGIT ;
run;

data %scan(&myvar,&i)1;
set %scan(&myvar,&i);
or_ci=catt(put(OddsRatioEst,4.2)," (", put(LowerCL,4.2),", ", put(UpperCL,4.2), ')');
categories=scan(effect,2, '   ');
variable=scan(effect,1);
response="yes";
run;

data %scan(&myvar,&i)1;set %scan(&myvar,&i)1;  if _n_=1;run;

%end;
%mend;
%myindreg;

%let myvar=
eheclund_2cat ehehdis_2cat ehediab_2cat 
ehestrok_2cat ehearth_2cat ehelucan_2cat
ehemocan_2cat ehehdnsm_2cat eheprebi_2cat ehelbirw_2cat

edomexe_2cat eeatmfru_2cat eeatmgve_2cat 
eeatmmea_2cat edrkmcof_2cat eeatmdpr_2cat eeatmfis_2cat
esmoking_2cat eredfatm_2cat eredsalt_2cat egainwgt_2cat;

%macro myindreg;
%do i=1 %to 21;
data merged_all;
set 
%do  i =  1 %to &i;
%scan(&myvar,&i)1
%end;
;
run;

%end;
%mend;
%myindreg;

ods rtf file="1.rtf";
proc report data=merged_all nowd headskip;
column  effect response,(or_ci);
define effect/'Variable' group order=internal width=10;
define response/' ' across order=data;
define or_ci/'Odds Ratios (95% CI)' group width=20;
break after effect/skip;
run;
ods rtf close;

/*Apply lables for the Q8 and Q18 variables*/
/*proc format;*/
/*value $varf*/
/*	"eheclund_2cat"  ="Chronic lung disease"*/
/*	"ehehdis_2cat"	="Heart disease"*/
/*	"ehediab_2cat"	="Diabetes"*/
/*	"ehestrok_2cat" ="Stroke"*/
/*	"ehearth_2cat"	="Arthritis"*/
/*	"ehelucan_2cat"	="Lung cancer"*/
/*	"ehemocan_2cat"	="Mouth and throat cancer"*/
/*	"ehehdnsm_2cat"	="Heart disease in non-smokers exposed"*/
/*	"eheprebi_2cat"	="Premature birth with smoking during pregnancy"*/
/*	"ehelbirw_2cat"	="Low birth weight babies with smoking"*/
/*	"edomexe_2cat"	="Doing more exercise"*/
/*	"eeatmfru_2cat"	="Eating more fruit"*/
/*	"eeatmgve_2cat"	="Eat more green vegetables"*/
/*	"eeatmmea_2cat"	="Eat more meat"*/
/*	"edrkmcof_2cat"	="Drinking more coffee"*/
/*	"eeatmdpr_2cat"	="Eating more dairy products"*/
/*	"eeatmfis_2cat"	="Eating more fish"*/
/*	"esmoking_2cat"	="Smoking"*/
/*	"eredfatm_2cat"	="Reducing fat in meals"*/
/*	"eredsalt_2cat"	="Reducing salt in meals"*/
/*	"egainwgt_2cat"	="Gaining weight";*/
/*run;*/

data merged_all (rename=(effect1=effect));
set merged_all;
length effect1 $55;
	if effect ="eheclund_2cat"  then effect1="Chronic lung disease";
	else if effect ="ehehdis_2cat"	then effect1="Heart disease";
	else if effect ="ehediab_2cat"	then effect1="Diabetes";
	else if effect ="ehestrok_2cat" then effect1="Stroke";
	else if effect ="ehearth_2cat"	then effect1="Arthritis";
	else if effect ="ehelucan_2cat"	then effect1="Lung cancer";
	else if effect ="ehemocan_2cat"	then effect1="Mouth and throat cancer";
	else if effect ="ehehdnsm_2cat"	then effect1="Heart disease in non-smokers exposed";
	else if effect ="eheprebi_2cat"	then effect1="Premature birth with smoking during pregnancy";
	else if effect ="ehelbirw_2cat"	then effect1="Low birth weight babies with smoking";
	else if effect ="edomexe_2cat"	then effect1="Doing more exercise";
	else if effect ="eeatmfru_2cat"	then effect1="Eating more fruit";
	else if effect ="eeatmgve_2cat"	then effect1="Eat more green vegetables";
	else if effect ="eeatmmea_2cat"	then effect1="Reduced meat intake (R)";
	else if effect ="edrkmcof_2cat"	then effect1="Drinking less coffee (R)";
	else if effect ="eeatmdpr_2cat"	then effect1="Eating more dairy products";
	else if effect ="eeatmfis_2cat"	then effect1="Eating more fish";
	else if effect ="esmoking_2cat"	then effect1="Quit smoking (R)";
	else if effect ="eredfatm_2cat"	then effect1="Reducing fat in meals";
	else if effect ="eredsalt_2cat"	then effect1="Reducing salt in meals";
	else if effect ="egainwgt_2cat"	then effect1="Reduce weight (R)";
drop effect;
run;

ods rtf file="1.rtf";
proc print data=merged_all;run;
ods rtf close;

data merged_all1 (rename=(OddsRatioEst=mean LowerCL=CIL UpperCL=CIU or_ci=meanCI));
length effect $200;
;set merged_all;run;

proc print data=merged_all;run;
***
/**********************************************************************************/
/********Figure 2 ranking individual regression for Q8 and Q18 variables**********/
/********************************************************************************/
%let dpi=300;
%let w=5.5in;
%let h=3.0in;

data rowt;set merged_all1; if _n_ in (1:10) then type=1;else type=2;run;

proc sort data=rowt;by type mean;run;


data rowt(rename=(mean1=mean CIL1=CIL CIU1=CIU));
set rowt;
row = _n_;

mean1 = input(mean, 8.3);
CIL1  = input(CIL , 8.3);
CIU1 = input(CIU, 8.3);

if mean1 not in (.,1) then do;
Squaresize=1/(((log(CIU1) - log(mean1))/1.96)**2);

se=(log(CIU1)-log(CIL1))/3.92;
z=log(mean1)/se;
z1 = input(z, 8.3);
pvalue=exp(-0.717*z1 - 0.416*z1**2);
indent=1;

if pvalue <0.001 then do; pvalue=0.00001;end;
end;
drop mean CIL CIU;
run;

data row1;
  set rowt;
  if _n_=1 then
    do;   
      effect='Health effect of smoking';
      mean= "";
      CIL="";
      CIU="";
      meanCI=""; pvalue="";end;
      output;

run;

data SubgroupData;
  set row1;
  output;

  if _n_=10 then
    do;
      effect='Actions to prevent CVD';
      mean= "";
      CIL="";
      CIU="";
      meanCI=""; pvalue="";
      output;
    end;
run;

data SubgroupData;
set SubgroupData;

row=_n_;

if row=14 then delete;
run;


data SubgroupData1;set SubgroupData; 
indent=1; 
if effect in ('Health effect of smoking','Actions to prevent CVD') then do;
indent=0; end;
drop categories variable response;run;

/*--Used for Subgroup labels in column 1--*/
data anno(drop=indent);
set SubgroupData1(keep=row effect indent rename=(row=y1));
retain Function 'Text ' ID 'id1' X1Space 'DataPercent'
Y1Space 'DataValue ' x1 x2 2 TextSize 7 Width 100 Anchor 'Left ';
if indent;
label = tranwrd(effect, '>=', '(*ESC*){Unicode ''2265''x}');
run;


data forest2(drop=flag);
set SubgroupData1 nobs=nobs;
Head = not indent;
retain flag 2;
if head then flag = mod(flag + 1, 2);
if flag then ref=row;
if indent then effect = ' ';
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
entry textattrs=(size=8 weight=bold) halign=left "Health Literacy";
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
axistable y=row value=effect / indentweight=indent 
display=(values) textgroup=type;
endlayout;

/*--Sixth column showing PCIGroup--*/
 layout overlay / x2axisopts=(display=none)
 yaxisopts=(reverse=true type=discrete display=none) walldisplay=none;
 referenceline y=ref / lineattrs=(thickness=_thk color=_color);
 axistable y=row value=meanCI / display=(values);
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
ods rtf file='Knowledgegraph.rtf';
ods html close;
ods listing gpath="C:\Users\USER\OneDrive - The University of Sydney (Staff)\analysis plan + mock up papers\WARC\Output" image_dpi=&dpi;
ods graphics / reset noscale IMAGEFMT=png
width=&w height=&h imagename='bfGraph';
/*--Render Forest Plot with horizontal bands--*/
ods graphics / reset width=7.5in height=5.4in imagename='GRAPH' border;
proc sgrender data=Forest2 template=Forest sganno=anno ;
format  pvalue misblank.;
dynamic _color='Azure' _headercolor="lightblue" _thk=26 ;
run;
ods rtf close;

/***********Regression weighted knoweledge score ********/
/*******************************************************/
data check1;
set rowt;
est=log(mean); run;


proc print data=check1; var variable est mean effect;run;
data test9;
set test8; 

kscore_1w=(
0.364926034	*	eheclund_2cat		+
0.193124598	*	ehehdis_2cat		+
0.078819183	*	ehediab_2cat		+
0.243286146	*	ehestrok_2cat		+
0.095518042	*	ehearth_2cat		+
0.254064453	*	ehelucan_2cat		+
0.262213705	*	ehemocan_2cat		+
0.243534102	*	ehehdnsm_2cat		+
0.15715444	*	eheprebi_2cat		+
0.19368103	*	ehelbirw_2cat		
);

kscore_2w= (
0.135132651	*	edomexe_2cat		+
0.127104798	*	eeatmfru_2cat		+
0.12904506	*	eeatmgve_2cat		+
0.203032887	*	eeatmmea_2cat		+
0.117271296	*	edrkmcof_2cat		+
0.105510185	*	eeatmdpr_2cat		+
0.103461622	*	eeatmfis_2cat		+
0.246498581	*	esmoking_2cat		+
0.246252312	*	eredfatm_2cat		+
0.248708736	*	eredsalt_2cat		+
0.27989498	*	egainwgt_2cat		
); 

kscore_allw=kscore_1w+kscore_2w;
run;

proc means data=test9;var kscore_allw;run;

proc glm data=test9  PLOTS(MAXPOINTS= none);
class incCtry;
model bpmedm=kscore_1w incCtry hyp ;
random  incCtry;
run;

/*going with logistic regression analysis*/
proc logistic data = test9 ;
  model bpmedm (event='yes') = kscore_allw incCtry hyp ;
  output out = m2 p = prob xbeta = logit;
  ods output ParameterEstimates = model_ks;
run;

/***********Stratified analysis using knoweledge scores (3 categories)/***********/
/***********/***********educaiton and wealth************************************/

proc rank data=test9 out=litfactor01 Groups=3;
var kscore_all;
ranks lit_3cat;
run;

proc rank data=litfactor01 out=litfactor02 Groups=3;
var kscore_allw;
ranks litw_3cat;
run;

proc freq data=litfactor02;table lit_3cat*bpmedm litw_3cat*bpmedm/nocol nopercent ci;run;

proc format;
value litf
0 = 'Low health literacy'
1= 'Moderate health literacy'
2= 'High health literacy'
;run;

proc logistic data = litfactor02 ;
  model bpmedm (event='yes') = lit_3cat incCtry hyp ;
  output out = m2 p = prob xbeta = logit;
  ods output ParameterEstimates = model_ks;
run;

proc contents data=litfactor02;run;

data windex; set ab.windex;   keep idno wealthgn pct33wealthc   ; run;
data windex2; set ab.Windex_pct20;   keep idno    pct20wealthc; run;
proc freq data=windex;table pct33wealthc;run;
proc print data=windex (obs=100);var idno wealthgn pct33wealthc ;run;
proc print data=litfactor02 (obs=100);var idias bpmedm ;run;
data windex1 (rename=(idno=idias));set windex;run;

proc sort data=litfactor02;by idias;run;
data litfactor03;
merge windex1 litfactor02(in=inepoch); by idias;
if inepoch;
run;

proc freq data=litfactor03;
table epochid;
run;

proc freq data =litfactor03;table pct33wealthc educ litw_3cat lit_3cat;run;


data litfactor04;
set litfactor03;

/*combined variable of HE and education*/
if lit_3cat = 0 then do;
	if educ = 1 then liteducation_3cat=1;
	else if educ = 2 then liteducation_3cat=2;
	else if educ = 3 then liteducation_3cat=3;
end;

if lit_3cat = 1 then do;
	if educ = 1 then liteducation_3cat=4;
	else if educ = 2 then liteducation_3cat=5;
	else if educ = 3 then liteducation_3cat=6;
end;

if lit_3cat = 2 then do;
	if educ = 1 then liteducation_3cat=7;
	else if educ = 2 then liteducation_3cat=8;
	else if educ = 3 then liteducation_3cat=9;
end;


/*combined variable of HE and wealth*/

if lit_3cat = 0 then do;
	if pct33wealthc = 1 then hewealth=1;
	else if pct33wealthc= 2 then hewealth=2;
	else if pct33wealthc = 3 then hewealth=3;
end;

if lit_3cat = 1 then do;
	if pct33wealthc = 1 then hewealth=4;
	else if pct33wealthc = 2 then hewealth=5;
	else if pct33wealthc = 3 then hewealth=6;
end;

if lit_3cat = 2 then do;
	if pct33wealthc = 1 then hewealth=7;
	else if pct33wealthc= 2 then hewealth=8;
	else if pct33wealthc = 3 then hewealth=9;
end;

/*for regression weighted litfactor*/
/**********************************/

if litw_3cat = 0 then do;
	if educ = 1 then liteducation_3catw=1;
	else if educ = 2 then liteducation_3catw=2;
	else if educ = 3 then liteducation_3catw=3;
end;

if litw_3cat = 1 then do;
	if educ = 1 then liteducation_3catw=4;
	else if educ = 2 then liteducation_3catw=5;
	else if educ = 3 then liteducation_3catw=6;
end;

if litw_3cat = 2 then do;
	if educ = 1 then liteducation_3catw=7;
	else if educ = 2 then liteducation_3catw=8;
	else if educ = 3 then liteducation_3catw=9;
end;


/*combined variable of HE and wealth*/

if litw_3cat = 0 then do;
	if pct33wealthc = 1 then hewealthw=1;
	else if pct33wealthc = 2 then hewealthw=2;
	else if pct33wealthc = 3 then hewealthw=3;
end;

if litw_3cat = 1 then do;
	if pct33wealthc = 1 then hewealthw=4;
	else if pct33wealthc = 2 then hewealthw=5;
	else if pct33wealthc = 3 then hewealthw=6;
end;

if litw_3cat = 2 then do;
	if pct33wealthc = 1 then hewealthw=7;
	else if pct33wealthc = 2 then hewealthw=8;
	else if pct33wealthc = 3 then hewealthw=9;
end;

run;

proc freq data=litfactor04; 
table hewealth*bpmedm hewealthw*bpmedm liteducation_3cat*bpmedm liteducation_3catw*bpmedm/
 nocol nopercent ;run;

proc freq data=litfactor04; 
table litw_3cat*bpmedm lit_3cat*bpmedm
educ*bpmedm
pct33wealthc*bpmedm/
  nocol nopercent;run;

 /*macro to compute pretty tables for regression outputs*/
proc freq data=litfactor04;table pct33wealthc  hyp ADHYPE hewealthw hewealth 
hewealthw liteducation_3cat liteducation_3catw;run;


/*interaction test*/
/*health literacy and education interaction*/
PROC surveyLOGISTIC DATA = litfactor04; 
cluster country;
ods output OddsRatios=OddsRatios1 ParameterEstimates=ParameterEstimates;
CLASS  asex (ref='Male')
educ (ref='None, Primary, or Unknown') 
location (ref='Urban')
incCtry (ref='1.HIC')
/PARAM=REF order=internal;
MODEL bpmedm (event='Yes' order=internal) = litw_3cat educ  litw_3cat*educ 
age asex location smoke1yr 
ADHYPE ADCHD ADSTROK ADDIAB bmi_2cat incCtry/LINK=LOGIT  DF=INFINITy
;
run;

proc freq data=litfactor04;table country;run;

/*health literacy and wealth interaction*/
PROC surveyLOGISTIC DATA = litfactor04; 
cluster country;
ods output OddsRatios=OddsRatios1 ParameterEstimates=ParameterEstimates;
CLASS  asex (ref='Male')
educ (ref='None, Primary, or Unknown') 
location (ref='Urban')
incCtry (ref='1.HIC')
/PARAM=REF order=internal;
MODEL bpmedm (event='Yes' order=internal) = litw_3cat pct33wealthc  litw_3cat*pct33wealthc 
age asex location smoke1yr 
ADHYPE ADCHD ADSTROK ADDIAB bmi_2cat incCtry/LINK=LOGIT  DF=INFINITy
;
run;

%let myvar= hewealth hewealthw liteducation_3cat liteducation_3catw;

%macro myindreg;
%do i=1 %to 4;
PROC surveyLOGISTIC DATA = litfactor04; 
cluster country;
where hyp=1;
ods output OddsRatios=%scan(&myvar,&i) ParameterEstimates=ParameterEstimates;
CLASS  asex (ref='Male')
educ (ref='None, Primary, or Unknown') 
location (ref='Urban')
incCtry (ref='1.HIC')
%scan(&myvar,&i)(ref='1')
/PARAM=REF order=internal;
MODEL bpmedm (event='Yes' order=internal) = %scan(&myvar,&i)
age asex educ location smoke1yr 
ADHYPE ADCHD ADSTROK ADDIAB bmi_2cat incCtry/LINK=LOGIT  DF=INFINITy
;
run;

data %scan(&myvar,&i)1;
set %scan(&myvar,&i);
or_ci=catt(put(OddsRatioEst,4.2)," (", put(LowerCL,4.2),", ", put(UpperCL,4.2), ')');
categories=scan(effect,2, '   ');
variable=scan(effect,1);
response="yes";
run;

ods rtf file="%scan(&myvar,&i)1.rtf";
proc report data=%scan(&myvar,&i)1 nowd headskip;
column  variable categories response,(or_ci);
define variable/'Variable' group order=internal width=10;
define response/' ' across order=data;
define categories/ group order=internal width=5;
define or_ci/'Odds Ratios (95% CI)' group width=20;
break after variable/skip;
run;
ods rtf close;

%end;
%mend;
%myindreg;

/***********Table 4: Nested models using knowledge cats (3 categories)******** 
/***********************educaiton and wealth*********************************/

proc freq data=litfactor04; table lit_3cat;run;

/***************model1*****************/
/*************************************/
PROC surveyLOGISTIC DATA = litfactor04; 
cluster country;
ods output OddsRatios=OddsRatios ParameterEstimates=ParameterEstimates;
CLASS  asex (ref='Male') 
location (ref='Urban')
incCtry (ref='1.HIC')
lit_3cat(ref='0')
/PARAM=REF order=internal;
MODEL bpmedm (event='Yes' order=internal) = litw_3cat
age asex location smoke1yr 
ADHYPE ADCHD ADSTROK ADDIAB bmi_2cat incCtry/LINK=LOGIT  DF=INFINITy
;
run;

data OddsRatios1;
set OddsRatios;
or_ci=catt(put(OddsRatioEst,4.2)," (", put(LowerCL,4.2),", ", put(UpperCL,4.2), ')');
categories=scan(effect,2, '   ');
variable=scan(effect,1);
response="yes";
run;

ods rtf file="1.rtf";
proc report data=OddsRatios1 nowd headskip;
column  variable categories response,(or_ci);
define variable/'Variable' group order=internal width=10;
define response/' ' across order=data;
define categories/ group order=internal width=5;
define or_ci/'Odds Ratios (95% CI)' group width=20;
break after variable/skip;
run;
ods rtf close;


/*education*/
PROC surveyLOGISTIC DATA = litfactor04; 
cluster country;
ods output OddsRatios=OddsRatios ParameterEstimates=ParameterEstimates;
CLASS  asex (ref='Male')
educ (ref='None, Primary, or Unknown') 
location (ref='Urban')
incCtry (ref='1.HIC')
lit_3cat(ref='0')
/PARAM=REF order=internal;
MODEL bpmedm (event='Yes' order=internal) = educ
age asex location smoke1yr 
ADHYPE ADCHD ADSTROK ADDIAB bmi_2cat incCtry/LINK=LOGIT  DF=INFINITy
;
run;

data OddsRatios1;
set OddsRatios;
or_ci=catt(put(OddsRatioEst,4.2)," (", put(LowerCL,4.2),", ", put(UpperCL,4.2), ')');
categories=scan(effect,2, '   ');
variable=scan(effect,1);
response="yes";
run;

ods rtf file="1.rtf";
proc report data=OddsRatios1 nowd headskip;
column  variable categories response,(or_ci);
define variable/'Variable' group order=internal width=10;
define response/' ' across order=data;
define categories/ group order=internal width=5;
define or_ci/'Odds Ratios (95% CI)' group width=20;
break after variable/skip;
run;
ods rtf close;

/*wealth*/
PROC surveyLOGISTIC DATA = litfactor04; 
cluster country;
ods output OddsRatios=OddsRatios ParameterEstimates=ParameterEstimates;
CLASS  asex (ref='Male')
pct33wealthc(ref='Windex Tertile 1') 
location (ref='Urban')
incCtry (ref='1.HIC')
lit_3cat(ref='0')
/PARAM=REF order=internal;
MODEL bpmedm (event='Yes' order=internal) = pct33wealthc
age asex location smoke1yr 
ADHYPE ADCHD ADSTROK ADDIAB bmi_2cat incCtry/LINK=LOGIT  DF=INFINITy
;
run;

data OddsRatios1;
set OddsRatios;
or_ci=catt(put(OddsRatioEst,4.2)," (", put(LowerCL,4.2),", ", put(UpperCL,4.2), ')');
categories=scan(effect,2, '   ');
variable=scan(effect,1);
response="yes";
run;

ods rtf file="1.rtf";
proc report data=OddsRatios1 nowd headskip;
column  variable categories response,(or_ci);
define variable/'Variable' group order=internal width=10;
define response/' ' across order=data;
define categories/ group order=internal width=5;
define or_ci/'Odds Ratios (95% CI)' group width=20;
break after variable/skip;
run;
ods rtf close;


/***************model 2***************/
/************************************/
PROC surveyLOGISTIC DATA = litfactor04; 
cluster country;
ods output OddsRatios=OddsRatios ParameterEstimates=ParameterEstimates;
CLASS  asex (ref='Male')
educ (ref='None, Primary, or Unknown') 
location (ref='Urban')
incCtry (ref='1.HIC')
lit_3cat(ref='0')
/PARAM=REF order=internal;
MODEL bpmedm (event='Yes' order=internal) = lit_3cat educ
age asex location smoke1yr 
ADHYPE ADCHD ADSTROK ADDIAB bmi_2cat incCtry/LINK=LOGIT  DF=INFINITy
;
run;

data OddsRatios1;
set OddsRatios;
or_ci=catt(put(OddsRatioEst,4.2)," (", put(LowerCL,4.2),", ", put(UpperCL,4.2), ')');
categories=scan(effect,2, '   ');
variable=scan(effect,1);
response="yes";
run;

ods rtf file="2.rtf";
proc report data=OddsRatios1 nowd headskip;
column  variable categories response,(or_ci);
define variable/'Variable' group order=internal width=10;
define response/' ' across order=data;
define categories/ group order=internal width=5;
define or_ci/'Odds Ratios (95% CI)' group width=20;
break after variable/skip;
run;
ods rtf close;

proc freq data=litfactor04; table pct33wealthc;run;

/***************model 3**************/
PROC surveyLOGISTIC DATA = litfactor04; 
cluster country;
ods output OddsRatios=OddsRatios ParameterEstimates=ParameterEstimates;
CLASS  asex (ref='Male')
educ (ref='None, Primary, or Unknown') 
location (ref='Urban')
incCtry (ref='1.HIC')
lit_3cat(ref='0')
pct33wealthc(ref='Windex Tertile 1')
/PARAM=REF order=internal;
MODEL bpmedm (event='Yes' order=internal) = lit_3cat educ pct33wealthc
age asex location smoke1yr 
ADHYPE ADCHD ADSTROK ADDIAB bmi_2cat incCtry/LINK=LOGIT  DF=INFINITy
;
run;

data OddsRatios1;
set OddsRatios;
or_ci=catt(put(OddsRatioEst,4.2)," (", put(LowerCL,4.2),", ", put(UpperCL,4.2), ')');
categories=scan(effect,2, '   ');
variable=scan(effect,1);
response="yes";
run;

ods rtf file="3.rtf";
proc report data=OddsRatios1 nowd headskip;
column  variable categories response,(or_ci);
define variable/'Variable' group order=internal width=10;
define response/' ' across order=data;
define categories/ group order=internal width=5;
define or_ci/'Odds Ratios (95% CI)' group width=20;
break after variable/skip;
run;
ods rtf close;


/*****Heat map: showing proportion of outcome variable by combined knoweldge cats, wealth and education*/
/*********************************Showing odds ratio of '     '****************************************/

%let myvar=
eheclund_2cat ehehdis_2cat ehediab_2cat 
ehestrok_2cat ehearth_2cat ehelucan_2cat
ehemocan_2cat ehehdnsm_2cat eheprebi_2cat ehelbirw_2cat

edomexe_2cat eeatmfru_2cat eeatmgve_2cat 
eeatmmea_2cat edrkmcof_2cat eeatmdpr_2cat eeatmfis_2cat
esmoking_2cat eredfatm_2cat eredsalt_2cat egainwgt_2cat;

%macro myfreq;
%do i=1 %to 21;
proc freq data=test7;
table %scan(&myvar, &i);run;
%end;
%mend;
%myfreq;

/*****For Table 2: Model 1: unadjusted OR 95% CI*****/
/***************************************************/

%let myvar=
eheclund_2cat ehehdis_2cat ehediab_2cat 
ehestrok_2cat ehearth_2cat ehelucan_2cat
ehemocan_2cat ehehdnsm_2cat eheprebi_2cat ehelbirw_2cat
edomexe_2cat eeatmfru_2cat eeatmgve_2cat 
eeatmmea_2cat edrkmcof_2cat eeatmdpr_2cat eeatmfis_2cat
esmoking_2cat eredfatm_2cat eredsalt_2cat egainwgt_2cat;

/*%macro myfreq;*/
/*%do i=1 %to 21;*/
/*proc freq data=test8;table %scan(&myvar,&i)/nocol nopercent ci;run;*/
/*%end;*/
/*%mend;*/
/*%myfreq;*/

%macro myindreg;
%do i=1 %to 21;
PROC surveyLOGISTIC DATA = test7; 
cluster country;
ods output OddsRatios=%scan(&myvar,&i) ParameterEstimates=ParameterEstimates;
MODEL bpmedm (event='Yes' order=internal) = %scan(&myvar,&i)
/LINK=LOGIT ;
run;

data %scan(&myvar,&i)1;
set %scan(&myvar,&i);
or_ci=catt(put(OddsRatioEst,4.2)," (", put(LowerCL,4.2),", ", put(UpperCL,4.2), ')');
categories=scan(effect,2, '   ');
variable=scan(effect,1);
response="yes";
run;

data %scan(&myvar,&i)1;set %scan(&myvar,&i)1;  if _n_=1;run;

%end;
%mend;
%myindreg;

%let myvar=
eheclund_2cat ehehdis_2cat ehediab_2cat 
ehestrok_2cat ehearth_2cat ehelucan_2cat
ehemocan_2cat ehehdnsm_2cat eheprebi_2cat ehelbirw_2cat

edomexe_2cat eeatmfru_2cat eeatmgve_2cat 
eeatmmea_2cat edrkmcof_2cat eeatmdpr_2cat eeatmfis_2cat
esmoking_2cat eredfatm_2cat eredsalt_2cat egainwgt_2cat;

%macro myindreg;
%do i=1 %to 21;
data merged_all;
set 
%do  i =  1 %to &i;
%scan(&myvar,&i)1
%end;
;
run;

%end;
%mend;
%myindreg;

ods rtf file="1r.rtf";
proc report data=merged_all nowd headskip;
column  effect response,(or_ci);
define effect/'Variable' group order=internal width=10;
define response/' ' across order=data;
define or_ci/'Odds Ratios (95% CI)' group width=20;
break after effect/skip;
run;
ods rtf close;

/*Apply lables for the Q8 and Q18 variables*/
/*proc format;*/
/*value $varf*/
/*	"eheclund_2cat"  ="Chronic lung disease"*/
/*	"ehehdis_2cat"	="Heart disease"*/
/*	"ehediab_2cat"	="Diabetes"*/
/*	"ehestrok_2cat" ="Stroke"*/
/*	"ehearth_2cat"	="Arthritis"*/
/*	"ehelucan_2cat"	="Lung cancer"*/
/*	"ehemocan_2cat"	="Mouth and throat cancer"*/
/*	"ehehdnsm_2cat"	="Heart disease in non-smokers exposed"*/
/*	"eheprebi_2cat"	="Premature birth with smoking during pregnancy"*/
/*	"ehelbirw_2cat"	="Low birth weight babies with smoking"*/
/*	"edomexe_2cat"	="Doing more exercise"*/
/*	"eeatmfru_2cat"	="Eating more fruit"*/
/*	"eeatmgve_2cat"	="Eat more green vegetables"*/
/*	"eeatmmea_2cat"	="Eat more meat"*/
/*	"edrkmcof_2cat"	="Drinking more coffee"*/
/*	"eeatmdpr_2cat"	="Eating more dairy products"*/
/*	"eeatmfis_2cat"	="Eating more fish"*/
/*	"esmoking_2cat"	="Smoking"*/
/*	"eredfatm_2cat"	="Reducing fat in meals"*/
/*	"eredsalt_2cat"	="Reducing salt in meals"*/
/*	"egainwgt_2cat"	="Gaining weight";*/
/*run;*/

data merged_all (rename=(effect1=effect));
set merged_all;
length effect1 $55;
	if effect ="eheclund_2cat"  then effect1="Chronic lung disease";
	else if effect ="ehehdis_2cat"	then effect1="Heart disease";
	else if effect ="ehediab_2cat"	then effect1="Diabetes";
	else if effect ="ehestrok_2cat" then effect1="Stroke";
	else if effect ="ehearth_2cat"	then effect1="Arthritis";
	else if effect ="ehelucan_2cat"	then effect1="Lung cancer";
	else if effect ="ehemocan_2cat"	then effect1="Mouth and throat cancer";
	else if effect ="ehehdnsm_2cat"	then effect1="Heart disease in non-smokers exposed";
	else if effect ="eheprebi_2cat"	then effect1="Premature birth with smoking during pregnancy";
	else if effect ="ehelbirw_2cat"	then effect1="Low birth weight babies with smoking";
	else if effect ="edomexe_2cat"	then effect1="Doing more exercise";
	else if effect ="eeatmfru_2cat"	then effect1="Eating more fruit";
	else if effect ="eeatmgve_2cat"	then effect1="Eat more green vegetables";
	else if effect ="eeatmmea_2cat"	then effect1="Reduced meat intake (R)";
	else if effect ="edrkmcof_2cat"	then effect1="Drinking less coffee (R)";
	else if effect ="eeatmdpr_2cat"	then effect1="Eating more dairy products";
	else if effect ="eeatmfis_2cat"	then effect1="Eating more fish";
	else if effect ="esmoking_2cat"	then effect1="Quit smoking (R)";
	else if effect ="eredfatm_2cat"	then effect1="Reducing fat in meals";
	else if effect ="eredsalt_2cat"	then effect1="Reducing salt in meals";
	else if effect ="egainwgt_2cat"	then effect1="Reduce weight (R)";
drop effect;
run;

data merged_all1 (rename=(OddsRatioEst=mean LowerCL=CIL UpperCL=CIU or_ci=meanCI));
length effect $200;
;set merged_all;run;

proc print data=merged_all;run;


/**********Table 1 - charateristics************/
/*********************************************/
%macro tabb (var);
%let crossvar=
/*Gender*/ asex
/*Education*/ educ
/*Smoking*/ smoke1yr
/*Number of household members*/
/*Setting/rurality*/ location
/*country - high, middle,low income*/ incCtry country
/*Number of years since cardiovascular disease */ /*CVD*/ cvd_years_4cat /*HTN*/ htn_years_4cat
/*Previous hypertension*/ ADHYPE
/*Previous coronary artery disease*/ ADCHD
/*Previous stroke*/ ADSTROK
/*Hypertension*/hyp 
/*Taking BP lowering medication*/ bpmedm
/*Diabetes*/ ADDIAB
/*Cholesterol*//*mean SD*/  ADMEDCLD
/*BMI*/ bmi_2cat
/*Number of household members*/ /*probably not, number of household members have nothing to do with either the eposure or outcome variables*/
/*Occupation*//*occupgrp*//*AMOCUPG*/ /*which group describes your main occupation*/ /*occupation would be hard to classify therefore not used in this analysis*/
/*AINCOME /*how much do you earn on average in a month?*/ /*this uses $CHAR50. string format*//*need to convert that to numeric format*/
/*Wealthgn*/ /*or pct33wealthc*/
;

data freq1;
set _null_;
run;

%macro crosstab;
%do i=1 %to 16;
proc freq data=test7 order=internal;
ods output CrossTabFreqs=CrossTabFreqs;
table &var*%scan(&crossvar,&i)/chisq;
output out=ChiSqData n nmiss pchi lrchi;
format &var yesnof.;
run;
ods output close;

  /* Extract chi-square value from dataset using PROC SQL */
proc sql noprint;
  select P_PCHI into :chisqval
  from ChiSqData;
quit;

data CrossTabFreqs;
set CrossTabFreqs;
variable=scan(table,2,"*");
categories=vvalue(%scan(&crossvar,&i));
n_freq=catt(put(frequency,8.0)," (", put(colpercent,4.2),")");
chisq=&chisqval; /* add chi-square value to dataset */
run;

proc sort data=CrossTabFreqs;by chisq;run;
data CrossTabFreqs;
  set CrossTabFreqs;
  by chisq;
  if first.chisq ne 1 then chisq = .;
  /* Keep only the first unique value of chisq, set others to missing */

  if chisq ne . then do;
  	 if chisq <0.0001 then chisq="0.0001";
	end;
run;

data Freq1;
set Freq1 CrossTabFreqs ;
run;

data freq1 (rename=(var16=variable));
set freq1;
length var1-var16 $100;
var1 = tranwrd(variable, "asex", "Gender");
var2 = tranwrd(var1, "educ", "Education level");
var3 = tranwrd(var2, "smoke1yr", "Smoking status");
var4 = tranwrd(var3, "location", "Urban and rural setting");
var5 = tranwrd(var4, "incCtry", "Country classification");
var6 = tranwrd(var5, "country", "Country");
var7 = tranwrd(var6, "cvd_years_4cat", "Number of years since cardiovascular disease");
var8 = tranwrd(var7, "htn_years_4cat", "Number of years since hypertension");
var9 = tranwrd(var8, "ADHYPE", "Previous hypertension");
var10 = tranwrd(var9, "ADCHD", "Previous coronary heart disease");
var11 = tranwrd(var10, "ADSTROK", "Previous stroke");
var12 = tranwrd(var11, "hyp", "Hypertension");
var13 = tranwrd(var12, "bpmedm", "Taking BP lowering medication");
var14 = tranwrd(var13, "ADDIAB", "Diabetes");
var15 = tranwrd(var14, "ADMEDCLD", "Taking Cholesterol lowering medication");
var16 = tranwrd(var15, "bmi_2cat", "Obesity");

drop var1-var15 variable;
run;

%end;
%mend;
%crosstab;

ods rtf file="1.rtf";
proc report headline headskip; 
where &var ne . and colpercent ne .; 
title "Descriptive table for variable: &var";
column variable categories &var , n_freq chisq;
define variable /"Variable" group width=20 order=data;
define Categories /"&var" group width=20 order=data;
define &var /"study" group across order=data;
define n_freq/ " n (%) " group width=20;
  compute chisq;
    chisq=" ";
  endcomp;
  compute after;
    line chisq $;
  endcomp;
break after variable/skip;
run;
ods rtf close;
%mend;
%tabb (bpmedm);

proc ttest data=test7;var age bmi;class bpmedm;run;
proc means data=test7 mean std median range p25 p75;var age bmi;class bpmedm; run;
proc freq data=test7;table bpmedm;run;
proc freq data=test8;table bpmedm;run;
proc freq data=test9;table bpmedm;run;



