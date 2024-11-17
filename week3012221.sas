/*Week 3 - 01/22/2021*/

/*create new formats*/
proc format;

value smokef	1='current smoker'
				2='former smoker'
				3='never smoker';
				
value riagendrf	1='male'
				2='female';	
				
value smoke2f	1='smoker'
				2='non-smoker';
				
value fmsmokeage 	1='never used mary j'
					2='first used mary j at 16 or younger'
					3='first used mary j at older than 16';
				
run;

data nhanes;
set sasuser.nhanes1516;

/*create new variables*/
if smq020=1 and smq040 in (1,2) then smoke=1;
if smq020=1 and smq040 =3 then smoke=2;
if smq020=2 then smoke=3;

if smoke=. then smoke2=.;
else if smoke =1 then smoke2=1;
else if smoke in (2,3) then smoke2=2;

if duq200=2 then msmokeage=1;
else if duq200=1 and duq210 le 16 then msmokeage=2;
else if duq200=1 and duq210 gt 16 then msmokeage=3;
else if duq200 in (.,7,9) or duq210 in (777,999) then msmokeage=.;

/*label variables*/
label 	smoke='current smoking status'
		riagendr='gender for nhanes 15-16 class 3'
		msmokeage='smoking status by age';

/*assign variables to formats*/
format smoke smokef. riagendr riagendrf. smoke2 smoke2f.
msmokeage fmsmokeage.;

ARRAY miss(2) smq020 duq200; 
do i=1 to 2; 
if miss(i) in (7,9) then miss(i)=.; 
end; 
drop i; 

run;

/*check array*/
proc freq data=nhanes;
tables smq020 duq200;
run;

/*check new variables*/
proc freq data=nhanes;
tables smq020*smq040*smoke smoke*smoke2/list missing;
run;

proc freq data= nhanes;
tables duq200*duq210*msmokeage/list missing;
run;

/*calculate percentages*/
proc freq data= nhanes;
tables msmokeage/list missing;
run;

proc freq data=nhanes;
tables smoke;
run;

proc freq data=nhanes;
tables riagendr;
run;

/*What percent of men and women are smokers?  
Is there a statistical difference*/
proc freq data=nhanes order=formatted;
tables riagendr*smoke2/chisq relrisk;
run;





