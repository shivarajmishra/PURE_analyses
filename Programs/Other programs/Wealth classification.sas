/*For wealth classification use variable pct33wealthc pct20wealthc*/
/*******************************************************************/
libname wth "W:\PURE\PUREDATA_AUGUST2022\medication_Simone";
data windex; set base.windex;   keep idno wealthgn pct33wealthc   ; run;
data windex2; set mydata.Windex_pct20;   keep idno    pct20wealthc; run;
