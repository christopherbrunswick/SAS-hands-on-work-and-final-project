*We will input this data set using list input in two different ways:
1.	With one row per observation
2.	Using the @@ symbol for reading multiple observations per row.;

DATA question1a;
INPUT Dosage Beats Chairs;
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
DATA question2a;
INFILE "E:\SASProgrammingPractice\Chp15_dat.txt";
INPUT PatientID:Integer 1-4 Institution:_MemorialSloan-Kettering_1Mayo_Clinic_0John Hopkins_2 @7
Group:_Study_1 Control_0 @11 MeansofDetection:Routine Cytology_0Routine X-ray_1_Bothx-ray_and_Cytology_2_Interval_3 @15
Cell_Type:_Epidermoid_0_Adenocarcinoma_1_Large Cell_2_Oat Cell_3_Other_4 @19 StageA_1_2_3_-_overall stage @23
StageB_1_2_3_-_tumor @27 StageC_0_1_2_-_lymph nodes @30 StageD_0_1_-_distant_metastases @33
Operated:-yes_1_no_0 @37 Survival:_Interger_Days_from_detection_to_last_eate_known_alive @41-44
Survival_Category:_Alive_0_Dead_of_lung_cancer_1_Dead_of_other_causes_2 @48
;
LABEL PatientID:Integer="Patient ID: Integer";
LABEL Institution:_MemorialSloan-Kettering_1Mayo_Clinic_0John Hopkins_2="Institution:
0 - MSK, 1 - MC, 2 - JH";
LABEL Group:_Study_1 Control_0="Group: 1 - Study, 0 - Control";
LABEL MeansofDetection:Routine Cytology_0Routine X-ray_1_Bothx-ray_and_Cytology_2_Interval_3="Means of Detection: 
0 - Routine Cytology, 1 - Routine X-ray, 2 - Both X-ray and Cytology, 3 - Interval";
LABEL Cell_Type:_Epidermoid_0_Adenocarcinoma_1_Large Cell_2_Oat Cell_3_Other_4="Cell Type: 
0 - Epidermoid, 1 - Adenocarcinoma, 2 - Large Cell, 3 - Oat Cell, 4 - Other";
LABEL StageA_1_2_3_-_overall stage="Stage A (1,2,3) - overall stage";
LABEL StageB_1_2_3_-_tumor="Stage B (1,2,3) - tumor";
LABEL StageC_0_1_2_-_lymph nodes="Stage C (1,2,3) - lymph nodes";
LABEL StageD_0_1_-_distant_metastases="Stage D (1,2,3) - distant metastases";
LABEL Operated:-yes_1_no_0="Operated: 1 - yes, 2 - no";
LABEL Survival:_Interger_Days_from_detection_to_last_eate_known_alive="Survival: Integer Days from detection
to last date known alive";
LABEL Survival_Category:_Alive_0_Dead_of_lung_cancer_1_Dead_of_other_causes_2="Survival Category: 0 - Alive, 
1 - Dead of lung cancer, 2 - Dead of other causes";

DATA questn2.Tumor;
SET question2a;
RUN;


*TXT File "HOUSEHLD1.TXT" is part of census data set and is located in the D2L - 
HandsOn/Handson1 folder. We would like to get the following information to create a 
permanent SAS data named "househldCensus".;

LIBNAME questn3 "E:\DATS7510\SAS\Christopher-Brunswick";
DATA question3a;
INFILE "E:\SASProgrammingPractice\Homework1\HOUSEHLD1.txt";
INPUT HHX 7-12 REGION $42 WTIA 44-48. WTFA_HH 51-54 STRATUM 55-57 GENDER 58;
DATA questn3.househldCensus;
SET question3a;
RUN;


*Practice the IMPORT and EXPORT
