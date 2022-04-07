
Libname IN 'E:\Fall 2020\Lecture5';


DATA  group;
	infile "E:\Fall 2020\Lecture5\group.txt";
	input ID Name $ Height Weight DoB MMDDYY8.;
	LABEL ID = 'Identification no.'
		Height = 'Height in inches'
		Weight = 'Weight in pounds'
		DoB = 'Date of birth';
	*informat DoB MMDDYY8.;
	 format DoB WORDDATE18.;

proc print;
run;

/********** Example PROC Contents***/

proc contents data=in.demo  out=one;* Short;* VARNUM ; 
/*ID AGE INCOME MARITAL EDUC sex*/

run;

proc print data=in.demo;
run;

/***** Example 2, 3 PROC SORT & PROC PRINT*****/

data sales;
set IN.sales;

proc sort data = Sales;* out=order;
by  class;
* defaut is ascending;
run;

options nodate nonumber;

proc print label data=Sales;* (obs=2);
*WHERE class>20;
*BY class;
*SUM Profit;
*ID Quantity;
label Name = "Customer Name";
TITLE 'Summary of Sale';
TITLE2 'Example';
FOOTNOTE'2000 Sales';
var Name class Profit;
run; 


/*********  Example 4 PROC MEANS and writing statistics to a SAS data set*********/ 
proc sort data=sales;
	by CandyType;
run;

proc means data = sales noprint;*  Max Min Mean Median N NMISS RANGE STDDEV SUM;
	*by CandyType;
	Class CandyType;
	var  Profit;
	output out=SummaryProfit  MEAN= MeanProfit MAX = MaxProfit;
	Title 'Summary of Profit by Candy Type'; 
run;
	
proc print data=SummaryProfit; * with and without Mean, Max Rename;
run;

proc means data = sales ;*noprint;* Max Min Mean Median N NMISS RANGE STDDEV SUM;
	by CandyType;
	*Class CandyType;
	var Quantity Profit;
	output out=Averages MEAN(Quantity Profit)= MeanQuantity MeanProfit 
	MAX (Quantity Profit)= MaxQuantity MaxProfit  ;
	Title 'Summary of Sales by Candy Type'; 
run;
proc print data=Averages;* with and without Mean, Max Rename;
run;

PROC EXPORT DATA= Averages ( Drop = _Type_   _freq_  )
             OUTFILE= "E:\Fall 2020\Lecture5\Averages.xls" 
            DBMS=EXCEL REPLACE;
     SHEET="A"; 
RUN;

/**** How to save the created data set to a permanent SAS data set?***/

