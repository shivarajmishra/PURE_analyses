/***********MACRO to create SGPLOT figures for knowledge questions***********/
/******************************By CVD***************************************/
/**************************************************************************/

proc sort data=test7;by ehelbirw;run;
proc freq data=test7 noprint;
by ehelbirw;                    /* X categories on BY statement */
tables SevereCVD_2cat / out=FreqOut;    /* Y (stacked groups) on TABLES statement */
run;

data FreqOut1; set FreqOut; format percent f4.2;run;

/*Knowledge variables: first batch of 10 and 11 questions*/
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

/*11 questions*/
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
