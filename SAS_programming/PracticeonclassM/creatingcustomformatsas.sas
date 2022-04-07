options nocenter pageno=1;


/*** creat a temperary FORMAT****/; 

proc format;
value fmtage
20 - 29 = '20 - 29'
30 - 39 = '30 - 39'
40 - 49 = '40 - 49'
50 - 59 = '50 - 59'
60 - high = '60 +++';

value fmtsex
0 = 'Female'
1 = 'Male';


value fmtmart
1 = 'Single'
2 = 'Married'
3 = 'Separated'
4 = 'Divorced'
5 = 'Significant Other'
6 =	'Widowed';


value fmtedu
1 =	'No Education'
2 =	'Less than 8th Grade'
3 =	'Some High School'
4 =	'High School'
5 =	'GED'
6 =	'Some Technical School'
7 =	'Some College'
8 =	'Associates Degree'
9 =	'BA/BS College Degree';

run;


libname in "E:\Fall 2020\Lecture5";

data  demo ;
set in.demo;

format sex fmtsex. age fmtage. marital fmtmart. educ fmtedu. income dollar8.2;

label educ="Education";

run;

proc print label ;
run;



