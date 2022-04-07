LIBNAME data "D:\SASProgrammingPractice\Hands-on-session-5";

DATA demog;
SET data.demog;
RUN;
DATA quest1;
SET data.quest1;
soc= 1*stagech;
DROP stagech;
RUN;
DATA quest24;
SET data.quest24;
soc= 1*stagech;
DROP stagech;
RENAME cursmoke=cursmoke24 soc=soc24;
RUN;

PROC SORT DATA=demog;
BY id;
RUN;
PROC SORT DATA=quest1;
BY id;
RUN;
PROC SORT DATA=quest24;
BY id;
RUN;

DATA all;
*create temporary indicator variable if subject in data is 1; 
MERGE demog (IN=dem) quest1 (IN=questO) quest24 (IN=questT);
BY id;
IF questO = 1 & questT = 1;
PROC PRINT DATA=all;
RUN;

DATA prepost;
SET quest1 quest24;
BY id;
RUN;

DATA all_long;
MERGE demog (IN=dem) prepost (IN=pp);
BY id;
IF pp = 1;
PROC PRINT DATA=all_long;
RUN;


