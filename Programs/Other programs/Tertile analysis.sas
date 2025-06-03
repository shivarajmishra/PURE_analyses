/****************************Health literacy ****************************/
/*epoch2 is the datasets to use for defining health literacy variable***/
/**********************************************************************/

/*Tertile analysis for literacy variable*/
/*load data test7 from datasetup syntax*/
ods rtf file = "2.Tertile analysis for literacy variables Q8 and 18 EPOCH2.rtf";
proc factor data = test7 corr scree ev method = principal ;
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

/*data checks below*/
/*proc freq data=merged_lit;table lit_5cat;run;*/
/*proc print data=merged_lit (obs=100) ; where lit_5cat ne .; var age asex educ location idias id centid country epochid commid eheclund severeCVD fatalCVD CVD newStrk newhf fatalhf nofatalhf newmi fatalmi nofatalmi lit_5cat;run;*/
/*proc means data=merged_lit n nmiss;var:; run;*/
/*proc means data=merged_lit;var:;run;*/
/*proc print data=merged_lit (obs=3000);var hhid key_hhid idias; where hhid ne .;run;*/

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
/*one individual per household*/
