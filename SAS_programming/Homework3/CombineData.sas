/****************************
   Class # 11 
****************************/

data one;
  input id timept x y;
datalines;
1 1 56 5
2 1 45 7
3 1 23 1
4 1 98 8
5 1 59 2
;
run;

data two;
  input id timept x y sex;
datalines;
1  2 43 4 1
2  2 82 2 1
3  2 36 6 2
4  2 21 1 1
5  2 65 2 2
6  2 33 3 2
7  2 62 8 1
8  2 78 3 1
9  2 54 6 2
10 2 57 7 1
;
run;

data concat;
  set one  two ;

run;

proc print data=concat;
title 'Concatenated Data Sets';
run;

proc sort data=one; by id;
RUN;
proc sort data=two; by id;
RUN;

data interleave;
  set one two ;
  by id;
run;

proc print data=interleave;
title 'Interleaved Data Sets';
run;

run;
quit;
run;


/****One by One DATA MERGE***/

data class;
   input Name $ 1-25 Year $ 26-34 Major $ 36-50;
   datalines;
Abbott, Jennifer         first
Carter, Tom              third     Theater
Kirby, Elissa            fourth    Mathematics
Tucker, Rachel           first
Uhl, Roland              second
Wacenske, Maurice        third     Theater
;
proc print data=class;
   title 'Acting Class Roster';
run;


data time_slot;
   input Date date9.  @12 Time $ @19 Room $;
   format date date9.;
   datalines;
14sep2000  10:00  103
14sep2000  10:30  103
14sep2000  11:00  207
15sep2000  10:00  105
15sep2000  10:30  105
17sep2000  11:00  207
;
proc print data=time_slot;
   title 'Dates, Times, and Locations of Conferences';
run;

data schedule;
   merge class time_slot;
run;

proc print data=schedule;
   title 'Student Conference Assignments';
run;

/*** Match Merging***/
*merging by name
in order to merge by name make sure names for both data sets are spelled correctly;
data company;
   input Name $ 1-25 Age 27-28 Gender $ 30;
   datalines;
Vincent, Martina          34 F
Phillipon, Marie-Odile    28 F
Gunter, Thomas            27 M
Harbinger, Nicholas       36 M
Benito, Gisela            32 F
Rudelich, Herbert         39 M
Sirignano, Emily          22 F
Morrison, Michael         32 M
;

proc sort data=company;
   by Name;
run;

data finance;
   input IdNumber $ 1-11 Name $ 13-40 Salary;
   datalines;
074-53-9892 Vincent, Martina             35000
776-84-5391 Phillipon, Marie-Odile       29750
929-75-0218 Gunter, Thomas               27500
446-93-2122 Harbinger, Nicholas          33900
228-88-9649 Benito, Gisela               28000
029-46-9261 Rudelich, Herbert            35000
442-21-8075 Sirignano, Emily             5000
;
proc sort data=finance;
   by Name;
run;
proc print data=company;
   title 'Little Theater Company Roster';
run;

proc print data=finance;
   title 'Little Theater Employee Information';
run;

data employee_info;
   merge company finance;
   by name;
run;

proc print data=employee_info;
   title 'Little Theater Employee Information';
   title2 '(including personal and financial information)';
run;


/**For entertainment using "if _n_=1 then set" to merge the one observation data to a multipl ons data set**/

proc means data=interleave mean std noprint;
  var x;
  output out=meanstd mean=meanx std=stdx;
run;

proc print data=meanstd;
title 'Single Observation Data Set';
run;

data keepone;
  if _n_=1 then set meanstd; **** single obs having only mean and std****;
  set interleave;          **** bigger data set to attach mean and std to ****;
  xzscore=(x-meanx)/stdx;
 
proc print data=keepone;
title 'Attaching Mean and Std to Each Obs in keepsoneonly dataset';
run;

run;
quit;
run;
