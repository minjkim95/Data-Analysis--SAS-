
/**************************Excercise 1***************************8/
/*to get the percent received cessation advice for each category of year and 
ac49 (quit smoking in the past year)*/
proc freq data=sasuser.chis1417b;
tables (yearuse ac49)*ac78/ nocol nopercent chisq;
run;

/*to get the unadjusted ORs*/
proc logistic data=sasuser.chis1417b;
class yearuse (ref='2014') /*ac49 (ref='1')*// param=ref;
model ac78 /*(event ='1')*/= yearuse ;
run;

proc logistic data=sasuser.chis1417b;
class  ac49 (ref='1')/ param=ref;
model ac78 /*(event ='1')*/= ac49 ;
run;

/*adjusted OR*/
proc logistic data=sasuser.chis1417b;
class yearuse (ref='2014') ac49 (ref='1')/ param=ref;
model ac78 /*(event ='1')*/= yearuse ac49 ;
run;

/*********************Excercise 2******************************/
/*to get the percent with a usual source of care for each category
of year, education, and race*/
proc freq data=sasuser.chis1417b;
tables (yearuse education ombsrr_p1)*usourc;
run;

/*is the percent of adults with a usual source of care
increasing with education level*/
proc freq data=sasuser.chis1417b;
tables usourc*education/ trend;
run;

/*unadjusted OR*/
proc logistic data=sasuser.chis1417b;
class yearuse (ref='2014')/param=ref;
model usourc=yearuse;
run;

proc logistic data=sasuser.chis1417b;
class  education (ref='1') /param=ref;
model usourc=education ;
run;

proc logistic data=sasuser.chis1417b;
class ombsrr_p1 /*(ref='1')/param=ref*/;
model usourc=ombsrr_p1;
run;

/*adjusted OR*/
proc logistic data=sasuser.chis1417b;
class ombsrr_p1 /*(ref='1')/param=ref*/;
model usourc=ombsrr_p1 education yearuse;
run;

/*assigning a format to education*/
proc format;

value educationf	1='less than hs'
					2='high school'
					3='some college'
					4='college grad';
run;

data chis;
set sasuser.chis1417b;

format education educationf.;
run;

/*need to use the formatted value as the referent category in the class
statement*/
proc logistic data=chis;
class education (ref='less than hs')/param=ref;
model usourc= education ;
run;



