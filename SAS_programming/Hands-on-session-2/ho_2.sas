
Proc format;
	value fmtins 	0 = "Memorial Sloan-Kettering" 
					1 = "Mayo Clinic" 
					2 = "John Hopkins" ;
	value fmtgp 	1 = "Study" 
					0 = "Control";
	value fmtmd		0 = "Routine Cytology" 
					1 = "Routine X-ray" 
					2 = "Both X-ray and Cytology" 
					3 = "Interval" ;
	value fmtsc		0 = "Alive" 
					1 = "Dead of lung cancer" 
					2 = "Dead of other causes"; 
	value fmtct		0 = 'Epidermoid' 
					1 = 'Adenocarcinoma' 
					2 = 'Large Cell' 
					3 = 'Oat Cell' 
					4 = 'Other';
	value fmtyn		1 = 'yes' 
					0 = 'no'; 


run;


*1 and 2 ,Label and Format SAS variables and read permanent SAS data set;
libname IN 'E:\Fall 2021\HandsOn\handson2';

data tumor;
  set IN.tumor;
  
  Label ptid = "Patient ID"
  		detectiontype = "Means of Detection"
		celltype = "Cell Type"
		survivalcat = "Survival Category";

format institution fmtins. group fmtgp. detectiontype fmtmd. survivalcat fmtsc. celltype fmtct.
Operated fmtyn.;

proc print data=tumor label;
  run;

  * 3;
proc contents data=tumor varnum short;
  run;

  *4;
proc freq data=tumor; 
tables group survivalcat group*survivalcat/  nocol norow;* nopercent; *out=IN.temp ;* table and tables are same;
run;

*5;

proc means data=tumor n mean std median;* noprint;
class group;
var survival;
output out=outmean mean=ave_surv max=max_surv min = min_surv;
run;

proc sort data=tumor;
by group;
proc means data=tumor n mean std median;
var survival;
by group;
*output out=outmean mean=ave_surv max=max_surv min = min_surv;
run;

*6;
proc univariate data=tumor plot normal;
class group;
var survival;
title 'Descriptive Statistics on Survival';
title2 'By Treatment Group';
run;

proc sort data=tumor;
by group;
run;

proc plot data=tumor;
plot survival*stagea="o";
by group;
run;

*7;
proc ttest data=tumor;
class group;
var survival;
title ' T-test to compare the mean difference between treatment group';
footnote 'Hands on section 2';
run;

*8 and 9;
proc ttest data=tumor;
where stagea = 2;
class group;
var survival;
title ' T-test to compare the mean difference between treatment group in Stage = 2';
footnote 'Hands on section 2';
run;


** Question2;
data OB;
input gender infection count;
datalines;
1 19 90
1 20 12
1 23 9
1 25 4
2 21 3
2 23 10
2 25 4
2 29 30
;
proc print;
run;

*1;
proc sort;
by gender;
;

proc means data=ob;
by gender;
freq count;
run;



proc ttest data=ob;
class gender;
var infection;
freq count;
title "T-test using 'freq' option";
run;

*2;
proc freq data=ob;
table gender;
weight count;
title "Frequence table using 'weight' option";
run;

