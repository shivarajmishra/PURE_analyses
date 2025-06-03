
/****************************************************/
/*************************Table 1*********************/
/****************************************************/

ods rtf file="Table 1 Baseline characteristics.rtf";
proc freq data=test7;table 
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
/nocol ;
run;
ods rtf close;

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
table %scan(&crossvar,&i)/out=CrossTabFreqs;
run;

data CrossTabFreqs;
set CrossTabFreqs;
variable=&crossvar;
run;

data CrossTabFreqs;
set CrossTabFreqs;
variable=scan(table,2,"*");
categories=vvalue(%scan(&crossvar,&i));
n_freq=catt(put(count,8.0)," (", put(percent,4.2),")");
run;

data Freq1;
set Freq1 CrossTabFreqs ;
run;

%end;
%mend;
%crosstab;

ods rtf file="C:\Users\smis5930\OneDrive - The University of Sydney (Staff)\Desktop\Results\Table 1 Descriptive_&var..rtf";
proc report headline headskip; 
where &var ne . and colpercent ne .; 
title "Descriptive table for variable: &var";
column variable categories &var , n_freq chisq;
define variable /"Variable" group width=20 order=data;
define Categories /"&var" group width=20 order=data;
define n_freq/ " n (%) " group width=20;
break after variable/skip;
run;
ods rtf close;

proc means data=test7 mean median p25 p75 std ;var age bmi;run;



proc freq data=check1;table smoke_2cat;run;

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
proc freq data=check1 order=internal;
where smoke_2cat  ne .;
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
%tabb (smoke_2cat);

proc ttest data=check1;var bmi;class smoke_2cat;run;
proc means data=check1 mean std median range p25 p75;var age bmi;class smoke_2cat; run;
