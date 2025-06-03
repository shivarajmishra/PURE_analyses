/*Feburary 3 2023*/
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

/*Old program borrowed from Simone*/
/*proc sort data=rawdata.comb out=allhouse;by hhid;run;*/
/*data check1;set rawdata.epochfinal;run; /*this does not have the variables I need*/

/*EPOCH data*/
data check1 (rename=(idno=idias)
keep=id epochid idno centid houseid commid subjid country ehearth eheclund ehediab ehehdis ehehdnsm ehelbirw ehelucan ehemocan eheprebi ehestrok 
edomexe edrkmcof eeatmdpr eeatmfis eeatmfru eeatmgve eeatmmea esmoking eredfatm eredsalt eredsalt egainwgt)
;
set exp.epoch2;run;

/*Base adults*/
data check2 (rename=(idno=idias));
set cov1.base_adult;run ;

/*Follw up events*/
data check3 (rename=(idno=idias));
set out.followupevents_12aug2022;run;

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

data test2;
  merge check3 test (in=infu); by idias;
  if infu;
run;

proc means data =test2 n nmiss;var
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


