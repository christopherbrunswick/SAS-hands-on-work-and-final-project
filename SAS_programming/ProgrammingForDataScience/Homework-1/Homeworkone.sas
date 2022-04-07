*question 1a;
Data blistertreatment;
input Treatments $1-10 days 11-13;
datalines;
placebo    5
placebo    8
placebo    7
placebo    7
placebo   10
placebo    8
Treatment1 4
Treatment1 6
Treatment1 6
Treatment1 3
Treatment1 5
Treatment1 6
Treatment2 6
Treatment2 4
Treatment2 4
Treatment2 5
Treatment2 4
Treatment2 3
Treatment3 7
Treatment3 4
Treatment3 6
Treatment3 6
Treatment3 3
Treatment3 5
Treatment4 9
Treatment4 3
Treatment4 5
Treatment4 7
Treatment4 7
Treatment4 6
;
proc print DATA=blistertreatment;
run;

*question 1b;
Data blistertreatment1;
input Treatment $ days @@; 
Datalines;
placebo    5 placebo    8 placebo    7 placebo    7 placebo   10 placebo    8
Treatment1 4 Treatment1 6 Treatment1 6 Treatment1 3 Treatment1 5 Treatment1 6
Treatment2 6 Treatment2 4 Treatment2 4 Treatment2 5 Treatment2 4 Treatment2 3
Treatment3 7 Treatment3 4 Treatment3 6 Treatment3 6 Treatment3 3 Treatment3 5
Treatment4 9 Treatment4 3 Treatment4 5 Treatment4 7 Treatment4 7 Treatment4 6
;
proc print DATA=blistertreatment1;
run;

*question2a-b;
DATA BloodPressure;
INFILE "D:\SASProgrammingPractice\Homework1\bp.txt";
INPUT Id 1-2 RecumbentSBP 9-11 RecumbentDBP 17-18 StandingSBP 25-27 StandingDBP 33-34;
PROC PRINT DATA=BloodPressure;
RUN;


*question3;
*can not use COLUMN INFORMAT and DATE INFORMAT simultaneously
 use pointer @ to point to column;
DATA Babies;
INFILE "D:\SASProgrammingPractice\Homework1\Babies\babies.txt";
INPUT sex $1-6 prenatalcare $9-12 smokestatus $17-19 gestationwks 25-26 BWingrams 33-36  
LengthinIN 41-44 @49 DOB mmddyy8.;
PROC PRINT DATA=Babies;
RUN;

* in order to create a permanent SAS data set use keyword LIBNAME
  then name the folder you want to create (a) and input the file path where you want to save the data set
  then create a new DATA name by inputing the library (data set name) -> (a) followed by a period. The (a) is the first
  level (data set name). Then create a second level (baby) which is the member name that uniquely identifies the data set
  with the library.;

*question4;
Data TEMP;
INFILE "D:\SASProgrammingPractice\Homework1\Person.txt" firstobs=2;
INPUT RECTYPE $1-2 HHX $7-12 FMX $13-14 PX $15-16 SEX $18 AGE_P 19-20 R_AGE1 $21 R_AGE2 $22
 DOB_M $23-24 DOB_Y_P $25-28 ORIGIN_I 29 ORIGIMPT 30 HISPAN_I 31-32 HISPIMPT 33 RACERPI2 34-35 RACEIMP2 36
MRACRPI2 37-38 MRACBPI2 $39-40 RACRECI2 $41 FMRPFLG $61 ASTATFLG $84 REGION $87 WTIA 89-93 WTFA 96-99 
STRATUM $100-102 PSU $103;

LIBNAME Person "D:\SASProgrammingPractice\Homework1\New Iibrary";
Data Person.Personal;
SET TEMP;
IF ASTATFLG~=.;
RUN;
