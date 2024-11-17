
/******************Week 2 - in class excercise 1********************/

/*keep 4 variables*/
data nhanes (keep = seqn ridstatr riagendr smq020);
set sasuser.nhanes1516;
run;

/*check to make sure that you have only 4 variables in your new data set*/
proc contents data=nhanes;
run;

/*keep 4 variables and restrict the data to those who were
intervied and examined (ridstatr=2) and women (riagendr=2)
in the same data step*/
data nhanes ;
set sasuser.nhanes1516;
keep seqn ridstatr riagendr smq020;
if ridstatr=2 and riagendr=2;
run;

/*what percent of women ever smoked cigarettes?*/
proc freq data=nhanes;
tables smq020;
run;

/*another way to estimate what percent of women ever smoked cigarettes?*/
proc freq data=sasuser.nhanes1516;
where ridstatr=2 and riagendr=2;
tables smq020/missing;
run;

/*yet another way to estimate what percent of women ever smoked cigarettes?*/
proc freq data=sasuser.nhanes1516;
where ridstatr=2;
tables riagendr*smq020;
run;


/*************create a new height variable*************/

/*find name of height variable - bmxht*/
proc contents data=sasuser.nhanes1516;
run;

/*look at distribution of height variable to help define a cut-point*/
proc univariate data=sasuser.nhanes1516 plot;
var BMXHT;
run;

/*put height into categories*/
data nhanes3;
set sasuser.nhanes1516;

if bmxht=. then heightcat=.;
else if bmxht <=155.0807 then heightcat=1;
else if bmxht > 155.0807 then heightcat=2;

run;

/*check code*/
proc freq data=nhanes3;
tables bmxht*heightcat/list missing;
run;


/******************Week 2 - in class excercise 2********************/

proc format;

value marriedf 	1='married'
				2='not married';

run;

data nhanes3;
set sasuser.nhanes1516;

/*code missing values*/
if DMDMARTL in (77,99) then DMDMARTL=.;

/*re-categorize variable*/
if DMDMARTL=. then married=.;
else if DMDMARTL =1 then married=1;
else if DMDMARTL in (2, 3, 4, 5, 6) then married=2;

label married= 'dichotomous marital status';
format married marriedf.;

run;

/*check to make sure code worked*/
proc freq data=nhanes3;
tables DMDMARTL*married/list missing;
run;

/*what percent of the population is married?*/
proc freq data=nhanes3;
tables married/list ;
run;

