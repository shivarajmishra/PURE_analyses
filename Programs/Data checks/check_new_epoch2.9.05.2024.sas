
/*2. use libname statement to assign folder*/
/*libname fmtlib "Z:\PURE DATA JAN2024\Raw_data\Format_Catalogs";/*

/*3. include these lines at the top of your program*/
/*option fmtsearch = (fmtlib.epochbgd2formats);*/

/*Data checks*/
options nofmterr;
libname check1 '\PURE Health Literacy\Analysis\Data';
libname check3 'Z:\PURE DATA JAN2024\Raw_data\SAS_Datasets\EPOCH';

proc format;
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

				value ctryf
				1="Bangladesh"
				2	="India"
				3=	"Pakistan"
				4	="China"
				5	="Malaysia"
				6	="Philippines"
				7	="SouthAfrica"
				8	="Tanzania"
				9	="Zimbabwe"
				10	="Canada"
				11	="Sweden"
				12	="Poland"
				13	="Turkey"
				14	="Iran"
				15	="UAE"
				16	="Palestine"
				17	="SaudiArabia"
				18	="Argentina"
				19	="Brazil"
				20	="Colombia"
				21	="Chile"
				22	="Peru"
				23	="Russia"
				24	="Kazakhstan"
				25=	"Kyrgyzstan"
				26	="Sudan"
				27=	"Uruguay"
				28	="Ecuador"
				30	="Germany"
;
run;

/*Old program borrowed from Simone*/
/*proc sort data=rawdata.comb out=allhouse;by hhid;run;*/
/*data check1;set rawdata.epochfinal;run; /*this does not have the variables I need*/

/*EPOCH data*/
data check1 (rename=(idno=idias)
keep=id epochid idno centid houseid commid subjid country ehearth eheclund ehediab ehehdis ehehdnsm ehelbirw ehelucan ehemocan eheprebi ehestrok 
edomexe edrkmcof eeatmdpr eeatmfis eeatmfru eeatmgve eeatmmea esmoking eredfatm eredsalt eredsalt egainwgt)
;
set check3.complete_epoch2;run;

/*Base adults*/
data check2 (rename=(idno=idias));
set check1.base_adult;run ;

/*Follw up events*/
data check3 (rename=(idno=idias));
set check1.followupevents_12aug2022;run;

/*base_adult_august2022*/
/*Base adults*/

data check21 (keep=
hhid centid commid ncommid subjid epochid
idias
key_centid
key_commid
key_country
key_hhid

age
asex
educ
location
incCtry ctry country GDPctry
smoke1yr
bmi bmigrp2
location
ADCHD ADCHDY ADHYPE ADHYPEY ADSTROK ADSTROKY
hyp
bpmedm ADDIAB
ADMEDCLD
AMOCUPG
);
set check2;
run;
proc sort data=check21;by idias; run;

/***************************************************************/
/*******************Data merging procedure*********************/
/*************************************************************/
/*codes from Simone to check with proc sort and combine the datasets together*/
proc sort data=check1; by idias; run;
proc sort data=check3; by idias; run;
proc sort data=check21 out=adult; by idias; run;

data test;
merge adult check1(in=inepoch); by idias;
if inepoch;
run;

data test2_a;
  merge check3 test (in=infu); by idias;
  if infu;
run;

proc means data =test2_a n nmiss;var
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
nofatalmi;run;

proc freq data=test2_a; table country;run;
proc contents data=check1;run;

title "New dataset";
proc freq data=test2_a;where country NE 30; table eheclund ehehdis*bpmedm  ehediab ehestrok ehearth ehelucan ehemocan ehehdnsm eheprebi ehelbirw 
edomexe eeatmfru eeatmgve eeatmdpr eeatmfis  eredfatm eredsalt;run;



/**CHECK OlD Dataset**/
/*EPOCH data*/
data check1 (rename=(idno=idias)
keep=id epochid idno centid houseid commid subjid country ehearth eheclund ehediab ehehdis ehehdnsm ehelbirw ehelucan ehemocan eheprebi ehestrok 
edomexe edrkmcof eeatmdpr eeatmfis eeatmfru eeatmgve eeatmmea esmoking eredfatm eredsalt eredsalt egainwgt)
;
set check1.epoch2;run;

/*Base adults*/
data check2 (rename=(idno=idias));
set check1.base_adult;run ;

/*Follw up events*/
data check3 (rename=(idno=idias));
set check1.followupevents_12aug2022;run;

/*base_adult_august2022*/
/*Base adults*/

data check21 (keep=
hhid centid commid ncommid subjid epochid
idias
key_centid
key_commid
key_country
key_hhid

age
asex
educ
location
incCtry ctry country GDPctry
smoke1yr
bmi bmigrp2
location
ADCHD ADCHDY ADHYPE ADHYPEY ADSTROK ADSTROKY
hyp
bpmedm ADDIAB
ADMEDCLD
AMOCUPG
);
set check2;
run;
proc sort data=check21;by idias; run;

/***************************************************************/
/*******************Data merging procedure*********************/
/*************************************************************/
/*codes from Simone to check with proc sort and combine the datasets together*/
proc sort data=check1; by idias; run;
proc sort data=check3; by idias; run;
proc sort data=check21 out=adult; by idias; run;

data test;
merge adult check1(in=inepoch); by idias;
if inepoch;
run;

data test2_b;
  merge check3 test (in=infu); by idias;
  if infu;
run;

proc means data =test2_b n nmiss;var
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
nofatalmi;run;

proc freq data=test2_b; table country;run;
proc contents data=check1;run;

title "Old dataset";
%let vars=eheclund ehehdis ehediab ehestrok ehearth ehelucan ehemocan ehehdnsm eheprebi ehelbirw 
edomexe eeatmfru eeatmgve eeatmdpr eeatmfis  eredfatm eredsalt;
%macro my_crosstab;
%do i=1 %to 17;
proc freq data=test2_b;where country NE 30; table %scan(&vars,&i)*bpmedm/nocol nopercent;run;
%end;
%mend;
%my_crosstab;


title "New dataset";
%let vars=eheclund ehehdis ehediab ehestrok ehearth ehelucan ehemocan ehehdnsm eheprebi ehelbirw 
edomexe eeatmfru eeatmgve eeatmdpr eeatmfis  eredfatm eredsalt;
%macro my_crosstab;
%do i=1 %to 17;
proc freq data=test2_a;where country NE 30; table %scan(&vars,&i)*bpmedm/nocol nopercent;run;
%end;
%mend;
%my_crosstab;

proc freq data=test2_a;table country;run;
proc freq data=test2_b;table country;run;

/*rename dataset test2_b into test2*/
data test2;set test2_a;if country NE 30;run;

proc freq data=test2_a;table country*eredsalt;run;
proc freq data=test2_b;table country*eredsalt;run;

proc freq data=test2_a;table country*eeatmfru;run;
proc freq data=test2_b;table country*eeatmfru;run;

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


 /*Which datasets to use to define the outcome varialbe*/
/*%macro my_crosstab(table, vars);*/
/*  proc freq data=&table;*/
/*    tables &vars / missing noprint totpct ;*/
/*    format _NUMERIC_ yesnof.;*/
/*	output out=my_output;*/
/*  run;*/
/*%mend my_crosstab;*/
/*%my_crosstab(test2, eheclund ehehdis ehediab ehestrok ehearth ehelucan ehemocan ehehdnsm eheprebi ehelbirw edomexe eeatmfru eeatmgve eeatmmea edrkmcof eeatmdpr eeatmfis esmoking eredfatm eredsalt egainwgt)*/

ods rtf file = "1.Output for literacy variables.rtf";
proc freq data=test2; table eheclund ehehdis ehediab ehestrok ehearth ehelucan ehemocan ehehdnsm eheprebi ehelbirw edomexe eeatmfru eeatmgve
 eeatmmea edrkmcof eeatmdpr eeatmfis esmoking eredfatm eredsalt egainwgt;
format _NUMERIC_ yesnof.;run;
ods rtf close;

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

/*not including occupation in the analysis*//*not strong reason to include from a causal point of view
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
data test6; /*12510*/
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

ods rtf file="C:\Users\USER\OneDrive - The University of Sydney (Staff)\Desktop\Results\Descriptive_&var..rtf";
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

proc freq data=test6;table eheclund;run;

/*Figure: sgplot for knowledge variable Q8 by countries*/
/*other variables by countries Q8*/
%let var = eheclund ehehdis ehediab ehestrok ehearth ehelucan ehemocan ehehdnsm eheprebi ehelbirw;
%macro mymacro;
	%do i=1 %to 10;
	%let varname = %scan(&var,&i);
	ods listing gpath="C:\Users\smis5930\OneDrive - The University of Sydney (Staff)\Desktop\Results";
	ods graphics /imagename="Hist_Knowledge_&varname";
	ods graphics / width=7in height=5in;
	title1 "Q8. Health effects and diseases caused by smoking cigarettes";
	title2 "Variable: &varname";
	proc sgplot data=test6 noborder;
	  vbar country / response=%scan(&var,&i) stat=PERCENT group=%scan(&var,&i)
	           datalabel 
	          baselineattrs=(thickness=0)
	          outlineattrs=(color=cx3f3f3f);
	  xaxis display=(nolabel noline noticks);
	  yaxis display=(noline noticks) grid label="% of total participants";
	  format &var yesnof. &varname yesnof.;
	run;
%end;
%mend;
%mymacro;

/*Figure: sgplot for knowledge variable Q8 by countries*/

/*other variables by countries Q8*/
%let var = edomexe eeatmfru eeatmgve eeatmmea edrkmcof eeatmdpr eeatmfis esmoking eredfatm eredsalt egainwgt;
%macro mymacro;
	%do i=1 %to 11;
	%let varname = %scan(&var,&i);
	ods listing gpath="C:\Users\smis5930\OneDrive - The University of Sydney (Staff)\Desktop\Results";
	ods graphics /imagename="Hist_Knowledge_&varname";
	ods graphics / width=7in height=5in;
	title1 "Q18. Actions to prevent/stop a person from having a heart attack or stroke" ;
	title2 "Variable: &varname";
	proc sgplot data=test6 noborder;
	  vbar country / response=%scan(&var,&i) stat=PERCENT group=%scan(&var,&i)
	           datalabel 
	          baselineattrs=(thickness=0)
	          outlineattrs=(color=cx3f3f3f);
	  xaxis display=(nolabel noline noticks);
	  yaxis display=(noline noticks) grid label="% of total participants";
	  format &var yesnof. &varname yesnof. ;
	run;
%end;
%mend;
%mymacro;

dm 'clear log';

/*CVD events across knowledge variable*/
data test7;
set test6;

if severeCVD=. then SevereCVD_2cat=0;
else SevereCVD_2cat=1;

run;

proc freq data=test7;table SevereCVD_2cat;run;

/*now saving the dataset*/
data check1.pure_literacy_new;
set test7;run;

proc sort data=test7;by ehelbirw;run;
proc freq data=test7 noprint;
by ehelbirw;                    /* X categories on BY statement */
tables SevereCVD_2cat / out=FreqOut;    /* Y (stacked groups) on TABLES statement */
run;

data FreqOut1; set FreqOut; format percent f4.2;run;

/*other variables by countries Q8*/
%let var = eheclund ehehdis ehediab ehestrok ehearth ehelucan ehemocan ehehdnsm eheprebi ehelbirw;
%macro mymacro;
	%do i=1 %to 10;
	%let varname = %scan(&var,&i);

	proc sort data=test7;by &varname;run;
	proc freq data=test7 noprint;
	by &varname;                    /* X categories on BY statement */
	tables SevereCVD_2cat / out=FreqOut;    /* Y (stacked groups) on TABLES statement */
	run;

	data FreqOut1; set FreqOut; format percent f4.2;run;

	ods listing gpath="C:\Users\smis5930\OneDrive - The University of Sydney (Staff)\Desktop\Results";
	ods graphics /imagename="CVD_&varname";
	ods graphics / width=6in height=4in;
	title1 "Q8. Health effects and diseases caused by smoking cigarettes";
	title2 "&varname";
	proc sgplot data=FreqOut1 noborder ;
	  vbar %scan(&var,&i)/ response=Percent group=SevereCVD_2cat groupdisplay=stack
	           seglabel 
	          baselineattrs=(thickness=0)
	          outlineattrs=(color=cx3f3f3f);
	  xaxis display=(noline noticks);
	  yaxis display=(noline noticks) grid label="% of Total Within Group";
	  format ehelbirw yesnof. percent f4.2 SevereCVD_2cat yesno.;
	run;
%end;
%mend;
%mymacro;

/*Figure: sgplot for knowledge variable Q8 by countries*/

/*other variables by countries Q8*/
%let var = edomexe eeatmfru eeatmgve eeatmmea edrkmcof eeatmdpr eeatmfis esmoking eredfatm eredsalt egainwgt;
%macro mymacro;
	%do i=1 %to 11;
	%let varname = %scan(&var,&i);

	proc sort data=test7;by &varname;run;
	proc freq data=test7 noprint;
	by &varname;                    /* X categories on BY statement */
	tables SevereCVD_2cat / out=FreqOut;    /* Y (stacked groups) on TABLES statement */
	run;

	data FreqOut1; set FreqOut; format percent f4.2;run;

	ods listing gpath="C:\Users\smis5930\OneDrive - The University of Sydney (Staff)\Desktop\Results";
	ods graphics /imagename="CVD_&varname";
	ods graphics / width=6in height=4in;
	title1 "Q18. Actions to prevent/stop a person from having a heart attack or stroke";
	title2 "&varname";
	proc sgplot data=FreqOut1 noborder ;
	  vbar %scan(&var,&i)/ response=Percent group=SevereCVD_2cat groupdisplay=stack
	           seglabel 
	          baselineattrs=(thickness=0)
	          outlineattrs=(color=cx3f3f3f);
	  xaxis display=(noline noticks);
	  yaxis display=(noline noticks) grid label="% of Total Within Group";
	  format ehelbirw yesnof. percent f4.2 SevereCVD_2cat yesno.;
	run;
%end;
%mend;
%mymacro;


proc freq data=test7;table SevereCVD_2cat asex
newstrk newhf;run;

/*FU /*HV informative FU*//*this variable is available in the follow up dataset*/

	/*total household nubmer*/ /*hhnumb*/
	/*count hhids to figure out household size*/ /*this can be done in any dataset I guess*//*go with base_adult*/

	/*sevCVD*/
	/*kidney*/
	/*nfstroke*/
	/*nfhf*/
	/*nfmi*/
	/*fatalCVD*/
	/*nwdeath*/

Follow up data for calculation of person years /*_days*/
/*all cause mortality for availabiilty of medicines, adjusted for wealth index, age, 

/*********************Health literacy **********************/
/*I suppose epoch2 is the datasets to use for defining health literacy variable*/


/*factor analysis for literacy variable*/
ods rtf file = "2.Factor analysis for literacy variables Q 8 and 18 EPOCH2.rtf";
proc factor data = check1 corr scree ev method = principal ;
var ehearth eheclund ehediab ehehdis ehehdnsm ehelbirw ehelucan ehemocan eheprebi ehestrok 
edomexe edrkmcof eeatmdpr eeatmfis eeatmfru eeatmgve eeatmmea esmoking eredfatm eredsalt eredsalt egainwgt;
run;
ods rtf close;

data litfactor; set litp;
litgn=Factor1;
keep idias country litgn ehearth eheclund ehediab ehehdis ehehdnsm ehelbirw ehelucan ehemocan eheprebi ehestrok 
edomexe edrkmcof eeatmdpr eeatmfis eeatmfru eeatmgve eeatmmea esmoking eredfatm eredsalt eredsalt egainwgt;
proc sort; by idias;
run;

proc means data=litfactor maxdec=1; class country;var litgn; run;  
proc rank data=litfactor out=litfactor01 Groups=5;
var litgn;
ranks lit_5cat;
run;

proc sort data=merged;by idias country;run;
proc sort data=check2;by idias country;run;
proc sort data=check3;by idias country;run;
proc sort data=litfactor01;by idias country;run;
data merged_lit;
  merge litfactor01 check2 check3 ;
  by idias country;
run;

proc freq data=merged_lit;table lit_5cat;run;
proc print data=merged_lit (obs=100) ; where lit_5cat ne .; var age asex educ location idias id centid country epochid commid eheclund severeCVD fatalCVD CVD newStrk newhf fatalhf nofatalhf newmi fatalmi nofatalmi lit_5cat;run;
proc means data=merged_lit n nmiss;var:; run;
proc means data=merged_lit;var:;run;

proc print data=merged_lit (obs=3000);var hhid key_hhid idias; where hhid ne .;run;

proc contents data=merged_lit;run;


proc sort data=merged_lit;by hhid;run;
data merged_lit1; set merged_lit;
	 by hhid; 
	if last.hhid;
	hhnumb=count;
	label hhnumb="number of individual living in the household";
	     
	     if hhnumb<2 then hhnumb5 = 0;
	     else hhnumb5 =1;
	  label hhnumb5=">=2 people living in the household";
	     format hhnumb5 yesno.; 
run;
proc freq data=merged_lit1;table hhnumb5;run;
proc print data=merged_lit1 (obs=3000);var hhid key_hhid idias hhnumb; where hhid ne .;run;

proc print data=merged_lit1; var:; where ehearth ne .;run;

