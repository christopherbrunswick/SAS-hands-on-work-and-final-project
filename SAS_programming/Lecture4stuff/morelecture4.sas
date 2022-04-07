data wheeze;
	infile "D:\SASProgrammingPractice\PracticeonclassM\whee.txt";
	input case city $ age smoke wheeze @@;

	label   age="age of subject"
            city="subject's city"
           smoke="mother smokes";
proc print data=wheeze;     
run;

/*** automatically display labels if exits***/

proc freq data=wheeze;
table city*smoke;
*table city*smoke*age;
run;

/****Option is avaliable to display labels***/

proc print  label;
run;

/**** no label option is avaliable, only variable name can be shown***/

proc genmod data=wheeze ;
	class case city;
	model wheeze = city age / dist=binomial;
     repeated subject=case;
     run;

 /*** directly creating new variables with descriptive labels**/

options validvarname=any;
   
   data wheeze; 
     set wheeze;
     "age of subject"n=age;
     "subject's city"n=city;
	 "mother smokes"n=smoke;
     run;
   proc genmod data=wheeze;
     class case "subject's city"n;
     model wheeze = "subject's city"n 
                    "age of subject"n / dist=binomial;
     repeated subject=case;
     run;
