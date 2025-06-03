/*******************************************************************************/
/* This programs was used to prepare a data set for Global wealth Index        */
/* Created by Shofiqul Islam September 20, 2012                                */
/* Revised by Shofiqul Islam October 17, 2013                                  */
/* Revised by Shofiqul Islam October 28, 2014, Added Labels and Formats        */
/*Chinthanie used it create 20th percentitles for Clara'sanalysis */
/*******************************************************************************/

options nodate nonumber nocenter ls=200 ps=20000 nofmterr;

libname pcgdp "/stat/database/pure/PURE_DATABASE06/SASlib_Jan2014/";


%let folderdt=2022-08-11;
%let datadt=11AUG2022;

libname fmtlib "/stat/database/pure/DataSnapshots/Documentation_RawData/Documentation-&folderdt/Lib_format";
option fmtsearch = (fmtlib.allbaselineformats fmtlib.allepochformats fmtlib.allfollowupformats 
fmtlib.allhouseholdformats fmtlib.allmindformats fmtlib.alltabletformats fmtlib.alleventformats);


%let snap = SASlib1-2022-08-11;
%let newdir =  /stat/database/pure/DataSnapshots/&snap;

libname BASE "&&newdir/BASE";
libname EPOCH "&&newdir/EPOCH";
 libname mydata "/stat/database/pure/DataTransfers/Data/Clara/&datadt/medication";




data adult; set base.morevarspureadult;
/*  if country in(.,18,20,21) then delete;*/
  keep idno hhid country ctryp incCtry;
  proc sort; by hhid;
run;

proc freq data=adult; tables country ctryp; run;
proc freq data=PUREH.morevarspurehh; tables country HHLSDCA HHLSDCN HHLSDCO HHLSDCON HHLSDTV HHLSDTVN HHLSDMO; run; 

data hhold; set base.morevarspurehh;
/*  if country in(.,18,20,21) then delete;*/
  numbDev = sum(of hhlsdca hhlsdco hhlsdtv);

/*Create Asset Index Related Variables*/
elect = 0;
if hhelect = 2 then elect = 1;
/*if hhelect = . then elect = .;*/
if ctryp in (1,2,3) then elect = 1;

auto2 = 0;
if HHLSDCA = . and HHLSDCN in (1,2) then auto2 = 1;
if HHLSDCA = 1 and HHLSDCN = . then auto2 = 1;
if HHLSDCA = 1 and HHLSDCN in (1,2) then auto2 = 1;
/*if HHLSDCA = . and HHLSDCN = . then auto2 = .;*/

auto3 = 0;
if HHLSDCA = . and HHLSDCN >= 3 then auto3 = 1;
if HHLSDCA = 1 and HHLSDCN >= 3 then auto3 = 1;
/*if HHLSDCA = . and HHLSDCN = . then auto3 = .;*/

comp2 = 0;
if HHLSDCO = . and HHLSDCON in (1,2) then comp2 = 1;
if HHLSDCO = 1 and HHLSDCON = . then comp2 = 1;
if HHLSDCO = 1 and HHLSDCON in (1,2) then comp2 = 1;
/*if HHLSDCO = . and HHLSDCON = . then comp2 = .;*/

comp3 = 0;
if HHLSDCO = . and HHLSDCON >= 3 then comp3 = 1;
if HHLSDCO = 1 and HHLSDCON >= 3 then comp3 = 1;
/*if HHLSDCO = . and HHLSDCON = . then comp3 = .;*/

tele2 = 0;
if HHLSDTV = . and HHLSDTVN in (1,2) then tele2 = 1;
if HHLSDTV = 1 and HHLSDTVN = . then tele2 = 1;
if HHLSDTV = 1 and HHLSDTVN in (1,2) then tele2 = 1;
/*if HHLSDTV = . and HHLSDTVN = . then tele2 = .;*/

tele3 = 0;
if HHLSDTV = . and HHLSDTVN >= 3 then tele3 = 1;
if HHLSDTV = 1 and HHLSDTVN >= 3 then tele3 = 1;
/*if HHLSDTV = . and HHLSDTVN = . then tele3 = .;*/

moped = HHLSDMO;
if HHLSDMO = . then moped=0;
/*if ctryp=1 then  moped=1;*/

livest = HHLSDLC;
if HHLSDLC = . then livest = 0;

fridge = HHLSDRE;
if HHLSDRE = . then fridge=0;
if ctryp=1 then fridge=1;

othfour = HHLSDFW;

washing = HHLSDWM;
if HHLSDWM = 2 then washing = 0;
if HHLSDWM = . then washing = 0;
if ctryp=1 then washing=1;

stereo = HHLSDSR;
if HHLSDSR = 3 then stereo = 0;
if HHLSDSR = . then stereo = 0;
if ctryp=1 then stereo=1;

bike = HHLSDBC;
if HHLSDBC = . then bike = 0;

kmix = HHLSDKM;
if HHLSDKM = . then kmix = 0;
if ctryp=1 then kmix=1;

phone = HHLSDTL;
if HHLSDTL = . then phone = 0;
if ctryp=1 then  phone=1;

land = 0;
if HHCLAND = 2 then land = 1;
/*if HHCLAND = . then land = .;*/

window = HHICOOKFW;
if HHICOOKFW = . then window = 0;
if ctryp=1 then window=1;

  keep country ctryp hhid pctSptFd numbDev hhlsdca hhlsdco hhlsdtv;
  keep elect auto2 auto3 comp2 comp3 tele2 tele3 moped livest fridge othfour washing stereo bike kmix phone land window;
  proc sort; by hhid; run;
run;

data tmph00;
  merge adult(in=a) hhold(in=b);
  by hhid;
  if NOT a;
run;
proc freq data=tmph00; tables country; run;

proc freq data=hhold; 
tables country country*(elect auto2 auto3 comp2 comp3 tele2 tele3 moped livest fridge othfour washing stereo bike kmix phone land window)/nocol nopct;
run;

/*Principal Component Analysis for Asset Index*/

title1 "PCA for 3 components";
/*
*** Principal components analysis***; 
proc factor data=hhold n=3 out = hholdp outstat= hholdn simple corr msa scree preplot rotate=v plot;
var elect auto2 auto3 comp2 comp3 tele2 tele3 moped livest fridge othfour washing stereo bike kmix phone land window;                                                                                                  
run;
*/

title1 "PCA for 1 components";
*** Principal components analysis***; 
proc factor data=hhold n=1 out = hholdp simple corr msa rotate=v noprint;
var elect auto2 auto3 comp2 comp3 tele2 tele3 moped livest fridge othfour washing stereo bike kmix phone land window;                                                                                                  
run;

proc print data=hholdp (obs=10); run;

data Wind; set hholdp;
  wealthgn=Factor1;
  keep hhid country wealthgn; 
  proc sort; by hhid;
run;

proc means data=wind maxdec=1; class country;var wealthgn; run;  /*Weihong added*/

proc rank data=Wind out=Wind01 Groups=3;
  var wealthgn;
  ranks pct33wealthn;
run;

proc sort data=Wind01; by country; run;

proc rank data=Wind01 out=Wind00 Groups=3;
  var wealthgn;
  ranks pct33wealthc;
  by country;
run;

proc rank data=Wind00 out=Wind0a Groups=5;
  var wealthgn;
  ranks pct20wealthn;
run;

/*Chinthanie added on JUne 22,2018- create country specific quintiles*/
proc sort data=Wind0a; by country; run;

proc rank data=Wind0a out=Wind0  Groups=5;
  var wealthgn;
  ranks pct20wealthc;
  by country;
run;



proc rank data=Wind0 out=Wind1 Groups=10;
  var wealthgn;
  ranks pct10wealthn;
run;

proc rank data=Wind1 out=Windex2 Groups=20;
  var wealthgn;
  ranks pct5wealthn;
run;

data Windex2; set Windex2;
  pct5wealthn = pct5wealthn + 1;
  pct10wealthn = pct10wealthn + 1;
  pct20wealthn = pct20wealthn + 1;
  pct33wealthn = pct33wealthn + 1;
  pct33wealthc = pct33wealthc + 1;
  pct20wealthc = pct20wealthc + 1;
  drop country;
  proc sort; by hhid; run;
run;

proc sort data=hhold; by hhid; run;

data Windcomb;
  merge hhold Windex2;
  by hhid;
run;

/*data mydata.Windex_17Sept13; set Windcomb; run;*/

proc freq data=Windcomb; tables country ctryp country*pct33wealthc /nocol nopercent; run;

data aduHH;
  merge Windcomb(in=b) adult(in=a);
  by hhid;
  if a;/* or b;*/
run;

data tmph;
  merge adult(in=a) Windcomb(in=b);
  by hhid;
  if NOT a;
run;

proc freq data=tmph; tables country pct33wealthc; run;

proc freq data=aduHH; tables country country*pct33wealthc   country*pct20wealthc/nocol nopercent; run;

proc sort data = aduHH; by idno; run;

data pcgdp; set pcgdp.pcgdp2; run;
proc contents data = pcgdp position; run;

proc sort data=pcgdp; by pcgdp; run;
data pcgdp; set pcgdp; 
  if pcgdp = . then delete;
  orgdp+1; 
  keep pche pcgdp orgdp ctryp; 
run;

proc sort data = aduHH; by ctryp; run;
proc sort data = pcgdp; by ctryp; run;

proc print data=pcgdp; run;

data final;
  merge aduHH(in=a) pcgdp(in=b);
  by ctryp;
  if a;/* and b;*/
run;

proc freq data = final;
  table orgdp country ctryp;
run;
proc sort data=final; by idno; run;

/*data final; set final; if country = 19 then pcgdp = 1924; run;*/

proc format;
value pct20wealthcf 1 = "Windex Quintile 1"
                    2 = "Windex Quintile 2"
                    3 = "Windex Quintile 3"
                    4 = "Windex Quintile 4"
                    5 = "Windex Quintile 5";

run;


 /* libname mydata "/stat/database/pure/DataTransfers/Data/Clara/Medication_2019";*/
data  mydata.Windex_pct20;  
 set final; 
  keep idno hhid country wealthgn pct5wealthn pct10wealthn pct20wealthn   pct20wealthc pct33wealthn pct33wealthc 
  pche pcgdp orgdp;
  label wealthgn="Global Wealth Index"
        pct5wealthn="Global Wealth Index 20 categories"
        pct10wealthn="Global Wealth Index Deciles"
        pct20wealthn="Global Wealth Index Quintiles" 
        pct33wealthn="Global Wealth Index Tertiles" 
        pct33wealthc="Global Wealth Index Country Specific Tertiles"
       pct20wealthc="Global Wealth Index Country Specific Quintiles"  /*CR added*/
        pche="Per Capita Health Expenditure"
        pcgdp="Per Capita GDP"
        orgdp="GDP Order";
format pct5wealthn pct5wealthnf. pct10wealthn pct10wealthnf. pct20wealthn pct20wealthnf.      pct20wealthc pct20wealthcf. pct33wealthn pct33wealthnf. pct33wealthc pct33wealthcf.; 
run;


proc freq data = mydata.Windex_pct20; 
 tables pct5wealthn;
 tables country*pct10wealthn/nocol nopercent;  
 tables country*pct20wealthc/nocol nopercent;  
 table country*pct33wealthn country*pct33wealthc/nocol nopercent; 
 table country*pcgdp orgdp*pcgdp/nocol nopercent; 
run;

proc freq data=final; where (pcgdp=. or orgdp=.); tables country; run;
