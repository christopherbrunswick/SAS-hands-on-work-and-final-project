PROC FORMAT;

*VALUE fmtpatint;

VALUE fmtinstitution
	0 = "Memorial Sloan-Kettering"
	1 = "Mayo Clinic"
	2 = "John Hopkins";

VALUE fmtgroup
	1 = "Study"
	0 = "Control";

VALUE fmtmod
	0 = "Routine Cytology"
	1 = "Routine X-ray"
	2 = "Both X-ray and Cytology"
	3 = "Interval";

VALUE fmtcelltype
	0 = "Epidermoid"
	1 = "Ardenocarcinoma"
	2 = "Large Cell"
	3 = "Oat Cell"
	4 = "Other";
VALUE fmtoperated
	1 = "yes"
	0 = "no";

*VALUE fmtsurvint;

VALUE fmtsurvivalcat
	0 = "Alive"
	1 = "Dead of lung cancer"
	2 = "Dead of other causes";
RUN;

*Read in the permanent SAS data set (tumor) created in Hands-on session 1;
*create a new libname statement with the directory that has the permanent file of interest;
*use SET keyword to access the library with the permanent data set;

*The following SAS program creates a temporary SAS data set called work.temp, which is 
identical to the permanent SAS data set called stat480.temp2:
because a one-level name is used, the DATA statement tells SAS to create a temporary 
dataset called temp.
The SET statement tells SAS to assign the data in the existing permanent SAS data 
set stat480.temp2 — observation by observation — to the temporary temp data set 
appearing in the DATA statement. Because the variables in the existing data set 
have already been named, no input statement is necessary. That is, the SET 
statement indicates that the data being read are already in the structure of 
a SAS data set, and therefore merely gives the name of the data set.;

LIBNAME readin "D:\DATS7510\SAS\Christopher-Brunswick";
DATA Tumor;
SET readin.Tumor;
FORMAT Institution fmtinstitution. Group fmtgroup. MOD fmtmod. CT fmtcelltype. Oper fmtoperated. SurvCat fmtsurvivalcat.;     
PROC PRINT DATA=Tumor;
RUN;


*Run a PROC CONTENTS on the data set to determine the variable names. Practice options: SHORT, VARNUM...;
*VARNUM: prints a list of variable names in order of their logical position in the data set
*SHORT: prints only the list of variable names, index information, and the sort information for
the data set;

PROC CONTENTS DATA=Tumor; *varnum; *short;
RUN;

*Run a PROC FREQ on the Group and Survival Category variables as well as a cross tabulation of these two variables.
Practice options: LIST MISSING NOCOL NOROW NOPERCENT OUT = Ooutput the statistics to permanent SAS data set.;

PROC FREQ DATA=Tumor ;
*BY Group SurvCat;
*QUESTION QUESTION QUESTION - the OUT procedure have to be on the same line as 
the statistical option specified? Can i place an OUT procedure anywhere in the code?;
TABLE Group*SurvCat; */LIST OUT=readin.permTumor; */NOPERCENT; */NOROW; */NOCOL; */MISSING;
RUN;

*Run a PROC MEANS of survival (integer) and printing the N,mean,standard deviation,
and median for each treatment group using the CLASS statement and then PROC SORT
with a BY statement. Output the statistics to a temporary SAS data set.;
PROC MEANS DATA=Tumor N MEAN STDDEV MEDIAN;
CLASS Group;
VAR SurvInt;
OUTPUT out=outputmean 
RUN;



*Run a PROC UNIVARIATE on survival with the PLOT and NORMAL options overall and sing a class statement with the
treatment group variable.;
*Normal tests for normal distribution of data;
PROC UNIVARIATE DATA=Tumor PLOT; *NORMAL; 
CLASS Group;
var SurvInt;
RUN;

*Run a PROC TTEST on survival with the treatment group as the CLASS variable;
PROC TTEST DATA=Tumor;
CLASS Group;
VAR SurvI;
RUN;

*before using proc plot you must sort the data first only if you;
PROC SORT DATA=Tumor;
BY Group;
RUN;


PROC PLOT DATA=Tumor;
PLOT SurvCat*stgea="o";
RUN;




