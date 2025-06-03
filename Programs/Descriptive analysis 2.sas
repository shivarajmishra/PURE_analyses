/*********************************************************************************************************/
/***********************Descriptive analysis - checking hypertension related variables*******************/
/********************************macro to loop through all the variables********************************/
/*****************************This program has a mix of proc steps and data steps**********************/


/*We start with dataset test7, look for this datastep in previous syntax*/
data test7;
set cov1.pure_literacy;run;

proc contents data=test7;run;

proc freq data=test7;table ADHYPE hyp ADHYPEY;run;
proc freq data=test7;table ADHYPE*hyp;run;

proc format;
value htn_4catf
	1 = 'Previous hypertension + hypertension now'
	2 = 'Previous hypertension + no hypertension now'
	3 = 'No previous hypertension + hypertension now'
	4 = 'No previous hypertension + no hypertension now'
;
run;

proc freq data=test8; table ADHYPE*hyp htn_4cat*hyp htn_4cat*ADHYPE;run;

proc contents data=test8;run;

data test8;
set test7;
/*cross stratified categories between previous hypertension and 
hypertension now*/
if ADHYPE = 2 & hyp =1 then htn_4cat=1;
else if ADHYPE = 2 & hyp =0 then htn_4cat=2;
else if ADHYPE = 1 & hyp =1 then htn_4cat=3;
else if ADHYPE = 1 & hyp =0 then htn_4cat=4;
format htn_4cat hyp ADHYPE;
;
run;
 
proc freq data=test8; table ADHYPE hyp htn_4cat*ehehdis htn_4cat*edomexe;
format htn_4cat htn_4catf.;run;
proc print data=test8 (obs=100); var ADHYPE hyp htn_4cat;run;

proc freq data=test8;table country;run;
proc freq data=test8;table country commid;run;

/*taking bp lowering medication*/
proc freq data=test8;table bpmedm;run;

proc freq data=test8;table edomexe*bpmedm ehehdis*bpmedm/ chisq;
format htn_4cat htn_4catf.;run;

proc contents data=exp.epoch2;run;

data test8;
set test8;
format hyp SevereCVD_2cat bpmedm yesno.;run;
proc freq data=test8;table hyp SevereCVD_2cat bpmedm;run;

/*********************************************************************************************************/
/*We will be using access to hypertensive medication as the first analysis (intermediate pathway I guess*/
/********************************macro to loop through all the variables********************************/
%macro tabb (var);
%let crossvar=
/*q8*/
eheclund
ehehdis
ehediab
ehestrok
ehearth
ehelucan
ehemocan
ehehdnsm
eheprebi
ehelbirw

/*q18*/
edomexe
eeatmfru
eeatmgve
eeatmmea
edrkmcof
eeatmdpr
eeatmfis
esmoking
eredfatm
eredsalt
egainwgt
;

data freq1;
set _null_;
run;

%macro crosstab;
%do i=1 %to 21;
proc freq data=test8 order=internal;
ods output CrossTabFreqs=CrossTabFreqs;
table &var*%scan(&crossvar,&i)/chisq;
output out=ChiSqData n nmiss pchi lrchi;
format &var yesno.;
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


data freq1 (rename=(var21=variable));
set freq1;
length var1-var21 $200;
var1 = tranwrd(variable, "eheclund", "8a)Chronic lung disease");
var2 = tranwrd(var1, "ehehdis", "8b)Heart disease");
var3 = tranwrd(var2, "ehediab", "8c)Diabetes");
var4 = tranwrd(var3, "ehestrok", "8d)Stroke");
var5 = tranwrd(var4, "ehearth", "8e)Arthritis");
var6 = tranwrd(var5, "ehelucan", "8f)Lung cancer");
var7 = tranwrd(var6, "ehemocan", "8g)Mouth and throat cancer");
var8 = tranwrd(var7, "ehehdnsm", "8h)Heart disease in non-smokers exposed");
var9 = tranwrd(var8, "eheprebi", "8i)Premature birth with smoking during pregnancy");
var10 = tranwrd(var9, "ehelbirw", "8j)Low birth weight babies with smoking");
var11 = tranwrd(var10, "edomexe", "18a)Doing more exercise");
var12 = tranwrd(var11, "eeatmfru", "18b)Eating more fruit");
var13 = tranwrd(var12, "eeatmgve", "18c)Eat more green vegetables");
var14 = tranwrd(var13, "eeatmmea", "18d)Eat more meat");
var15 = tranwrd(var14, "edrkmcof", "18e)Drinking more coffee");
var16 = tranwrd(var15, "eeatmdpr", "18f)Eating more dairy products");
var17 = tranwrd(var16, "eeatmfis", "18g)Eating more fish");
var18 = tranwrd(var17, "esmoking", "18h)Smoking");
var19= tranwrd(var18, "eredfatm", "18i)Reducing fat in meals");
var20 = tranwrd(var19, "eredsalt", "18j)Reducing salt in meals");
var21 = tranwrd(var20, "egainwgt", "18k)Gaining weight");
drop var1-var20 variable;
run;

%end;
%mend;
%crosstab;

ods rtf file="C:\Users\smis5930\OneDrive - The University of Sydney (Staff)\Desktop\PURE analysis\Analysis_by_Outcome_&var..rtf";
proc report headline headskip; 
where &var ne . and colpercent ne .; 
title "Descriptive table for variable: &var";
column variable categories &var , n_freq chisq;
define variable /"Variable" group width=20 order=data;
define Categories /"&var" group width=20 order=data;
define &var /"Descriptive table for variable: &var" group across order=data;
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
%tabb (hyp);
%tabb (SevereCVD_2cat); 

proc freq data=test8;table bpmedm hyp SevereCVD_2cat;run;

/*Apparently there is interesting and important associations between 
health literacy variables and bpmedm, hyp*/

/*so we will *bpmedm as an outcome for further analysis*/

/*Analysis 1: individual association of knowledge questions and bpmedm*/

/*****************ANALYSIS METHODS*********************************/
/*Do a cumulative score of knowledge questions*/
/*Use further analysis to reduce demensions of knowledge questions*/

%let var_k= eheclund
ehehdis
ehediab
ehestrok
ehearth
ehelucan
ehemocan
ehehdnsm
eheprebi
ehelbirw

/*q18*/
edomexe
eeatmfru
eeatmgve
eeatmmea
edrkmcof
eeatmdpr
eeatmfis
esmoking
eredfatm
eredsalt
egainwgt;
%macro recordme;
%do i=1 %to 21;
data test9 (keep = %scan(&var_k,&i)_2cat, id) ;
set test8;

if %scan(&var_k,&i)=2 then %scan(&var_k,&i)_2cat=1;
else if %scan(&var_k,&i) in (1,3,0) then %scan(&var_k,&i)_2cat=0;

format &var_k yesno.;
run;

proc sort data=test9;by id;run;
proc sort data=test8; by id;run;

data test10;
merge test9 test8;
by id;

%end;
%mend;
%recordme;



