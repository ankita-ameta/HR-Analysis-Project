create database Project;
use Project;
set sql_safe_updates=0;
select * from hr_1;
select * from hr_2;


Alter table hr_1 rename column ï»¿Age to Age;
Alter table hr_2 rename column `ï»¿Employee ID` to Employee_ID;

// Total Employees //
create view Total_Employees as select count(EmployeeNumber) "Total Employees" from hr_1;
select * from Total_Employees;

// Attrition Count //
create view Attrition_Count as select count(Attrition) "Attrition Count" from hr_1 where Attrition = 'Yes';
select * from Attrition_Count;

// Gender Wise Attrition Count //
create view Gender_Wise_Attrition as select gender,count(Attrition) "Total" from hr_1 where Attrition = 'Yes' group by Gender;
select * from Gender_Wise_Attrition;

// Active Employees //
create view Active_Employees as select count(Attrition) "Total" from hr_1 where Attrition = 'No';
select * from Active_Employees;

// Attrition Rate //
create view Attrition_Rate as select round(count(Attrition)/(select count(EmployeeNumber) from hr_1)*100,2) "Attrition Rate" from hr_1 where Attrition = 'Yes';
select * from Attrition_Rate;

// Attrition Rate For Each Department //
create view Department_Wise_Attrition as select Department, round(count(Attrition)/(select count(EmployeeNumber) from hr_1)*100,2) "Attrition Rate"
 from hr_1 where Attrition = 'Yes' group by Department;
select * from Department_Wise_Attrition;

// Average Hourly Rate of Male Research Scientist //
select gender, round(avg(HourlyRate),2) "Average Hourly Rate" from hr_1 where gender = "Male" and JobRole = "Research Scientist" group by Gender;

// Attrition Rate Vs Monthly Income Stats
create view Attrition_Vs_Income as select hr_1.Department,round(count(hr_1.Attrition)/(select count(hr_1.EmployeeNumber) from hr_1)*100,2) "Attrition Rate",
round(avg(hr_2.MonthlyIncome),2) "Average Income" from hr_1 join hr_2 on hr_1.EmployeeNumber = hr_2.Employee_ID where Attrition = 'Yes' group by hr_1.department;
select * from Attrition_Vs_Income;

// Average Working Years for Each Department //
create view Avg_Working_Years as select hr_1.Department,round(avg(hr_2.TotalWorkingYears),2) "Avg Working Years" from hr_1 join hr_2 
on hr_1.EmployeeNumber = hr_2.Employee_ID group by hr_1.department;
select * from Avg_Working_Years;

// Job Role Vs Work Life Balance //

alter table hr_2 add column `Work Life Balance Status` varchar(10);

update hr_2 set `Work Life Balance Status`=  CASE
when WorkLifeBalance = 1 then "Very Poor"
when WorkLifeBalance = 2 then "Poor"
when WorkLifeBalance = 3 then "Good"
else "Excellent" end;

create view JR_Vs_WLB as select hr_1.JobRole,hr_2.`Work Life Balance Status`,count(hr_2.`Work Life Balance Status`) "Employee Count" from hr_1 
join hr_2 on hr_1.EmployeeNumber = hr_2.Employee_ID group by hr_1.JobRole, hr_2.`Work Life Balance Status` order by hr_1.JobRole;
select * from JR_Vs_WLB;

// Attrition Vs Years Since Last Promotion //
create view Attrition_Vs_LastPromotion as select hr_2.`YearsSinceLastPromotion`,count(hr_1.Attrition) "Attrition Count" from hr_1 join hr_2 
on hr_1.EmployeeNumber = hr_2.Employee_ID where Attrition = 'Yes' group by hr_2.`YearsSinceLastPromotion` order by hr_2.`YearsSinceLastPromotion` asc;
select * from Attrition_Vs_LastPromotion;

// Education Vs Attrition Rate //

alter table hr_1 add column Education_Status varchar(50);

update hr_1 set Education_Status=  CASE
when Education = 1 then "High School"
when Education = 2 then "Associate's Degree"
when Education = 3 then "Bachelor's Degree"
when Education = 4 then "Master's Degree"
else "Doctorate" end;

create view Education_Vs_Attrition as select Education_Status, round(count(Attrition)/(select count(EmployeeNumber) from hr_1)*100,2) "Attrition Rate"
 from hr_1 where Attrition = 'Yes' group by Education_Status;
 select * from Education_Vs_Attrition;
 
 // Distance Vs Attrition //
 
 alter table hr_1 add column Distance_Status varchar(50);
 
 update hr_1 set Distance_Status=  CASE
when DistanceFromHome between 1 and 7 then "Very Close"
when DistanceFromHome between 8 and 15 then "Close"
when DistanceFromHome between 16 and 30 then "Far"
else "Very Far" end;

create view Distance_Vs_Attrition as select Distance_Status, round(count(Attrition)/(select count(EmployeeNumber) from hr_1)*100,2) "Attrition Rate"
 from hr_1 where Attrition = 'Yes' group by Distance_Status;
 select * from Distance_Vs_Attrition;
 
 // Marital Status Vs Attrition //
 create view MaritalStatus_Vs_Attrition as select MaritalStatus,count(Attrition) "Attrition Count" from hr_1 where Attrition = 'Yes' group by MaritalStatus;
 select * from MaritalStatus_Vs_Attrition;
 
 // Business Travel Vs Attrition //
 create view BusinessTravel_Vs_Attrition as select BusinessTravel,count(Attrition) "Attrition Count" from hr_1 where Attrition = 'Yes' group by BusinessTravel;
 select * from BusinessTravel_Vs_Attrition;



 
