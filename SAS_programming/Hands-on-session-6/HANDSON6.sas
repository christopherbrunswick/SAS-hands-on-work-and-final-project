LIBNAME handson6 "D:\SASProgrammingPractice\Hands-on-session-6";

DATA handonsix;
SET handson6.tumor;
RUN;

ODS TRACE ON;
PROC GLM DATA=handonsix;
CLASS stagea;
MODEL SURVIVAL=STAGEA;
ODS SELECT GLM.ANOVA.survival.ModelANOV; 
ODS SELECT GLM.ANOVA.survival.FitStatistic;
ODS OUTPUT GLM.ANOVA.survival.ModelANOV = astage;
RUN;

PROC GLM DATA=handonsix;
CLASS stageb;
MODEL SURVIVAL=STAGEA;
ODS SELECT GLM.ANOVA.survival.ModelANOVA;
ODS SELECT GLM.ANOVA.survival.FitStatistics;
ODS OUTPUT GLM.ANOVA.survival.ModelANOVA = bstage;
RUN;

PROC GLM DATA=handonsix;
CLASS stagec;
MODEL SURVIVAL=STAGEA;
ODS SELECT GLM.ANOVA.survival.ModelANOVA;
ODS SELECT GLM.ANOVA.survival.FitStatistics;
ODS OUTPUT GLM.ANOVA.survival.ModelANOVA = cstage;
RUN;

PROC GLM DATA=handonsix;
CLASS detectiontype;
MODEL SURVIVAL=STAGEA;
ODS SELECT GLM.ANOVA.survival.ModelANOVA;
ODS SELECT GLM.ANOVA.survival.FitStatistics;
ODS OUTPUT GLM.ANOVA.survival.ModelANOVA = dectecttype;
RUN;

PROC GLM DATA=handonsix;
CLASS celltype;
MODEL SURVIVAL=STAGEA;
ODS SELECT GLM.ANOVA.survival.ModelANOVA;
ODS SELECT GLM.ANOVA.survival.FitStatistics;
ODS OUTPUT GLM.ANOVA.survival.ModelANOVA = ctype;
RUN;
ODS TRACE OFF;

DATA All;
SET astage bstage cstage detecttype ctype;
RUN;

%macro samplel1 (var=, tb=);
proc glm data=tumor1;
class &var;
model survival=&var;
ODS SELECT GLM.ANOVA.survival.ModelANOVA;
ODS SELECT GLM.ANOVA.survival.FitStatistics;
RUN;

%mend sample;
%sample (var=stagea)
%sample (var=stageb)
%sample (var=stagec)
%sample (var=dectectiontype)
%sample (var=celltype)
run;

%macro sample1 (var=, tb=)
proc glm data=handonsix;
class &var;
model survival=&var;
ods output modelANOVA=&tb;

run;

%mend sample1;
%sample1 (var=stagea, tb=a)
%sample1 (var=stageb, tb=b)
%sample1 (var=stagec, tb=c)
%sample1 (var=detectiontype, tb=dt)
%sample1 (var=celltype, tb=ct)
run;

data table1;
set a b c dt ct;
if HypothesisType=3;
run;

PROC EXPORT DATA= Work.Table1 (drop=Hypothesistype)
	outfile=
	DBMS= EXCEL REPLAE;
	sheet
	run;
 
