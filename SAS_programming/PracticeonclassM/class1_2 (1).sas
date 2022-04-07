/* Class One and Two*/

/**** Example 1 - List Input*****/
DATA student;
	input Name $ Gender $ age level;
	DATALINES;

*Adams M 17 4
Phillip M 14 3
Amanda F 18 2
Jane F 13 5


proc print;
run;



/**** Example 2 - List Input with missing data*****/
DATA student;
	input name $ gender $ age level;
	DATALINES;
Adams M	16	4
Phillip . 13 3
Amanda	F . 2
Jane F 17 5
;
proc print;
run;



/**** Example 3 - Column Input *****/
DATA student;
	INPUT fname $ 1-10 id 11-13 sex $ 15 gpa 17-19 ht 21-22 wt 23-26;
DATALINES;
Hector    123 M 3.5 59155
Nancy     328 F 3.7 52 99
Edwald    747 M 2.4 62 205
Michelle  778 F 3.0 54115
Washington289 M 3.5 60180
	;
*RUN;

PROC PRINT; 
*DATA=student;
RUN;



/**** Example 4 - Column Input with only selected variables*****/
DATA student;
	input name $1-7 gender $9 age $12-14 level 17;
*---+----+----+----+;DATALINES;
Adams 	M	16	4
Phillip M 	13 	3
Amanda	F 	15  2
Jane 	F 	17 	5
;
proc print;
run;



/**** Example 5 - Use @ as pointer*****/

DATA student;
	input name $1-7 @ gender $ @12 age 4. @16 level;
*---+----+----+----+---;DATALINES;
Adams  M   16.04
PhillipM   13.0 3
Amanda F   15.2 2
Jane   F   17.65
;
proc print;
run;




/**** Example 6 - informat Input, reading data not in standard format *****/

DATA student;
	input name $ gender $ age level date mmddyy10. TotHours comma5.;
DATALINES;
Adams M 16.0 4 1-12-1960 4,568
Phillip M 13.0 3 2-13-1960 1,258
Amanda F 15.2 2 1/2/1960  2,589
Jane F 17.6 5 01/01/19607,895
;
proc print;
run;





/**** Example 7 - mixed Input *****/

DATA instructor;
	input name $ 1-7 gender $ age @21 level  @23 date mmddyy10. +2 Totload comma5. +1 time time8.;
DATALINES;
Adams   M   16.0    4  1-12-1960  4,568  0:01
Phillip M   13.0    3  2-13-1960  1,258 12:00
Amanda  F   15.2    2  1/2/1960   2,589  0:10
Jane    F   17.6    5  1/1/1960   7,895 24:00
;
proc print;
run;





/**** Example 8 - Input multiple observations per line*****/
DATA student;
	input name $ gender $ age level @@;
	DATALINES;

Adams M	16 4 Phillip M 13 3 Amanda F 15 2 Jane F 17 5
;
proc print;
run;



/**** Example 9 - Reading multiple line per observation*****/
DATA highlow;
	input city $ State $
	NormalHigh NormalLow
    RecordHigh RecordLow;
DATALINES;
Nome AK
55 44
88 29
Miami FL
90 75
97 65
Raleigh NC
88 68
105 50
;
proc print;
run;




/* Example 10 - Use of the @ Symbol, to hold the line for other input */
DATA survey;
	INPUT year 15-19 @;
	if year=1994 then input id $ 1-3 sex $ 4 party $ 5 vote $ 6 tv 7-8;
	else if year=1995 then input id $ 1-3 age 4-5 sex $ 6 party $ 7 vote $ 8 tv 9-10;
DATALINES;
001MRY 3      1994 
00923FDY 1    1995 
012FDN 2      1994 
00518MRN 2    1995 
003MDY 4      1994 
;
RUN;

PROC PRINT DATA=survey;
RUN;



Data Student Address;
INPUT name $ sex $ age $ score $ state $ year $ address $24-45;
DATALINES;
Adams   M 16 4 TX 1995 114Maple Ave.
Phillip M 15 5 GA 1999 1320Washington Drive.
Amanda  F 15 5 GA 1995 45S.E. 14th Street.
Jane    F 14 4 SC 1999 301Dana Drive.
;
PROC PRINT;
RUN;

