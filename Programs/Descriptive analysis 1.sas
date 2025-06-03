/***************************************************Feburary 3 2023************************************/
/****************************This program has a mix of proc steps and data steps**********************/

options nofmterr nodate nonumber orientation=landscape ;
%include "W:\PURE\PURE Diabetes\6. Analysis\Derived data programs\format.sas";
%include "W:\PURE\PURE Diabetes\6. Analysis\Derived data programs\AllFUFormats.sas";
%include "W:\PURE\PURE Diabetes\6. Analysis\Derived data programs\demographics_format.sas";
%include "W:\PURE\PURE Diabetes\6. Analysis\Derived data programs\formatAdult2.sas";
%include "W:\PURE\PURE Diabetes\6. Analysis\Derived data programs\medications_format.sas";
%include "W:\PURE\PURE Diabetes\6. Analysis\Derived data programs\format.sas";
%include "W:\PURE\PURE Diabetes\6. Analysis\Derived data programs\AllFUFormats.sas";
%include "W:\PURE\PURE Diabetes\6. Analysis\Derived data programs\demographics_format.sas";
%include "W:\PURE\PURE Diabetes\6. Analysis\Derived data programs\formatAdult2.sas";
%include "W:\PURE\PURE Diabetes\6. Analysis\Derived data programs\medications_format.sas";
%include "W:\PURE\PURE DATA 2021\Format\heartfailureadj_Format.sas";
%include "W:\PURE\PURE DATA 2021\Format\kidneyadj_Format.sas";
%include "W:\PURE\PURE DATA 2021\Format\mandatoryhouseholdvisit_Format.sas";
%include "W:\PURE\PURE DATA 2021\Format\mandatoryindividualvisit_Format.sas";
%include "W:\PURE\PURE DATA 2021\Format\MandatoryMemberStatusUpdate_Format.sas";
%include "W:\PURE\PURE DATA 2021\Format\memberlist_Format.sas";
%include "W:\PURE\PURE DATA 2021\Format\myocardialinfarction_Format.sas";
%include "W:\PURE\PURE DATA 2021\Format\myocardialinfarctionadj_Format.sas";
%include "W:\PURE\PURE DATA 2021\Format\nonrome_Format.sas";
%include "W:\PURE\PURE DATA 2021\Format\optionalhouseholdvisit_Format.sas";
%include "W:\PURE\PURE DATA 2021\Format\optionalindividualvisit_Format.sas";
%include "W:\PURE\PURE DATA 2021\Format\strokeadj_Format.sas";
%include "W:\PURE\PURE DATA 2021\Format\verbalautopsyquestionnaire_Format.sas";

libname cov 'W:\PURE\PUREDATA_AUGUST2022\medication_Simone';
libname cov1 'C:\WARC';
libname exp 'W:\PURE\PURE DATA OCT2021';
libname out 'W:\PURE\PUREDATA_AUGUST2022\medication_Simone';

/*format for knowledge/literacy related variables*/
proc format;
value yesnof
				0 = 'None'
				1 = 'No'
				2 = 'Yes'
				3 = 'Unsure'
				;
value yesno
				1 = "yes"
				0 = "no"
				;
value countryf 1="India"
                2="China"
                3="South Africa"
                4="Colombia"
                5="UAE"
                6="Zimbabwe"
                7="Brazil"
                8="Sweden"
                9="Chile"
               10="Iran"
               11="Canada"
               12="Argentina"
               13="Poland"
               14="Malaysia"
               15="Bangladesh"
               16="Turkey"
               17="Pakistan"
               18="Tanzania"
               19="Palestine"
               20="Saudi Arabia"
               21="Philippines"
               22="Uruguay"
               23="Peru"
               24="Russia"
               25="Kazakhstan"
               26="Kyrgyzstan"
               27="Sudan"
               28="Ecuador";
value bmi_2catf 
				1="<30 kg/m2"
				2=">=30 kg/m2";
value cvd_years_4catf
				1="< 1 year"
				2="1-3 years"
				3="3-5 years"
				4=">5 years";	
value htn_years_4catf
				1="< 1 year"
				2="1-3 years"
				3="3-5 years"
				4=">5 years";	
value stroke_years_4catf
				1="< 1 year"
				2="1-3 years"
				3="3-5 years"
				4=">5 years";	
run;

/*macro to do a frequency table by country variable*/
 ods rtf file = "3.Descriptive frequencies by country.rtf";
%macro my_crosstab(table, vars);
  %local i;
  %do i = 1 %to %sysfunc(countw(&vars));
    %let var = %scan(&vars, &i);
    proc freq data=&table;
      table &var*country ;
      format _NUMERIC_ yesnof. country countryf.;
    run;
  %end;
%mend my_crosstab;

%my_crosstab(test2, eheclund ehehdis ehediab ehestrok ehearth ehelucan ehemocan ehehdnsm eheprebi ehelbirw edomexe eeatmfru eeatmgve eeatmmea edrkmcof eeatmdpr eeatmfis esmoking eredfatm eredsalt egainwgt)
ods rtf close;


/*age*/ /*age is to reported as a continuous variable in the Table 1, so no changes needed*/

proc sort data=test2;by country;run;

symbol color = salmon h = .8;
goptions ftext=swiss;
axis1 minor=none color=black label=(angle=90 rotate=0);
title �Box Plots�;

proc boxplot data=test2;
title1 "Mean age of participants across countries";
plot age*country /cframe = vligb
cboxes = dagr
cboxfill = ywh
vaxis = axis1;
run;

proc boxplot data=test2;
title1 "Mean age of participants across countries";
plot bmi*country /cframe = vligb
cboxes = dagr
cboxfill = ywh
vaxis = axis1;
run;

proc sgplot data=test2;
where age ne .;
title1 "Mean Age of participants across countries";
hbox age / category=country group=location groupdisplay=cluster;
run;

proc sgplot data=test2;
where bmi ne .;
title1 "Mean BMI of participants across countries";
hbox bmi / category=country group=location groupdisplay=cluster;
run;

/*other variables by countries*/
ods rtf file = "Nice figures for health literacy variables by countries.rtf";
%let var = eheclund ehehdis ehediab ehestrok ehearth ehelucan ehemocan ehehdnsm eheprebi ehelbirw 
edomexe eeatmfru eeatmgve eeatmmea edrkmcof eeatmdpr eeatmfis esmoking eredfatm eredsalt egainwgt;

%macro mymacro;
	%do i=1 %to 21;
	%let varname = %scan(&var,&i);
	title "Descriptive charateristics for variable: &varname";
	proc sgplot data=test2 noborder;
	  vbar country / response=%scan(&var,&i) stat=PERCENT group=%scan(&var,&i)
	           seglabel datalabel
	          baselineattrs=(thickness=0)
	          outlineattrs=(color=cx3f3f3f);
	  xaxis display=(nolabel noline noticks);
	  yaxis display=(noline noticks) grid;
	  format &var yesnof.;
	run;
%end;
%mend;
%mymacro;
ods rtf close;

/*Just showing the total count for each variable across countries*/
%let var = eheclund ehehdis ehediab ehestrok ehearth ehelucan ehemocan ehehdnsm eheprebi ehelbirw edomexe eeatmfru eeatmgve eeatmmea edrkmcof eeatmdpr eeatmfis esmoking eredfatm eredsalt egainwgt;
%macro mymacro;
	%do i=1 %to 15;
	%let varname = %scan(&var,&i);
	title "Descriptive charateristics for variable: &varname";
	proc sgplot data=test2 noborder;
	  vbar country / response=%scan(&var,&i) stat=precent /*group=%scan(&var,&i)*/
	           seglabel datalabel
	          baselineattrs=(thickness=0)
	          outlineattrs=(color=cx3f3f3f);
	  xaxis display=(nolabel noline noticks);
	  yaxis display=(noline noticks) grid;
	run;
%end;
%mend;
%mymacro;


data test3;
set test2;

if ADCHDY ne . then do;
	if ADCHDY <1 then cvd_years_4cat =1;
	else if  1<= ADCHDY <3 then cvd_years_4cat =2;
	else if  3<= ADCHDY <5 then cvd_years_4cat =3;
	else if ADCHDY >=5 then cvd_years_4cat =4;
end;
else do CVD_years_4cat=.;end;

if ADSTROKY ne . then do;
	if ADSTROKY <1 then stroke_years_4cat =1;
	else if  1<= ADSTROKY <3 then stroke_years_4cat =2;
	else if  3<= ADSTROKY <5 then stroke_years_4cat =3;
	else if ADSTROKY >=5 then stroke_years_4cat =4;
end;
else do stroke_years_4cat=.;end;

if ADHYPEY ne . then do;
	if ADHYPEY <1 then htn_years_4cat =1;
	else if  1<= ADHYPEY <3 then htn_years_4cat =2;
	else if  3<= ADHYPEY <5 then htn_years_4cat =3;
	else if ADHYPEY >=5 then htn_years_4cat =4;
end;
else do htn_years_4cat=.;end;

/*obesity*/
if bmigrp2 in (1,2) then bmi_2cat =1;
else if bmigrp2 in (3) then bmi_2cat=2;

format bmi_2cat bmi_2catf. bpmedm yesno. 
htn_years_4cat htn_years_4catf.
cvd_years_4cat cvd_years_4catf.
stroke_years_4cat cvd_years_4catf.
;
run;

proc sort data=test3;by hhid;run;
proc print data=test3 (obs=100);var hhid;run;

/*checking duplicates using nodupkey*/
proc sort data=test3 nodupkey;
   by hhid;
run; /*log says 0 observations with duplicates*/

/*Seems like there is only one individual per household in epoch2; 
therefore household size variable is not required*/
data test3; set test3;
	 by hhid; 
	if last.hhid;
	hhnumb=count;
	label hhnumb="number of individual living in the household";
	     
	     if hhnumb<2 then hhnumb5 = 0;
	     else hhnumb5 =1;
	  label hhnumb5=">=2 people living in the household";
	     format hhnumb5 yesno.; 
run;
proc freq data=test3; table hhnumb5;run;

proc means data=test3 n nmiss;var eheclund ehehdis ehediab ehestrok ehearth ehelucan ehemocan ehehdnsm eheprebi ehelbirw; run;
proc means data=test3 n nmiss;var edomexe eeatmfru eeatmgve eeatmmea edrkmcof eeatmdpr eeatmfis esmoking eredfatm eredsalt egainwgt;run;

proc means data =test3 n nmiss;var
/*variables to include: 
/*CVD*/
severeCVD fatalCVD CVD 
/*Stroke*/
newStrk 
/*Heart failure*/
newhf 
fatalhf 
nofatalhf 
/*MI*/
newmi 
fatalmi 
nofatalmi 
;run;

/*Not including occupation in the analysis*//*not strong reason to include from a causal point of view
also occupation variable is bit hard to classify across countries*/
proc freq data=test3;table AMOCUPG;run;
proc freq data=test3;table cvd_years_4cat htn_years_4cat bmigrp2 bmi_2cat bpmedm;run;

proc freq data=test3;table eheclund ehehdis ehediab ehestrok ehearth ehelucan ehemocan ehehdnsm eheprebi ehelbirw 
edomexe eeatmfru eeatmgve eeatmmea edrkmcof eeatmdpr eeatmfis esmoking eredfatm eredsalt egainwgt;run;

proc freq data=test3;table 
/*household id*/ /*one individual per household* checking for nodupkey by hhid above*/
/*age*/
/*Gender*/ asex
/*Education*/ educ
/*Smoking*/ smoke1yr
/*number of household members*/
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
/*BMI*/ bmigrp2 bmi_2cat
/*Number of household members*/ /*probably not, number of household members have nothing to do with either the eposure or outcome variables*/
/*Urban/rural setting*/ location
/*Occupation*/ /*occupgrp/*AMOCUPG*/ /*which group describes your main occupation*/ /*occupation would be hard to classify therefore not used in this analysis*/
/*AINCOME /*how much do you earn on average in a month?*/ /*this uses $CHAR50. string format*//*need to convert that to numeric format*/
;
run;

/*specify the tables for these variable*/
data test3;
set test3;
label 
/*Gender*/ asex = "Gender"
/*Education*/ educ = "Education level"
/*Smoking*/ smoke1yr = "Smoking status"
/*number of household members*/
/*Setting/rurality*/ location = "Urban and rural setting"
/*country - high, middle,low income*/ incCtry = "Geographic regions"
country = "Country"
/*Number of years since cardiovascular disease */ 
/*CVD*/ cvd_years_4cat = "Number of years since cardiovascular disease"
/*HTN*/ htn_years_4cat = "Number of years since hypertension"
/*Previous hypertension*/ ADHYPE = "Previous hypertension"
/*Previous coronary artery disease*/ ADCHD = "Previous coronary heart disease"
/*Previous stroke*/ ADSTROK = "Previous stroke"
/*Hypertension*/hyp = "Hypertension"
/*Taking BP lowering medication*/ bpmedm = "Taking BP lowering medication"
/*Diabetes*/ ADDIAB = "Diabetes"
/*Cholesterol*//*mean SD*/  ADMEDCLD " Taking Cholesterol lowering medication"
/*BMI*/ bmi_2cat = "Obesity";
run;


/*remove none '0' from all of the knowledge variables*/
data test4;
  set test3;
  if heclund ne 0 and 
ehehdis ne 0 and 
ehediab ne 0 and ehestrok ne 0 and ehearth ne 0 
and ehelucan ne 0 and ehemocan ne 0 and 
ehehdnsm ne 0 and eheprebi ne 0 and ehelbirw ne 0 
and edomexe ne 0 and eeatmfru ne 0 and eeatmgve ne 0 
and eeatmmea ne 0 and edrkmcof ne 0 and eeatmdpr ne 0 
and eeatmfis ne 0 and esmoking ne 0 and eredfatm ne 0 
and eredsalt ne 0 and egainwgt ne 0;
run;

ods rtf file ="Descriptives.rtf";
proc freq data=test5;table eheclund ehehdis ehediab ehestrok ehearth ehelucan ehemocan ehehdnsm eheprebi ehelbirw 
edomexe eeatmfru eeatmgve eeatmmea edrkmcof eeatmdpr eeatmfis esmoking eredfatm eredsalt egainwgt;run;
ods rtf close;

%let var = eheclund ehehdis ehediab ehestrok ehearth ehelucan ehemocan ehehdnsm eheprebi ehelbirw 
edomexe eeatmfru eeatmgve eeatmmea edrkmcof eeatmdpr eeatmfis esmoking eredfatm eredsalt egainwgt;

/*apply format to all the variables in Q8 and Q18 variables*/
/* Define a macro to apply a Yes/No format to a list of variables */
%macro format_yesno(varlist);
  /* Define a Yes/No format */
  proc format;
    value yesnof
		1 = 'No'
		2 = 'Yes'
		3 = 'Unsure'
		. = 'Missing'
		;
  /* Apply the format to the variables in the list */
  data test5;
    set test4;
    format &varlist yesnof.;
  run;
%mend;
/* Call the macro with a list of variables */
%format_yesno(heclund ehehdis ehediab ehestrok ehearth ehelucan ehemocan ehehdnsm eheprebi ehelbirw edomexe eeatmfru eeatmgve eeatmmea edrkmcof eeatmdpr eeatmfis esmoking eredfatm eredsalt egainwgt);

/*Apply labels for variables*/
data test6;
attrib 
/*Gender*/ asex label = "Gender"
/*Education*/ educ label = "Education level"
/*Smoking*/ smoke1yr label= "Smoking status"
/*Number of household members*/
/*Setting/rurality*/ location label= "Urban and rural setting"
/*country - high, middle,low income*/ incCtry label= "Country classification"
country label= "Country"
/*Number of years since cardiovascular disease */ /*CVD*/ cvd_years_4cat label= "Number of years since cardiovascular disease"
/*HTN*/ htn_years_4cat label= "Number of years since hypertension"
/*Previous hypertension*/ ADHYPE label= "Previous hypertension"
/*Previous coronary artery disease*/ ADCHD label= "Previous coronary heart disease"
/*Previous stroke*/ ADSTROK label= "Previous stroke"
/*Hypertension*/hyp label= "Hypertension" 
/*Taking BP lowering medication*/ bpmedm label= "Taking BP lowering medication"
/*Diabetes*/ ADDIAB label= "Diabetes"
/*Cholesterol*//*mean SD*/  ADMEDCLD label= "Taking Cholesterol lowering medication"
/*BMI*/ bmi_2cat label= "Obesity";
set test5;
run;

proc freq data=test6;table bmi_2cat;run;

proc freq data=freq1;table variable;run;

data Freq2;
set Freq1;
/*Gender*/ if variable ="asex" then label = "Gender";
run;


/*macro to loop through all the variables*/
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
proc freq data=test6 order=internal;
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

ods rtf file="C:\Users\smis5930\OneDrive - The University of Sydney (Staff)\Desktop\Results\Descriptive_&var..rtf";
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
%tabb (egainwgt);
%tabb (eheclund);
%tabb (ehehdis); 
%tabb (ehediab); 
%tabb (ehestrok); 
%tabb (ehearth); 
%tabb (ehelucan); 
%tabb (ehemocan); 
%tabb (ehehdnsm); 
%tabb (eheprebi); 
%tabb (ehelbirw); 
%tabb (edomexe); 
%tabb (eeatmfru); 
%tabb (eeatmgve); 
%tabb (eeatmmea); 
%tabb (edrkmcof); 
%tabb (eeatmdpr); 
%tabb (eeatmfis); 
%tabb (esmoking); 
%tabb (eredfatm); 
%tabb (eredsalt); 
%tabb (egainwgt); 

/*check*/
proc freq data=test6;table eheclund;run;
