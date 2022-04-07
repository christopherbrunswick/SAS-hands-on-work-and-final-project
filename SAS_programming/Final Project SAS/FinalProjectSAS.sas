*1a) Create a program that concatenates the 7 biometry data sets into one data set. When you combined the data
sets you should end up with a data set that contains 187109 observations and 12 variables (10 originals and 2 new
created in the following steps);

LIBNAME Biometry "D:\SASProgrammingPractice\Final Project SAS";
DATA Biomdata0;
SET Biometry.ch19a;
RUN;
DATA Biomdata1;
SET Biometry.ch19b;
RUN;
DATA Biomdata2;
SET Biometry.ch19c;
RUN;
DATA Biomdata3;
SET Biometry.ch19d;
RUN;
DATA Biomdata4;
SET Biometry.ch19e;
RUN;
DATA Biomdata5;
SET Biometry.ch19f;
RUN;
DATA Biomdata6;
SET Biometry.ch19g;
RUN;


DATA All;
SET Biomdata0 Biomdata1 Biomdata2 Biomdata3 Biomdata4 Biomdata5 Biomdata6;

*1b) In the combined data set, create an age group variable with categories 35-44, 45-54, 55-64, 65-74, >=75;


		IF 35<=age<=44 THEN agegroup="35-44";
		ELSE IF 45<=age<=54 THEN agegroup="45-54";
		ELSE IF 55<=age<=64 THEN agegroup="55-64";
		ELSE IF 65<=age<=74 THEN agegroup="65-74";
		ELSE IF age>=75 THEN agegroup="75+";

*1c) Calculate a tobacco exposure variable in terms of the number of pack years. This is calculated as the number
	of cigarettes/day divided by 20 and then times the number of years smoked.;

		tobaccoexp=cigs/20*ysmoke;
PROC PRINT DATA=All;
RUN;

PROC CONTENTS DATA=All;
RUN;

*1d) Determine desciptive statistics for all variables, except the Count variable, that were existing
or you created in the data set.;

PROC MEANS DATA=All;
VAR age cigs ysmoke yrsquit follow tobaccoexp;
FREQ count;
RUN;

PROC FREQ DATA=All;
TABLES agegroup educ gender death smoker;
WEIGHT count;
RUN;


*1e) Perform a series of chi-square test to examine whether there are differences among the three smoker groups
(never, former, or current) with respect to age groups, sex, education, and death codes. (output);

PROC FREQ DATA=All;
TABLES smoker*(agegroup gender educ death)/CHISQ;
WEIGHT count;
RUN;


*lf) Perform a two-sample t-test on the tobacco exposure variable created in part c to examine
differences in former and current smokers (exclude those who never smoked from this analysis) (output);

PROC TTEST DATA=All;
paired tobaccoexp * smoker;
WHERE smoker ne 1;
FREQ count;
RUN;

*1g) Write a discussion of the results of your analyses including a description of the data and the results
of the chi-square, t-test. All statistical significance should be assessed using an alpha level of 0.05. (writing)

*The chi-square test performed on the smoking groups shows that the chi-square p-value is smaller than alpha when 
alpha level is at .05 therefore there is a significant difference
among the three smoker groups with respect to age groups, sex, education, and death codes;
*Similarly, the two-sample t-test performed on the tobacco exposure variable resulted in a p-value smaller than alpha
when alpha level is at .05 therefore there is a significant difference in former and current smokers.;

*PROC CONTENTS DATA=All
RUN;

LIBNAME BCSH "D:\SASProgrammingPractice\Final Project SAS";
DATA Dempts;
SET BCSH.dempts;
RUN;
PROC SORT DATA=Dempts;
BY studyid;
RUN;
DATA Aprx;
SET BCSH.aprx;
RUN;
PROC SORT DATA=Aprx;
BY studyid;
RUN;
DATA Aprxdx;
SET BCSH.aprxdx;
RUN;
PROC SORT DATA=Aprxdx;
BY studyid;
RUN;
DATA Cci;
SET BCSH.cci;
RUN;
PROC SORT DATA=Cci;
BY studyid;
RUN;
DATA Costutil;
SET BCSH.costutil;
RUN;
PROC SORT DATA=Costutil;
BY studyid;
RUN;

*2a) Merge the five data sets together by the variable studyid. Format all categorical variables that have been using
numbers (Variables started with "i" are all indicators (1='Yes' and 0='No') and female variable (1='Yes' and 0='No').
Don't forget the variables you created.;

PROC FORMAT;
	VALUE fmticnsrx
		1 = "yes"
		0 = "no"
		;
	VALUE fmticonven
		1 = "yes"
		0 = "no"
		;
	VALUE fmtiatypical
		1 = "yes"
		0 = "no"
		;
	VALUE fmtibenzo
		1 = "yes"
		0 = "no"
		;
	VALUE fmtianydx
		1 = "yes"
		0 = "no"
		;
	VALUE fmtidelirium
		1 = "yes"
		0 = "no"
		;
	VALUE fmtifalls
		1 = "yes"
		0 = "no"
		;
	VALUE fmtihip
		1 = "yes"
		0 = "no"
		;
	VALUE fmtifemur
		1 = "yes"
		0 = "no"
		;
	VALUE fmtistroke
		1 = "yes"
		0 = "no"
		;
	VALUE fmtidiab
		1 = "yes"
		0 = "no"
		;
	VALUE fmtidepress
		1 = "yes"
		0 = "no"
		;
	VALUE fmtialtercon
		1 = "yes"
		0 = "no"
		;
	VALUE fmtisyncope
		1 = "yes"
		0 = "no"
		;
	VALUE fmticonstipation
		1 = "yes"
		0 = "no"
		;
	VALUE fmtiapanydx
		1 = "yes"
		0 = "no"
		;
	VALUE fmtiapdelirium
		1 = "yes"
		0 = "no"
		;
	VALUE fmtiapfalls
		1 = "yes"
		0 = "no"
		;
	VALUE fmtiaphip
		1 = "yes"
		0 = "no"
		;
	VALUE fmtiapfemur
		1 = "yes"
		0 = "no"
		;
	VALUE fmtiapstroke
		1 = "yes"
		0 = "no"
		;
	VALUE fmtiapdiab
		1 = "yes"
		0 = "no"
		;
	VALUE fmtiapdepress
		1 = "yes"
		0 = "no"
		;
	VALUE fmtiapaltercon
		1 = "yes"
		0 = "no"
		;
	VALUE fmtiapsyncope
		1 = "yes"
		0 = "no"
		;
	VALUE fmtiapconstipation
		1 = "yes"
		0 = "no"
		;
	VALUE fmtimi
		1 = "yes"
		0 = "no"
		;
	VALUE fmtichf
		1 = "yes"
		0 = "no"
		;
	VALUE fmtipvd
		1 = "yes"
		0 = "no"
		;
	VALUE fmticvd
		1 = "yes"
		0 = "no"
		;
	VALUE fmticcidem
		1 = "yes"
		0 = "no"
		;
	VALUE fmticpd
		1 = "yes"
		0 = "no"
		;
	VALUE fmtirhemz
		1 = "yes"
		0 = "no"
		;
	VALUE fmtipud
		1 = "yes"
		0 = "no"
		;
	VALUE fmtimliverd
		1 = "yes"
		0 = "no"
		;
	VALUE fmtidiabnc
		1 = "yes"
		0 = "no"
		;
	VALUE fmtidiabc
		1 = "yes"
		0 = "no"
		;
	VALUE fmtihpplega
		1 = "yes"
		0 = "no"
		;
	VALUE fmtirenald
		1 = "yes"
		0 = "no"
		;
	VALUE fmticancer
		1 = "yes"
		0 = "no"
		;
	VALUE fmtimsliver
		1 = "yes"
		0 = "no"
		;
	VALUE fmtimcancer
		1 = "yes"
		0 = "no"
		;
	VALUE fmtiaids
		1 = "yes"
		0 = "no"
		;
	VALUE fmtfemale
		1 = "yes"
		0 = "no"
		;
RUN;

OPTIONS LS=MAX PS=MAX;

DATA Master;
MERGE Dempts Aprx Aprxdx Cci Costutil; 
BY studyid;
FORMAT icnsrx fmticnsrx. iconven fmticonven. iatypical fmtiatypical. ibenzo fmtibenzo. ianydx fmtianydx.
idelirium fmtidelirium. ifalls fmtifalls. ihip fmtihip. ifemur fmtifemur. istroke fmtistroke. idiab fmtidiab.
idepress fmtidepress. ialtercon fmtialtercon. isyncope fmtisyncope. iconstipation fmticonstipation.
iapanydx fmtiapanydx. iapdelirium fmtiapdelirium. iapfalls fmtiapfalls. iaphip fmtiaphip. iapfemur fmtiapfemur.
iapstroke fmtiapstroke. iapdiab fmtiapdiab. iapdepress fmtiapdepress. iapaltercon fmtiapaltercon. iapsyncope fmtiapsyncope.
iapconstipation fmtiapconstipation. imi fmtimi. ichf fmtichf. ipvd fmtipvd. icvd fmticvd. iccidem fmticcidem.
icpd fmticpd. irhemz fmtirhemz. ipud fmtipud. imliverd fmtimliverd. idiabnc fmtidiabnc. idiabc fmtidiabc. ihpplega fmtihpplega.
irenald fmtirenald. icancer fmticancer. imsliver fmtimsliver. imcancer fmtimcancer. iaids fmtiaids. female fmtfemale.;

*2b) Create a four leel variable antipsychotic type from the variables iconven (having a prescription fro a conventional
antipsychotic) and iatypical (having a prescription for an atypical antipsychotic) that has values 0=neither conventional 
nor atypical, 1=conventional only, 2=atypical only, 3=both conventional and nor atypical.;

	IF iconven = 0 & iatypical = 0 THEN antipsychotic = 0;
	ELSE IF iconven = 1 & iatypical = 0 THEN antipsychotic = 1;
	ELSE IF iconven = 0 & iatypical = 1 THEN antipsychotic = 2;
	ELSE IF iconven = 1 & iatypical = 1 THEN antipsychotic = 3;

*2c) There are four original cost variables: stpamt (total paid costs), sfpamt (facility paid costs), 
sppamt (provider paid costs), and srpamt (prescription paid costs). Using arrays and do loops, create two sets of 
transformed cost variables, the natural log of each of the costs and the square root of each of the costs.;

	ARRAY cost{4} stpamt sfpamt sppamt srpamt;
	ARRAY logcost{4} logstpamt logsfpamt logsppamt logsrpamt;
	ARRAY sqrtcost{4} sqrtstpamt sqrtsfpamt sqrtsppamt sqrtsrpamt;

		DO i = 1 to 4;
			logcost[i] = log(cost[i]);
			sqrtcost[i] = sqrt(cost[i]);
		END;

*2d) Create a variable from the number of types of prescriptions (srxtype) that has categories of 1,2-3,4-5,6+;

	IF srxtype = 1 THEN numtp = "1";
	ELSE IF 2<=srxtype<=3 THEN numtp = "2-3";
	ELSE IF 4<=srxtype<=5 THEN numtp = "4-5";
	ELSE IF srxtype>=6 THEN numtp = "6+";


*2e) Create an overall fracture variable (any fracture=1, non fracture=0) from ihip and ifemur;

	IF ihip = 1 & ifemur = 1 THEN overallfrac = 1;
	ELSE IF ihip = 1 & ifemur = 0 THEN overallfrac = 1;
	ELSE IF ihip = 0 & ifemur = 1 THEN overallfrac = 1;
	ELSE IF ihip = 0 & ifemur = 0 THEN overallfrac = 0;

*2f) Create an overall antipsychotic related fracture variable (any fracture =1, non fracture =0) from iaphip and iapfemur.;

	IF iaphip = 1 & iapfemur = 1 THEN overallpsych = 1;
	ELSE IF iaphip = 1 & iapfemur = 0 THEN overallpsych = 1;
	ELSE IF iaphip = 0 & iapfemur = 1 THEN overallpsych = 1;
	ELSE IF iaphip = 0 & iapfemur = 0 THEN overallpsych = 0;
PROC PRINT DATA=Master;
RUN;



*2g) Calculate desciptive statistics on all variables you created in parts b-f. (Output);

PROC MEANS DATA=Master;
VAR logstpamt logsfpamt logsppamt logsrpamt sqrtstpamt sqrtsfpamt sqrtsppamt sqrtsrpamt;
RUN;

PROC FREQ DATA=Master;
TABLES antipsychotic numtp overallfrac overallpsych; 
RUN;

*2h) Calculate descriptive statistics by the four levels antipsychotic variable you created in part b
for the followiing variables: the four natural log of cost variables from part c, the categorical variable of 
number of types of prescriptions from part d, and the overall fracture variable in part e and f. (Output);

PROC MEANS DATA=Master;
CLASS antipsychotic;
VAR logstpamt logsfpamt logsppamt logsrpamt;
RUN;

PROC FREQ DATA=Master;
TABLES antipsychotic * (numtp overallfrac overallpsych);
RUN;


*PROC CONTENTS DATA=Master
RUN;

*2i) Write a discussion of the results of your analyses including a description of the data overall and by the four
level antipsychotic variables; 

*3a) Create a temporary data set from the permanent "Diabetes" SAS data set, keep each patient's first visit only.;

LIBNAME diab "D:\SASProgrammingPractice\Final Project SAS";

DATA diabetes;
SET diab.diabetes;
WHERE Encounter_Number = 1;

*3b) Calculate the patient age at Admit date and the means, standard deviation, min, and max of the age.;

	patientage = (ADMIT_DATE - BIRTH_DATE)/365.25;

*3c) If the first five position of 15 diagnosis are "250.1" then it indicates "diabetes with ketoacidosis". Using "ARRAY"
and function "SUBSTR" to generate a new "diabetes with ketoacidosis" indicator variable, and "PROC freq" to count how
many "diabetes with ketoacidosis" patients in the first visit were diagnosed (Output);

ARRAY diag{15} DIAGNOSIS_1 DIAGNOSIS_2 DIAGNOSIS_3 DIAGNOSIS_4 DIAGNOSIS_5 DIAGNOSIS_6 DIAGNOSIS_7 DIAGNOSIS_8
DIAGNOSIS_9 DIAGNOSIS_10 DIAGNOSIS_11 DIAGNOSIS_12 DIAGNOSIS_13 DIAGNOSIS_14 DIAGNOSIS_15;

	DO i = 1 to 15;
	IF substr(diag[i],1,5) IN ('250.1') THEN diabwithketoa = 1;
	*ELSE IF diabwithketoa = "no";
	END;
		

PROC PRINT DATA=diabetes;
RUN;

PROC MEANS DATA=diabetes MEAN STDDEV MIN MAX;
VAR patientage;
RUN;

PROC FREQ DATA=diabetes;
TABLE diabwithketoa;
WEIGHT diabwithketoa;
WHERE Encounter_Number = 1;
RUN;

*PROC CONTENTS DATA=diabetes
RUN;
