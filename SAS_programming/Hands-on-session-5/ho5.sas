options nocenter pageno=1;

data kidney;
  infile "D:\SASProgrammingPractice\Hands-on-session-5";
  input animal 1-2 Group $ 4-10 UFR0 12-15 UFR30 17-20 UFR60 22-25
        UFR90 27-30 UFR120 32-35 UFR150 37-40 UFR180 42-45 Na0 47-50
        Na30 52-55 Na60 57-60 Na90 62-65 Na120 67-70 Na150 72-75
        Na180 77-80 K0 82-85 K30 87-90 K60 92-95 K90 97-100 K120 102-105
        K150 107-110 K180 112-115;
run;

proc print data=kidney;
run;
