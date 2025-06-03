

/*Data checks*/
options nofmterr;
libname check1 'V:\PURE\PURE-BE-EPOCH_Photo\3. Data\Raw data';
libname check2 'V:\PURE\PUREDATA_AUGUST2022\medication_Simone';

options nofmterr;
/*new data from Simone*/
libname check3 'Z:\PURE DATA JAN2024\Raw_data\SAS_Datasets\EPOCH';
libname check4 '\PURE Health Literacy\Analysis\Data';

data check1;
set check3.complete_epoch2;
run;

data check2;
set check4.base_adult;
run;

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
               28="Ecuador"
			   30="Germany"
			   999="Overall Total";
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

proc contents data=check1;
proc freq data=check1;table country;format country countryf.;run;

proc freq data=check2;table country;format country countryf.;run;


libname cov 'V:\PURE\PUREDATA_AUGUST2022\medication_Simone';
libname cov1 'V:\PURE\PUREDATA_AUGUST2022\medication_Simone';
libname exp 'V:\PURE\PURE-BE-EPOCH_Photo\3. Data\Raw data';
libname out 'V:\PURE\PUREDATA_AUGUST2022\medication_Simone';

/*Old program borrowed from Simone*/
/*proc sort data=rawdata.comb out=allhouse;by hhid;run;*/
/*data check1;set rawdata.epochfinal;run; /*this does not have the variables I need*/

/*EPOCH data*/
data check1 (rename=(idno=idias)
keep=id epochid idno centid houseid commid subjid country ehearth eheclund ehediab ehehdis ehehdnsm ehelbirw ehelucan ehemocan eheprebi ehestrok 
edomexe edrkmcof eeatmdpr eeatmfis eeatmfru eeatmgve eeatmmea esmoking eredfatm eredsalt eredsalt egainwgt)
;
set check1;run;

/*Base adults*/
data check2 (rename=(idno=idias));
set check2;run ;

/*Follw up events*/
data check3 (rename=(idno=idias));
set check4.followupevents_12aug2022;run;

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
nofatalmi;run;

proc freq data=test2; table country;run;
proc contents data=check1;run;

proc freq data=test2;table ctry country; format ctry ctryf. country countryf.;run;

proc print data=test2; where ctry="Palestine";var ctry country;run;

proc print data=check1;where country is missing;var epochid centid commid subjid ;run;

proc freq data=check1;table centid commid ;run;

libname check3 'V:\PURE\PURE_Diabetes_FU\Diabetes_25Feb2022';

proc contents data=check3.cleanadult_11feb22;run;

proc freq data=check3.cleanadult_11feb22;table v3ctrybo;run;

proc freq data=check1;table centid;run;


ods rtf excel close;
proc print data=check1 ; var centid epochid ;run;
ods rtf close;


/******************using data from photo paper****************/
libname check4 'V:\PURE\PURE-BE-EPOCH_Photo\3. Data\Raw data';

proc print data=check4.epoch2 ; var centid epochid ;run;
proc freq data=check4.epoch2;table centid epochid;run;

/*using the data sent by Simone complete_epoch2*//*the data is stitting there in the RDS* PRJ-PURE_dataset*/

libname check5 'T:\PURE DATA JAN2024\Raw_data\SAS_Datasets\EPOCH';

proc contents data=check5.complete_epoch1;run;
proc print data=check5.complete_epoch1;var centid epochid ;run;
proc print data=check5.complete_epoch1;where centid in (66,25,61:62,27:30);var centid epochid ;run;
proc freq data=check5.complete_epoch1;table centid epochid;run;


proc contents data=check5.complete_epoch2;run;
proc print data=check5.complete_epoch2;var centid epochid ;run;
proc print data=check5.complete_epoch2;where centid in (66,25,61:62,27:30);var centid epochid ;run;
proc freq data=check5.complete_epoch2;table centid epochid;run;


