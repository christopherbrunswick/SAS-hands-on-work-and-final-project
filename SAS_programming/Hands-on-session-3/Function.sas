
/**** Date functions***/
data lib;
infile "E:\SASProgrammingPractice\Hands-on-session-3\library.txt";
input name $4. dateCheck mmddyy10.;
proc print;
format dateCheck mmddyy10.;
run;

*Built-in Date functions: DAY, MDY, MONTH, QTR, TODAY;
*creating DateDue, DDay, DMonth, DQuarter, DaysOverDue, DateClose variables;
data library;
set lib;
DateDue=DateCheck + 21;
DDay=DAY(DateDue);
DMonth=MONTH(DateDue);
DQuarter=QTR (DateDue);
DaysOverDue=Today() - DateDue;
DateClose=MDY(9,6,2010);
proc print;
format dateCheck mmddyy10. DateDue mmddyy10. DateClose mmddyy10.;
run;

*setting linesize and pagesize;
options ls=146 ps=76;
/**** Numeric Function****/

*Built-in Number functions: INT, LOG10, MAX, Mean, MIN, ROUND, SUM, SQRT, LAG, DIF, ABS;
*creating new variables: maxscore, minscore, sqrtS1, logS1, ranscore, sumscore, avescore, INTScore1, Rscore4; 
Data income;
input name  $8. age Scr1 Scr2 SCR3 SCR4;
abss1s2=ABS(scr2-scr1);
maxscore=MAX (scr1,scr2,scr3,scr4);
minscore=MIN (scr1,scr2,scr3,scr4);
SqrtS1=SQRT (scr1);
logS1=LOG (scr1);
ranscore=range(scr1,scr2,scr3,scr4);
Sumscore=SUM(scr1,scr2,scr3,scr4);
avescore=mean(scr1, scr2, scr3, scr4);
INTScore1 = INT(scr1);
Rscore4 = round (scr4,.1);
cards;
Janet 	55 7.82 6.52 7.21 8.03
Margaret   23 6.51 5.63 8.55 7.64
John 		46 5.92 7.44 9.17 6.52
;
proc print;
run;

*Built-in functions: LAG, DIF;
data uscpi;
      input date $ cpi; 
      cpilag = lag( cpi );
	  cpidif = dif( cpi );
      cpidif2 = dif2( cpi );
Datalines;
Jun-90	129.9
Jul-90	130.4
Aug-90	131.6
Sep-90	132.7
Oct-90	133.5
Nov-90	133.8
Dec-90	133.8
Jan-91	134.6
Feb-91	134.8
Mar-91	135
Apr-91	135.2

   proc print data=uscpi;
   run;

*setting linesize and pagesize;
options ls=76 ps=76;
/*** Charac Functions: Substr, ||, TRIM, LEFT**/

*when reading in permanent data, the new data set name and what you're setting the new data set as (name)
CAN'T be the same;
libname in 'E:\SASProgrammingPractice\Hands-on-session-3';

data tempclaims;
  set in.claims;

  *SUBSTR procedure starting at value 1 of what the variable is assigned to all the way to n;
  *If the first 3 values of the dx1 variable are ... or the first 4 values are equal to .... or 
  the first 3 values of the dx2 variable are ... or the first 4 values are equal to ... then create a new variable
  and assign 1 to it otherwise assign 0 to it.;
  if substr(dx1,1,3) in ('490','491','492','493','494','495','496',
        '500','501','502','503','504','505') or
     substr(dx1,1,4)='5064' or
     substr(dx2,1,3) in ('490','491','492','493','494','495','496',
        '500','501','502','503','504','505') or
     substr(dx2,1,4)='5064' then cpd=1;
  else cpd=0;

*if the first 4 values of the dx1 variable are ... or the first 4 values of the dx2 variable are ...
  then create a new variable diabnc and assign it 1 otherwise assign it 0.;
 if substr(dx1,1,4) in ('2500','2501','2502','2503','2507') or
     substr(dx2,1,4) in ('2500','2501','2502','2503','2507') then diabnc=1;
 else diabnc=0;

 *if the first 4 values of the dx1 variable are ... or the first 4 values of the dx2 variable are ... 
 then create a new variable diabc and assign it 1 otherwise assign it 0.;
 if substr(dx1,1,4) in ('2504','2505','2506') or
     substr(dx2,1,4) in ('2504','2505','2506') then diabc=1;
 else diabc=0;

 *drop variables claimtyp dx3 dx4 dx5 dx6;
 drop claimtyp dx3-dx6;
PROC PRINT DATA=tempclaims;
run;

proc print data=tempclaims (obs=100);
  var mbrid dx1-dx2 cpd diabnc diabc;
title 'Debug for Creation of Diagnoses';
run;
proc freq data=tempclaims;
  tables cpd diabnc diabc;
title 'Disbribution of Various Diagnoses Across Claims';
run;


LIBNAME surv "E:\SASProgrammingPractice\Hands-on-session-3";
PROC IMPORT OUT= WORK.EXP
            DATAFILE= "E:\SASProgrammingPractice\Hands-on-session-3\Survey.xls" 
            DBMS=EXCEL REPLACE;
     RANGE="Sheet1$";
     GETNAMES=YES;
     MIXED=NO;
     SCANTEXT=YES;
     USEDATE=YES;
     SCANTIME=YES;
RUN;



data exp8;
set exp;
full_name= first||' '||Last;
full_name1= TRIM(first)||' '||Last;
race1=translate (race, 'a','o');
age_n=substr(age,1,2);

Bef_Left=Substr(age,3,4);
Aft_Left=LEFT(Substr(age,3,4));
Scan_Age=SCAN(age,-1,' ');

/**** Use LEFT and SUBSTR Functions****/
/*if LEFT(Substr(age,3,4))='mo' then age_day=age_n*30;*/
/*else if LEFT(Substr(age,3,4))='year' then age_day=age_n*365.25;*/
/*else age_day=age_n;*/

/*** Using SCAN Function***/

/*if SCAN(age,-1,' ')='mo' then age_day=age_n*30;*/
/*else if SCAN(age,-1,' ')='year' then age_day=age_n*365.25;*/
/*else age_day=age_n;*/

proc print;
run;

/****************Scan****************/
data first_last;
input @1 name $20.
@21 phone $13.;
/***extract the last, middle, first name from name***/
last_name = scan(name,-1,' '); /* scans from the right */
first_name= scan(name,1,' ');
Middle_name= scan (name, 2, ' ');
datalines;
Jeff W. Snoker      (908)782-4382
Raymond Albert      (732)235-4444
Alfred Edward Newman(800)123-4321
Steven J. Foster    (201)567-9876
Jose Romerez        (516)593-2377
;
proc sort data=first_last;
by last_name;
proc print;
run;


/************* Compbl*****/
data multiple;
input #1 @1 name $20.
#2 @1 address $30.
#3 @1 city $15.
@20 state $2.
@25 zip $5.;
name = compbl(name);
address = compbl(address);
city = compbl(city);
datalines;
Ron      Cody
89    Lazy     Brook    Road
Flemington         NJ   08822
Bill     Brown
28       Cathy       Street
North    City      NY   11518
;
title "Listing of Data Set MULTIPLE";
proc print data=multiple noobs;
id name;
var address city state zip;
run;


/*************** Compress*****************/
data phone;
input phone $ 1-15;
phone1 = compress(phone);
phone2 = compress(phone,'(-) ');
datalines;
(908)235-4490
(201) 555-77 99
;
title "Listing of Data Set PHONE";
proc print data=phone noobs;
run;

