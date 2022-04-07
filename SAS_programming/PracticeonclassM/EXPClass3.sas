/** Class 3***/

*Example 1 for Class 3;

/*
Adams   M 16 4 TX 1995
Phillip M 15 5 GA 1999
Amanda  F 15 5 GA 1995
Jane    F 14 4 SC 1999
*/

DATA Example1;
infile "E:\Fall 2020\Lecture3\EXP1.TXT";
	INPUT name $ 1-7 sex $ 9 age  11-12 score 14 State $ 16-17 year $19-22;
	
PROC PRINT DATA=Example1;
RUN;
  


/*** Example 2 Options FIRSTOBS OBS*****/

/*
Student record
Adams   M 16 4 TX 1995
Phillip M 15 5 GA 1999
Amanda  F 15 5 GA 1995
Jane    F 14 4 SC 1999
Data verified by Blake White
*/

DATA Example2;
infile "E:\Fall 2020\Lecture3\EXP2.TXT" Firstobs=2 obs=5;
	INPUT name $ 1-7 sex $ 9 age  11-12 score 14 State $ 16-17 year 19-22;
	label name="Student'Name";
	
PROC PRINT DATA=Example2 label;
RUN;
  

/**** Example 3 Option MISSOVER***********/

/*
Adams   M 16 4 TX 1995
Phillip M 15 5    
Amanda  F 15 5 GA 1995
Jane    F 14 4 SC 1999
*/

Data Example3;
infile "E:\MCG-Lifang\SAS Class\Fall 2021\Lecture3\EXP3.TXT"  Missover;
	INPUT name $ 1-7 sex $ 9 age  11-12 score 14 State $ 16-17 year 19-22;
	
PROC PRINT DATA=Example3;
RUN;


/**** Example 4 Option TRUNCOVER***********/
/*
Adams   M 16 4 TX 1995 114 Maple Ave.
Phillip M 15 5 GA 1999 1320 Washington Drive
Amanda  F 15 5 GA 1995 45 S.E. 14 Street
Jane    F 14 4 SC 1999 301 Dana Street
*/


Data Example4;
infile "E:\MCG-Lifang\SAS Class\Fall 2021\Lecture3\EXP4.TXT"  TRUNCOVER;
INPUT name $ sex $ age  score State $  year  address $24-44;
PROC PRINT DATA=Example4;
RUN;
 


/**** Example 5 Option DLM with ,***********/
/*
Adams,M,16,4,TX,1995
Phillip,M,15,5,GA,1999
Amanda,F,15,5,GA,1995
Jane,F,14,4,SC,1999
*/

Data Example5;

infile "E:\Fall 2020\Lecture3\EXP5.TXT" DLM=',';
	INPUT name $  sex $  age  score  State $  year ;
	
PROC PRINT DATA=Example5;
RUN;
 

/**** Example 6 Option DLM with Tab***********/

/*
Student record
Adams	M	16	4	TX	1995
Phillip	M	15	5	GA	1999
Amanda	F	15	5	GA	1995
Jane	F	14	4	SC	1999
Data verified by Blake White
*/

DATA Example6;
infile "E:\Fall 2020\Lecture3\EXP6.TXT" Firstobs=2 obs=5 DLM='09'X ;
	INPUT name $ sex $ age score State $ year ;
	
PROC PRINT DATA=Example6;
RUN;
 

/**** Example Option DSD***********/

/*
Lupine Lights, 12/3/2003, 45, 63, 70,
Awesome Octaves, 12/15/2003, 17, 28, 44, 12
"Stop, Drop, and Rock-N-Roll", 1/5/2004, 34, 62, 77, 91
The Silveyvile Jazz Quartet, 1/18/2004, 38, 30, 42, 43
Catalina Converts, 1/31/2004, 56, , 65, 34
*/
DATA Music;
  infile 'E:\MCG-Lifang\SAS Class\Fall 2021\Lecture3\EXP8.TXT' DLM=',' DSD missover ;
  input BandName :$30. GigDate :mmddyy10. PM8 PM9 PM10 PM11;
  proc print data=music;
  run;


/***** Example 7 and 8 using Colin Modifier*****/

/*
Adams,M,16,4,TX,1995,
Phillip,M,15,5,GA,1999,1320 Washington Drive
Amanda,F,15,5,GA,1995,"45 S.E., 14 Street"
Jane,F,14,4,,1999,301 Dana Street
*/

Data Example7;

infile "E:\MCG-Lifang\SAS Class\Fall 2021\Lecture3\EXP7.TXT"   DLM=',' DSD MISSOVER;* TRUNCOVER;
	INPUT name $  sex $  age  score  State $  year address :$21.; 
	*keep name sex score;
	drop name;

PROC PRINT DATA=Example7;
RUN;









PROC IMPORT OUT= WORK.one 
            DATAFILE= "E:\Fall 2020\Lecture3\EXIMP.xls" 
            DBMS=EXCEL REPLACE;
     RANGE="Sheet1$"; 
     GETNAMES=YES;
     MIXED=NO;
     SCANTEXT=YES;
     USEDATE=YES;
     SCANTIME=YES;
RUN;


PROC IMPORT OUT= WORK.two
            DATAFILE= "E:\Fall 2020\Lecture3\EXIMP.xls" 
            DBMS=EXCEL REPLACE;
     RANGE="Sheet2$"; 
     GETNAMES=YES;
     MIXED=NO;
     SCANTEXT=YES;
     USEDATE=YES;
     SCANTIME=YES;
RUN;


PROC EXPORT DATA= WORK.EXAMPLE4 
            OUTFILE= "E:\Fall 2020\Lecture3\examp4.xlsx" 
            DBMS=EXCEL REPLACE;
     SHEET="t1"; 
RUN;


proc options;
run;
