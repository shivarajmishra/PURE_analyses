
/****************************************Figure 1********************************************/
/********Distribution of health knowledge variables shown by bubble plot by countries ******/

data population;
  input know_q class aware indent;
   label know_q="Questions" class="Income regions";
  datalines;
1	1	98.1	1
1	2	94.4	1
1	3	88.2	1
1	4	80.3	1
10	1	83.4	1
10	2	79.7	1
10	3	46.2	1
10	4	44.2	1
11	1	95	1
11	2	91.9	1
11	3	75.8	1
11	4	66	1
12	1	90.2	1
12	2	92	1
12	3	79.7	1
12	4	68.8	1
13	1	93.5	1
13	2	94.6	1
13	3	82	1
13	4	72.5	1
14	1	78.1	1
14	2	66.1	1
14	3	58.3	1
14	4	55.1	1
15	1	76.4	1
15	2	71.3	1
15	3	44.8	1
15	4	44.8	1
16	1	23.7	1
16	2	67.7	1
16	3	53.6	1
16	4	17	1
17	1	85.9	1
17	2	85.4	1
17	3	59.8	1
17	4	39.4	1
18	1	95.5	1
18	2	86.9	1
18	3	77.5	1
18	4	69.4	1
19	1	90.9	1
19	2	89.6	1
19	3	70.5	1
19	4	54.4	1
2	1	93.8	0
2	2	92.8	0
2	3	59.4	0
2	4	73.7	0
20	1	91.8	0
20	2	88.9	0
20	3	69.9	0
20	4	55.6	0
21	1	88.9	0
21	2	73	0
21	3	64.1	0
21	4	53.7	0
3	1	68.6	0
3	2	82.2	0
3	3	81.3	0
3	4	79.9	0
4	1	83.8	0
4	2	80.8	0
4	3	45.4	0
4	4	44.4	0
5	1	60.4	0
5	2	85.5	0
5	3	72.2	0
5	4	83.2	0
6	1	98.4	0
6	2	95	0
6	3	83.2	0
6	4	79.9	0
7	1	96.5	0
7	2	91.9	0
7	3	70.9	0
7	4	75	0
8	1	84.1	0
8	2	85	0
8	3	50.2	0
8	4	66.6	0
9	1	81.8	0
9	2	79.4	0
9	3	50	0
9	4	44.9	0
;
run;

proc sort data=population1 ; key know_q /descending;run;

proc format;
value knowf
	1  ="Chronic lung disease"
	2	="Heart disease"
	3	="Diabetes"
	4 =	"Stroke"
	5	="Arthritis"
	6	="Lung cancer"
	7	="Mouth and throat cancer"
	8	="Heart disease in non-smokers exposed"
	9	="Premature birth with smoking during pregnancy"
	10	="Low birth weight babies with smoking"
	11	="Doing more exercise"
	12	="Eating more fruit"
	13	="Eat more green vegetables"
	14	="Reduce meat intake"
	15	="Drinking less coffee"
	16	="Eating more dairy products"
	17	="Eating more fish"
	18	="Quit smoking"
	19	="Reducing fat in meals"
	20	="Reducing salt in meals"
	21	="Reduce weight gains";
;

value incomef
1 = "HIC"
2 = "UMIC"
3 = "LMIC"
4 = "LIC"
;
run;


proc template;
  define statgraph bplot1;
    begingraph / designheight=780 designwidth=640;
	  entrytitle '';
	  layout overlay/xaxisopts=(reverse=true TYPE= DISCRETE ) yaxisopts=(reverse=true TYPE= DISCRETE);
	    bubbleplot x=class y=know_q size=eval(abs(aware)) / datalabel=aware 
		       bubbleradiusmin=5pt bubbleradiusmax=15pt 
                       dataskin=matte name="bubble" 
                       datalabelattrs=(size=7 color=black weight=bold) 
                       datalabelposition=bottom datalabelposition=center 
        group=eval(ifc(aware<60 & know_q not in (4,5),'Low (<60%)','High (>=60%)','Missing'));
	    discretelegend "bubble" / title="Health knowledge (%)" pad=5;
	  endlayout;
	  entryfootnote halign=left "";
	endgraph;
  end;
run;

ods rtf file='2.rtf';
ods listing gpath="C:\Users\smis5930\OneDrive - The University of Sydney (Staff)\analysis plan + mock up papers\WARC\PURE Health Literacy\Analysis" image_dpi=300;
ods graphics / reset noscale IMAGEFMT=png
width=&w height=&h imagename='bfGraph';
/*--Render Forest Plot with horizontal bands--*/
ods graphics / reset width=5.5in height=8.4in imagename='bubblegraph' border;
proc sgrender data=population template=bplot1; 
format know_q knowf. class incomef.  ;run;
ods rtf close;


 
