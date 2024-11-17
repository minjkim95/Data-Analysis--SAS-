

proc contents data= sasuser.nhanes1516;
run;

proc print data=week1.nhanes1516 (obs=1) noobs;
where seqn=83732;
var riagendr;
run;

proc freq data=week1.nhanes1516;
tables riagendr*DUQ200/list nocol;
run;

proc univariate data=week1.nhanes1516 plot;
var ridageyr;
run;

proc means data=week1.nhanes1516;
var ridageyr;
run;

data _null_;
call sound (900,500);
run;


