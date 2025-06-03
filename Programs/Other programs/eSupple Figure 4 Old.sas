/******************************************************/
/****************************************************/
/******This figure never made it to the paper*******/

%let dpi=300;
%let w=5.5in;
%let h=3.0in;

data SubgroupData1;
input Indent author $3-35 mean CIL CIU  ;
format mean1 CIL1 CIU1  pvalue 7.3;
length meanCI $45;
CIL1=strip(CIL);
CIU1=strip(CIU);
mean1=strip(mean);

if mean1 ne . then do;
meanCI = put(mean1, 4.2) || "("||put(CIL1, 4.2) || ", "
|| put(CIU1, 4.2) || ")";
/* Determine the marker size based on population size */
/*SquareSize = ((CountA + CountB)/3876) * 12 ;*/
end;
row = _n_;

if mean not in (.,1) then do;
Squaresize=1/(((log(CIU) - log(mean))/1.96)**2);
end;

if mean=1 then do;

squaresize=3;

end;

datalines;
0	Wealth index					.	.	.
0	Poorest third					.	.	.
1	Low	health literacy				1	1	1
1	Moderate health literacy		1.95 0.94 4.03
1	High health literacy			1.84 1.11 3.04
0	Middle third					.	.	.
1	Low	health literacy				1.03 0.64 1.65
1	Moderate health literacy		1.57 0.99 2.47
1	High health literacy			2.27 1.36 3.78
0	Richest third					.	.	.
1	Low health literacy		 		1.65 1.11 2.45
1	Moderate health literacy		1.53 1.00 2.34
1	High health literacy			2.70 1.65 4.41
0	Education						.	.	.
0	None or primary only			.	.	.
1	Low	health literacy				1	1	1
1	Moderate health literacy		1.94 	1.25	2.99
1	High health literacy			2.18 	1.36	3.50
0	Secondary 						.	.	.
1	Low health literacy		 		1.02 0.69 1.52
1	Moderate health literacy		1.57 1.04 2.35
1	High health literacy			2.50 1.64 3.82
0	Trade, college or university	.	.	.
1	Low	health literacy				1.87 1.05 3.35
1	Moderate health literacy		1.22 0.71 2.11
1	High health literacy			1.88 1.06 3.34
;
run;

Data SubgroupData1;
set SubgroupData1;
format pvalue 7.3;

if mean1 not in (.,1) then do;
	se=(log(CIU1)-log(CIL1))/3.92;
	z=log(mean1)/se;
	pvalue=exp(-0.717*z - 0.416*z**2)
;
end;

if mean not in (.,1) then do;
if pvalue <0.001 then do; pvalue=0.00001;end;
end;


run;

data SubgroupData2;
input Indent author $3-35 mean CIL CIU;
format mean1 CIL1 CIU1  pvalue 7.3;
length meanCI $45;
CIL1=strip(CIL);
CIU1=strip(CIU);
mean1=strip(mean);
if mean1 ne . then do;
meanCI = put(mean1, 4.2) || "("||put(CIL1, 4.2) || ", "
|| put(CIU1, 4.2) || ")";
/* Determine the marker size based on population size */
/*SquareSize = ((CountA + CountB)/3876) * 12 ;*/
end;
row = _n_;

if mean not in (.,1) then do;
Squaresize=1/(((log(CIU) - log(mean))/1.96)**2);
end;

if mean=1 then do;

squaresize=3;

end;

datalines;
0	Wealth index					.	.	.
0	Poorest third					.	.	.
1	Low	health literacy				1	1	1
1	Moderate health literacy		1.60  0.78 3.27 
1	High health literacy			2.47  1.54 3.94 
0	Middle third					. . .	
1	Low health literacy				1.00  0.65 1.56 
1	Moderate health literacy		1.65  1.11 2.47 
1	High health literacy			2.36  1.39 3.98 
0	Richest third					.	.	.
1	Low health literacy				1.65  1.21 2.26 
1	Moderate health literacy		1.67  1.09 2.57 
1	High health literacy		    2.74  1.57 4.81 
0	Education						.	.	.
0	None or primary only			.	.	.
1	Low health literacy				1	1	1
1	Moderate health literacy		1.95  1.27 3.01 
1	High health literacy			2.87  1.66 4.99 
0	Secondary						. . .	
1	Low health literacy				1.14  0.79 1.64 
1	Moderate health literacy		1.87  1.02 3.43 
1	High health literacy			2.52  1.54 4.13 
0	Trade  college or university	. . .	
1	Low health literacy				2.06  1.07 3.95 
1	Moderate health literacy		1.22  0.65 2.28 
1	High health literacy			2.25  1.29 3.91 
;
run;

Data SubgroupData2;
set SubgroupData2;
format pvalue 7.3;

if mean1 not in (.,1) then do;
	se=(log(CIU1)-log(CIL1))/3.92;
	z=log(mean1)/se;
	pvalue=exp(-0.717*z - 0.416*z**2)
;
end;

if mean not in (.,1) then do;
if pvalue <0.001 then do; pvalue=0.00001;end;
end;

run;

%let myvar = SubgroupData1 SubgroupData2;

%macro myforest;
%do i=1 %to 2;
/*--Used for Subgroup labels in column 1--*/
data anno(drop=indent);
set %scan(&myvar, &i)(keep=row Author indent rename=(row=y1));
retain Function 'Text ' ID 'id1' X1Space 'DataPercent'
Y1Space 'DataValue ' x1 x2 2 TextSize 7 Width 100 Anchor 'Left ';
if indent;
label = tranwrd(author, '>=', '(*ESC*){Unicode ''2265''x}');
run;

data subgroupdata ;
set %scan(&myvar, &i);

length meanCI $55;

if meanCI="1.00(1.00, 1.00)" then do; meanCI="Reference"; end;

run;
/*
/*--Used for text under x axis of HR scatter plot in column 7--*
data anno2;
retain Function 'Arrow' ID 'id2' X1Space X2Space 'DataValue'
FIllTransparency 0 Y1Space Y2Space 'GraphPercent'
Scale 1e-40 LineThickness 1 y1 y2 7.0 Width 100
FillStyleElement 'GraphWalls' LineColor 'Black';
x1 = 0.90; x2 = 0.25; output;
x1 = 2.10; x2 = 3.6; output;
function = 'Text'; y1 = 7.0; y2 = 7.0;
x1 = 0.92; anchor = 'Right'; label = 'Pioglitazone Better'; Textsize=8;
output;
x1 = 1.07; Anchor = 'Left '; label = 'Placebo Better'; Textsize=8; output;
run;


data anno; set anno anno2; run;*/

data forest2(drop=flag);
set subgroupdata nobs=nobs;
Head = not indent;
retain flag 2;
if head then flag = mod(flag + 1, 2);
if flag then ref=row;
if indent then author = ' ';
run;


/*--Define template for Forest Plot--*/
/*--Template uses a Layout Lattice of 8 columns--*/
proc template;
define statgraph Forest;
dynamic _show_bands _color _thk _bandcolor _headercolor _subgroupcolor;
begingraph;
legenditem type=text name="b" /textattrs=(size=12pt) LABELATTRS=(size=12pt)
text="" ;
discreteattrmap name='text';
value '1' / textattrs=(color=black weight=bold ); value other;
enddiscreteattrmap;
discreteattrvar attrvar=type var=head attrmap='text';
layout lattice /
columns=4 columnweights=(0.40 0.25 .30 .16);

/*--Column headers--*/
sidebar / align=top;
layout lattice /
rows=2 columns=4 columnweights=(0.01 0.3 0.42 .12)
 backgroundcolor=_headercolor opaque=true;
entry " ";
entry textattrs=(size=8 weight=bold) halign=left "Factors";
entry textattrs=(size=8 weight=bold) halign=left "Adjusted ORs";
/*entry textattrs=(size=8 weight=bold) halign=left "Country";*/
entry textattrs=(size=8 weight=bold) halign=left "P-value";
endlayout;
endsidebar;

/*--First Subgroup column, shows only the Y2 axis--*/
layout overlay / walldisplay=none xaxisopts=(display=none)
yaxisopts=(reverse=true type=discrete display=none
tickvalueattrs=(weight=bold));
annotate / id='id1';
referenceline y=ref / lineattrs=(thickness=_thk color=_color);
axistable y=row value=author / indentweight=indent 
display=(values) textgroup=type;
endlayout;

/*--Sixth column showing PCIGroup--*/
 layout overlay / x2axisopts=(display=none)
 yaxisopts=(reverse=true type=discrete display=none) walldisplay=none;
 referenceline y=ref / lineattrs=(thickness=_thk color=_color);
 axistable y=row value=meanCI / display=(values);
 endlayout;

/*--third column showing Hazard ratio graph with 95% error bars--*/
layout overlay /xaxisopts=(type=log label=' '  
           labelattrs=(size=.1) tickvalueattrs=(size=7pt) linearopts=(tickvaluepriority=true 
tickvaluelist=(5 8 10 12 14 16 18 20) viewmin=5 viewmax=20))
yaxisopts=(reverse=true type=discrete display=none labelattrs=(size=12pt)) walldisplay=none ;
entry halign=left textattrs=(color=black size=7pt) "" halign=right textattrs=(color=black size=7pt) "" /location=outside valign=bottom;
referenceline y=ref / lineattrs=(thickness=_thk color=_color);
scatterplot y=row x=mean / xerrorlower=CIL xerrorupper=CIU
sizeresponse=SquareSize sizemin=10 sizemax=15
markerattrs=(symbol=squarefilled size=3px color=black) ERRORBARCAPSHAPE=none;
referenceline x=1/ lineattrs=(color=black thickness=.1px pattern=solid);
legend;
endlayout;

/*--Sixth column showing PCIGroup--*/
layout overlay / xaxisopts=(display=none)
yaxisopts=(reverse=true type=discrete display=none) walldisplay=none;
referenceline y=ref / lineattrs=(thickness=_thk color=_color);
axistable y=row value=pvalue /display=(values)
valuejustify = center;
endlayout;

 sidebar /align=bottom;
discretelegend "a" "b" / autoitemsize=true backgroundcolor=lightblue itemsize=(linelength=30 fillheight=8) border=false ;
endsidebar;

endlayout;
entryfootnote halign=left textattrs=(size=7) '';
endgraph;
end;
run;

proc format;
  value misblank
    . =' '
	0.00001='<0.001';
run;

/*---------*/
ods rtf file="%scan(&myvar, &i).rtf";
ods html close;
ods listing gpath="C:\Users\USER\OneDrive - The University of Sydney (Staff)\analysis plan + mock up papers\WARC" image_dpi=&dpi;
ods graphics / reset noscale IMAGEFMT=png
width=&w height=&h imagename='bfGraph';
/*--Render Forest Plot with horizontal bands--*/
ods graphics / reset width=7.5in height=5.4in imagename="%scan(&myvar, &i)" border;
proc sgrender data=Forest2 template=Forest sganno=anno ;
format mean CIL CIU  pvalue 7.2; 
format  pvalue misblank.;
dynamic _color='Azure' _headercolor="lightblue" _thk=26 ;
run;
ods rtf close;

%end;
%mend;
%myforest;





