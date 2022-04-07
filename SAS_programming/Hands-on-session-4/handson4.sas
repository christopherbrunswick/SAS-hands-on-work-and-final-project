*We will be using the data set named "spiritual" located in the D2L handson folder. In the "spiritual"
data set are data for the Spiritual Well Being scale, a 20 item questionnaire with values of each item
ranging from 1 to6 on a likert scale of agreement with the item statement. A value of 1=Strongly Agree,
2=Moderately Agree, 3=Agree, 4=Disagree, 5=Moderately Disagree, and 6=Strongly Disagree. The Spiritual Well-Being
provides an overall measure of the perception of spiritual quality of life. The Religious Well-being subscale provides
a self-assessment of one's relationships with God, while the Existential Well-being subscale provides a self-assessment
of one's sense of life and life satisfaction.

There are 103 observations in the data set and 21 variables, id and swb1-swb20

1) Create a SAS program that reads in this data;

*2) Create an ARRAY statement that contains the Spritual Well Being questionnaire items
that need to be reversed. These are items swb3, swb4, swb7, swb8, swb10, swb11, swb14, swb15
swb17, swb19, and swb20.;

*3) Then create an indexing DO loop that reverses the items in the ARRAY statement. Make
sure you END the loop.;


*4) After reversing the items create the following scores:
	A total score that is the sum of all the items

	A religious well-being subscale which consists of all the even numbered
	questionnaire items

	An existential well-being subscale which consists of all the even numbered
	questionnaire items;

*5) Using the total score, create spiritual wellbeing groups of low, moderate
and high defining low as being less than 55, moderate being between 55 and less than 90,
and high being greater than or equal to 90.;

LIBNAME spirit "D:\SASProgrammingPractice\Hands-on-session-4";

DATA spiritdata;
SET spirit.spiritual;
ARRAY sdata(11) swb3 swb4 swb7 swb8 swb10 swb11 swb14 swb15 swb17 swb19 swb20;
	DO i=1 to 11;
	  sdata(i)=7-sdata(i);
END;

 totalscore = sum(swb1-swb20);
relwelbei = sum(swb1,swb3,swb5,swb7,swb9,swb11,swb13,swb15,swb17,swb19);
existwelbei = sum(swb2,swb4,swb6,swb8,swb10,swb12,swb14,swb16,swb18,swb20);

IF 0<totalscore<55 then lowspirit=1;
IF 55<totalscore<90 then midspirit=2;
IF totalscore>90 then highspirit=3;
PROC PRINT DATA=spiritdata;
RUN;



* We will be using two permanent SAS data sets that are stored in the D2L handson folder
The data in the "quest1" and "quest24" collected information on current smoking satatus
and their stage of change at week 1 and week 24 of an intervention study to help low-income,
African American women quit smoking. There are 4 variables in each data set and 103
observations in week 1 and 90 in week 24.;

*1) Create a SAS program that reads in both of these data sets, one data step for each.

2) In the week 1 data set, create a new numeric variable, soc, from the "character"
variable stagech. Drop the stagech variable from the week 1 data set.

3) In the week 24 data set, create a new numeric variable, soc, from the numeric
variable stagech. Drop the stagech variable from the week 24 data set.

4) Now both data sets have variables with the same names and same types.
;

LIBNAME quest "D:\SASProgrammingPractice\Hands-on-session-4";
DATA quest1;
SET quest.quest1;
	soc= 1*stagech;
DROP stagech;
RUN;
DATA quest24;
SET quest.quest24;
	soc= 1*stagech;
DROP stagech;
*PROC PRINT;
RUN;

*5) Create a new data step that sets both these data sets into one. This is 
concatenating the data sets together;

DATA ALL;
SET quest1 quest24;
*IF cursmoke = 1 and soc = 1 then stagech = 1
ELSE IF cursmoke = 1 and soc = 2 then stagech = 2
ELSE IF cursmoke = 1 and soc = 3 then stagech = 3
ELSE IF cursmoke = 2 then stagech = 2
ELSE IF cursmoke = 3 then stagech = 5;

*6) Create a stage of change group variable based on the individual's current smoking
status (cursmoke) and their current stage of change (soc). We will do this using an IF-THEN_DO

	a) if the individual is a current smoker (=1) and their stage of change is 1=yes, 30 days then 
their stage of change group is 1

	b) if the individual is a current smoker (=1) and their stage of change is 2=yes, 6 months
 then their stage of change group is 2.

	c) If the individual is a current smoker (=1) and their stage of change group is 3=no then their
stage of change group is 3

    d) If the individual quit in the last 6 months (=2) then their stage of change roup is 4,
regardless of their answer on soc

	e) If the individual is a never smoker (=3) then their stage of change group is 5, regardless of 
their answer on soc.;
 
if cursmoke=1 then do;
 if soc=1 then socgrp=1;
 else if soc=2 then socgrp=2;
 else if soc=2 then socgrp=3;
 end;

 else if cursmoke=2 then socgrp=4;
 else if cursmoke=3 then socgrp=5;

*7) Print out the old and new variables and make sure you are assigning people to groups correctly.;

 PROC PRINT DATA=ALL;
 VAR id week cursmoke soc socgrp;
 RUN;

 *8) Sort quest1 and quest24 by the id variables;

 PROC SORT DATA=quest1;
 by id;
 run;
 proc sort data=quest24;
 by id;
 run;


 *9) Create a new temporary SAS data set named questb that interleaves quest1 and quest24 by the id variable.
 Will the number of observations and variables be the same as the concatenated data set questa?;

 data questb;
 set quest1 quest24;
 by id;
 run;

PROC PRINT;
RUN;
