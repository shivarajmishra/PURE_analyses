/*Figure: sgplot for knowledge variable Q8 by countries*/
/******************************************************/
/**This was later replaced by radial plot in the MS***/

/*****First batch of 10 variables by countries Q8****/
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

/*Second batch of 11 variables by countries*/
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

/*CVD counts*/
proc freq data=test7;table SevereCVD_2cat asex
newstrk newhf;run;
