*We will input this data set using list input in two different ways:
1.	With one row per observation
2.	Using the @@ symbol for reading multiple observations per row.;

DATA question1a;
INPUT Dosage Beats;
DATALINES;
0.50 10
0.75 8
1.00 12
1.25 12
1.50 14
1.75 12
2.00 16
2.25 18
2.50 17
2.75 20
3.00 18
3.25 20
3.50 21
;
PROC PRINT data=question1a;
RUN;

DATA question1b;
INPUT Dosage Beats @@;
DATALINES;
0.50 10 0.75 8 1.00 12 1.25 12 1.50 14 1.75 12 
2.00 16 2.25 18 2.50 17 2.75 20 3.00 18 3.25 20 3.50 21
;
PROC PRINT data=question1b;
RUN;

*The file ch15_dat.txt is located in the D2L,...Handson\Handson1folder. Download
the data and save it into the local folder you created. We will be using an INFILE statement
and column input to read and created a temporary SAS data set. We will then created a
permanent SAS data set.;

LIBNAME questn2 "E:\DATS7510\SAS\Christopher-Brunswick";
*PROC FORMAT;

*VALUE fmtpatint;

*VALUE fmtinstitution
	0 = "Memorial Sloan-Kettering"
	1 = "Mayo Clinic"
	2 = "John Hopkins";

*VALUE fmtgroup
	1 = "Study"
	0 = "Control";

*VALUE fmtmod
	0 = "Routine Cytology"
	1 = "Routine X-ray"
	2 = "Both X-ray and Cytology"
	3 = "Interval";

*VALUE fmtcelltype
	0 = "Epidermoid"
	1 = "Ardenocarcinoma"
	2 = "Large Cell"
	3 = "Oat Cell"
	4 = "Other";

*VALUE fmtstgea;
*VALUE fmtstgeb;
*VALUE fmtstgec;
*VALUE fmtstged;

*VALUE fmtoperated
	1 = "yes"
	0 = "no";

*VALUE fmtsurvint;

*VALUE fmtsurvivalcat
	0 = "Alive"
	1 = "Dead of lung cancer"
	2 = "Dead of other causes";
*RUN;

*creating new variables;
DATA question2a;
INFILE "E:\SASProgrammingPractice\PracticeonclassM\ch15_dat.txt" DLM='09'X;
INPUT PatientID 1-4 Institution 7 Group 11 MOD 15 CT 19 StgeA 23 StgeB 27 StgeC 30 StgeD 33
Oper 37 SurvInt 41-44 SurvCat 48
;
*FORMAT PatientID fmtpatint. 1-4  Institute fmtinstitution. 7 Group fmtgroup. 11 MOD fmtmod. 15 CellT fmtcelltype. 19
 StageA fmtstgea. 23  StageB fmtstgeb. 27  StageC fmtstgec. 30  StageD fmtstged. 33  oper fmtoperated. $37 
SurvInt fmtsurvInt. 41-44  SurvCat fmtsurvivalCat. $48; 
DATA questn2.Tumor;
SET question2a;
RUN;


*TXT File "HOUSEHLD1.TXT" is part of census data set and is located in the D2L - 
HandsOn/Handson1 folder. We would like to get the following information to create a 
permanent SAS data named "househldCensus".;

LIBNAME questn3 "D:\DATS7510\SAS\Christopher-Brunswick";
DATA question3a;
INFILE "D:\SASProgrammingPractice\Homework1\HOUSEHLD1.txt";
INPUT HHX 7-12 REGION $42 WTIA 44-48 .1 WTFA_HH 51-54 STRATUM 55-57 GENDER 58;
DATA questn3.househldCensus;
SET question3a;
PROC PRINT data=questn3.househldCensus;
RUN;


*Practice the IMPORT and EXPORT;
LIBNAME MD "D:\DATS7510\SAS\Christopher-Brunswick\mice";
PROC IMPORT OUT=WORK.MiceDiet1
DATAFILE= "D:\DATS7510\SAS\MiceDiet.xls"
DBMS= EXCEL REPLACE;
RANGE= "SHEET1$";
GETNAMES= YES;
MIXED= NO;
SCANTEXT= YES;
USEDATE= YES;
SCANTIME= YES;
*PROC PRINT DATA=MiceDiet1;
RUN;

*DATA micedat.MiceDiet;
DATA MD.MiceDiet;
SET WORK.MiceDiet1;
DROP TotalBMC TotalBMD;
*PROC PRINT data=MD.MiceDiet;
RUN;

*DONT FORGET THE SEMICOLON AFTER DBMS;
*PROC EXPORT DATA=MD.MiceDiet
OUTFILE= "D:\DATS7510\SAS\MiceDiet2.xls"
DBMS=EXCEL REPLACE;
*SHEET="Firstsheet";
*RUN;

*PROC SORT DATA=MD.MiceDiet; *out=order;
*by Cage;
*run;

PROC MEANS DATA=MD.MiceDiet;
VAR WT
TITLE "Mice Diet Data";
RUN;



 
