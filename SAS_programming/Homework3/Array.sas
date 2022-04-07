/****************************
   Class # 9
****************************/


/**** Change all 9s to missing value***/
Data song;
infile 'F:\Examples\Lecture 9\song.txt';
input City $ 1-8 age  domk wj hwow simbh kt aomn libm ty flip ttr;

*** Use the IF THEN statement to change 9 to missing;
if domk = 9 then domk = .;
if wj = 9  then wj = .;
if hwow = 9 then hwow = .;
if simbh = 9 then simbh = .;
if kt = 9 then kt = .;
if aomn = 9 then aomn = .;
if libm = 9 then libm = .;
if ty = 9 then ty = .;
if flip = 9 then flip = .;
if ttr = 9 then ttr = .;

*** Using ARRAY to change 9 to missing**;
*ARRAY is shortcut over using if statements
the index is 10 because there are 10 variables; 
ARRAY song(10)domk wj hwow simbh kt aomn libm ty flip ttr;
 do i=1 to 10;
 	IF song(i) = 9 then song(i)=.;
 end;
/*proc print;*/
/*run;*/


***Shortcuts for Lists of VariableName**;
ARRAY song domk -- ttr;
 do i = 1 to 10;
 	IF song(i) = 9 then song (i) =.;
 end;

/*proc print;*/
/*run;*/

/***Replace the old variables with new variables -- Index***/
 *numerical order only requires 1 line (-);
ARRAY new(10) song1 - song10;
Array old (10) domk -- ttr;
 do i=1 to 10;
 if old(i) = 9 then new(i)=.;
   else if old(i)~=9 then new(i)= old(i);
 end;


/** Using DO OVER without (i)- Nonindex**/
ARRAY song domk -- ttr;
 do over song;
 	IF song = 9 then song =.;
 end;


 /***Replace the old variables with new variables Using DO OVER without (i)***/
ARRAY new1  song1 - song10;
Array old1  domk -- ttr;
 do over old1;
 if old1 = 9 then new1=.;
   else if old1~=9 then new1= old1;
 end;
proc print;
run;

libname in 'F:\Examples\Lecture 9';

data tempclaims;
	set in.claims;

  /************************************************************
  ** Creation of new variables using lengthy IF-THEN-ELSE IF **
  ** statments.  Notice that the same operation is being     **
  ** performed on six different variables dx1-dx6.           **
  *************************************************************/
	if substr(dx1,1,3) in ('490','491','492','493','494','495','496',
                           '500','501','502','503','504','505') or
	   substr(dx1,1,4)='5064' or
       substr(dx2,1,3) in ('490','491','492','493','494','495','496',
                           '500','501','502','503','504','505') or
       substr(dx2,1,4)='5064' or
       substr(dx3,1,3) in ('490','491','492','493','494','495','496',
                           '500','501','502','503','504','505') or
       substr(dx3,1,4)='5064' or
       substr(dx4,1,3) in ('490','491','492','493','494','495','496',
           				   '500','501','502','503','504','505') or
       substr(dx4,1,4)='5064' or 
       substr(dx5,1,3) in ('490','491','492','493','494','495','496',
        				   '500','501','502','503','504','505') or
       substr(dx5,1,4)='5064' or 
       substr(dx6,1,3) in ('490','491','492','493','494','495','496',
        				   '500','501','502','503','504','505') or
       substr(dx6,1,4)='5064' then cpd=1;
	else cpd=0;

	if substr(dx1,1,4) in ('2500','2501','2502','2503','2507') or
       substr(dx2,1,4) in ('2500','2501','2502','2503','2507') or 
       substr(dx3,1,4) in ('2500','2501','2502','2503','2507') or 
       substr(dx4,1,4) in ('2500','2501','2502','2503','2507') or 
       substr(dx5,1,4) in ('2500','2501','2502','2503','2507') or
       substr(dx6,1,4) in ('2500','2501','2502','2503','2507') then diabnc=1;
	else diabnc=0;
	if substr(dx1,1,4) in ('2504','2505','2506') or
       substr(dx2,1,4) in ('2504','2505','2506') or
       substr(dx3,1,4) in ('2504','2505','2506') or
       substr(dx4,1,4) in ('2504','2505','2506') or
       substr(dx5,1,4) in ('2504','2505','2506') or
       substr(dx6,1,4) in ('2504','2505','2506') then diabc=1;
	else diabc=0;

  /*************************************************************
  **  Creating the same new diagnosis variables as above with **
  **  the use of an array and indexing DO loop. Notice how    **
  **  much shorter the code is. Note that with an indexing DO **
  **  loop you must first initialize any new variables to a   **
  **  starting value.                                         **
  **************************************************************/ 
	acpd=0; adiabnc=0; adiabc=0;
	array dx {6} dx1-dx6;
	do i=1 to 6;
		if substr(dx[i],1,3) in ('490','491','492','493','494','495','496',
        						 '500','501','502','503','504','505') or
		   substr(dx[i],1,4)='5064' then acpd=1;
		if substr(dx[i],1,4) in ('2500','2501','2502','2503','2507') then adiabnc=1;
		if substr(dx[i],1,4) in ('2504','2505','2506') then adiabc=1;
	end;
run;

proc print data=tempclaims (obs=100);
	var mbrid dx1-dx6 acpd adiabnc adiabc acpd adiabnc adiabc;
	title 'Debug for Creation of Diagnoses';
run;

proc freq data=tempclaims;
	tables cpd diabnc diabc acpd adiabnc adiabc;
	title 'Disbribution of Various Diagnoses Across Claims';
run;

run;
quit;
run;


