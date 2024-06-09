--1.Create a database NIKHIL ANALYTICS1

Create Database NIKHIL_ANALYTICS1
Use NIKHIL_ANALYTICS1

----2.Create STUDENT_INFO table with following columns
 
--a) STUDENT_ID : should accept maximum of 10 characters , should not accept null values & we must be able 
--to identify each records uniquely using STUDENT_ID, student id must be automatically generated in the 
--format STD_YEAR_SEQUENCENO ex: std_2018_01
--b) NAME : should accept maximum of 20 characters , should not accept null values
--c) ADDRESS: should accept maximum of 90 characters , should not accept null values
--d) PHONE_NO : should accept exactly 10 numbers & each digit should be between 0-9, should not accept null 
--values
--e) EMAIL_ID : should accept maximum of 30 characters & should contain @ , should not accept null values
--f) QUALIFICATION1: should accept maximum of 50 characters
--g) QUALIFICATION2: should accept maximum of 50 characters
--h) EXPERIENCE : should accept years ex: 2.5
--i) COMPANY NAME : should accept maximum of 50 characters
--j) COURSE_OPTED1 : should accept maximum of 50 characters, should not accept null values & should only 
--accept following courses: REPORTING ANALYSIS POWER PACK
--BUSINESS ANALYTICS POWER PACK
--DATA ANALYTICS POWER PACK
--DATA SCIENCE MODELLING & MACHINE LEARNING
--k) COURSE_OPTED2: should accept maximum of 50 characters & only given courses
--l) COURSE_OPTED3: should accept maximum of 50 characters & only given courses
--m) ADMISSION_DATE : should accept date value & should not accept null values
--n) EXPECTED END DATE : should accept date value & automatically update using following data.
-- REPORTING ANALYSIS POWER PACK – 3 MONTHS FROM ADMISSION DATE
--BUSINESS ANALYTICS POWER PACK – 6 MONTHS FROM ADMISSION DATE
--DATA ANALYTICS POWER PACK – 7 MONTHS FROM ADMISSION DATE
--DATA SCIENCE MODELLING & MACHINE LEARNING – 8 MONTHS FROM ADMISSION DATE

Create Table STUDENT_INFO(
year varchar(4) not null check(len(year)=4),
sequenceno int identity (1,1),
STUDENT_ID as ('STD_'+year+'_'+RIGHT('00'+cast(sequenceno as Varchar(2)),2)) PERSISTED Primary Key,
Name varchar(20) not null,
ADDRESS Varchar(90) not null,
PHONE_NO BIGINT Not Null check(Len(Phone_no)=10 AND Phone_no>1),
EMAIL_ID varchar(30) Not Null check(EMAIL_ID Like '%_@_%'),
QUALIFICATION1 Varchar(50),
QUALIFICATION2 Varchar(50),
EXPERIENCE Float not null,
COMPANYNAME varchar(50),
COURSE_OPTED1 varchar(50) not null check(COURSE_OPTED1 IN ('REPORTING ANALYSIS POWER PACK',
'BUSINESS ANALYTICS POWER PACK','DATA ANALYTICS POWER PACK','DATA SCIENCE MODELLING & MACHINE LEARNING')),
COURSE_OPTED2 varchar(50) check(COURSE_OPTED2 IN ('REPORTING ANALYSIS POWER PACK',
'BUSINESS ANALYTICS POWER PACK','DATA ANALYTICS POWER PACK','DATA SCIENCE MODELLING & MACHINE LEARNING')),
COURSE_OPTED3 varchar(50) check(COURSE_OPTED3 IN ('REPORTING ANALYSIS POWER PACK',
'BUSINESS ANALYTICS POWER PACK','DATA ANALYTICS POWER PACK','DATA SCIENCE MODELLING & MACHINE LEARNING')),
ADMISSION_DATE date not null,
EXPECTED_END_DATE As Case When Course_Opted1 = 'DATA SCIENCE MODELLING & MACHINE LEARNING' then dateadd(month,8,Admission_Date)
                          When Course_Opted1 = 'DATA ANALYTICS POWER PACK' then dateadd(month,7,Admission_Date)
						  When Course_Opted1 = 'BUSINESS ANALYTICS POWER PACK' then dateadd(month,6,Admission_Date)
						  When Course_Opted1 = 'REPORTING ANALYSIS POWER PACK' then dateadd(month,3,Admission_Date)
						  end)

Select *
from STUDENT_INFO


--2.Create R_marks_info table with following columns 
--a) Student_ID : should accept maximum of 10 characters, should not accept null values & should create a 
--reference to student_info table 
--b) Class_start_Date : should accept date value
--c) Class_End_Date : should accept date value
--o) Faculty : should accept maximum of 50 characters , should not accept null values
--d) Test_1 :
--e) Test_2 :
--f) Test_3 :
--g) Retest1 :
--h) Retest2 :
--i) Retest3 :

Create Table R_marks_info(
STUDENT_ID Varchar(11) Foreign Key References STUDENT_INFO(STUDENT_ID),
CLASS_START_DATE Date,
CLASS_END_DATE Date,
FACULTY Varchar(50) Not Null,
TEST_1 float,
TEST_2 float,
TEST_3 float,
Retest1 float,
Retest2 float,
Restest3 float)


--3.Create SAS_marks_info table with following columns
--a) Student_ID: should accept maximum of 10 characters, should not accept null values & should create a 
--reference to student_info table 
--b) Class_start_Date
--c) Class_End_Date
--d) Faculty
--e) MT-1
--f) MT-2
--g) Data_step_test
--h) MT-3
--i) Proc_Test
--j) Base SAS Test
--k) Retest1
--l) Retest2
--m) Retest3

Create Table SAS_marks_info(
STUDENT_ID Varchar(11) Foreign Key References STUDENT_INFO(STUDENT_ID),
CLASS_START_DATE Date,
CLASS_END_DATE Date,
FACULTY Varchar(50) Not Null,
MT_1 float,
MT_2 float,
Date_step_test float,
MT_3 float,
Proc_Test float,
Base_SAS_Test float,
Retest1 float,
Retest2 float,
Retest3 float)

--4. Create SQL_marks_info table with following columns 
--a) Student_ID: should accept maximum of 10 characters, should not accept null values & should create a 
--reference to student_info table 
--b) Class_start_Date
--c) Class_End_Date
--d) Faculty
--e) SQL_test1
--f) SQL_test2
--g) Retest1
--h) Retest2

Create Table SQL_marks(
STUDENT_ID Varchar(11) Foreign Key References STUDENT_INFO(STUDENT_ID),
CLASS_START_DATE Date,
CLASS_END_DATE Date,
FACULTY Varchar(50) Not Null,
SQL_test1 float,
SQL_test2 float,
Retest1 float,
Retest2 float)

--5. Create EXCEL_marks_info table with following columns 
--a) Student_ID: should accept maximum of 10 characters, should not accept null values & should create a 
--reference to student_info table 
--b) Class_start_Date
--c) Class_End_Date
--d) Faculty
--e) Basic_excel_test
--f) MT1
--g) Excel_test1
--h) Retest

Create Table EXCEL_marks_info(
STUDENT_ID Varchar(11) Foreign Key References STUDENT_INFO(STUDENT_ID),
CLASS_START_DATE Date,
CLASS_END_DATE Date,
FACULTY Varchar(50) Not Null,
BASIC_EXCEL_TEST float,
MT1 float,
EXCEL_TEST1 float,
Retest float)

--6. Create VBA_marks_info table with following columns 
--a) Student_ID: should accept maximum of 10 characters, should not accept null values & should create a 
--reference to student_info table 
--b) Class_start_Date
--c) Class_End_Date
--d) Faculty
--e) Function_excel_Test
--f) Function_vba_test
--g) Final_test
--h) Retest1

Create table VBA_marks_info(
STUDENT_ID Varchar(11) Foreign Key References STUDENT_INFO(STUDENT_ID),
CLASS_START_DATE Date,
CLASS_END_DATE Date,
FACULTY Varchar(50) Not Null,
FUNCTION_EXCEL_TEST float,
FUNCTION_VBA_TEST float,
FINAL_TEST float,
Retest1 float)

--7. Create TABLEAU_marks_info table with following columns 
--a) Student_ID: should accept maximum of 10 characters, should not accept null values & should create a 
--reference to student_info table 
--b) Class_start_Date
--c) Class_End_Date
--d) Faculty
--e) MT1
--f) Test1
--g) Retest1

Create table TABLEAU_marks_info(
STUDENT_ID Varchar(11) Foreign Key References STUDENT_INFO(STUDENT_ID),
CLASS_START_DATE Date,
CLASS_END_DATE Date,
FACULTY Varchar(50) Not Null,
MT1 float,
Test1 float,
Retest1 float)
 
--8. Create PYTHON_marks_info table with following columns 
--a) Student_ID: should accept maximum of 10 characters, should not accept null values & should create a 
--reference to student_info table 
-- b) Class_start_Date
-- c) Class_End_Date
-- d) Faculty
-- e) Test1
-- f) Test2
-- g) Retest1
-- h) Retest2

Create Table PYTHON_marks_info(
STUDENT_ID Varchar(11) Foreign Key References STUDENT_INFO(STUDENT_ID),
CLASS_START_DATE Date,
CLASS_END_DATE Date,
FACULTY Varchar(50) Not Null,
Test1 float,
Test2 float,
Retest1 float,
Retest2 float)


--8. Create ML_marks_info table with following columns
--a) Student_ID : should accept maximum of 10 characters, should not accept null values & should create 
--a reference to student_info table 
--b) Class_start_Date
--c) Class_End_Date
--d) Faculty
--e) Test1
--f) Test2
--g) Retest

Create table ML_marks_info(
STUDENT_ID Varchar(11) Foreign Key References STUDENT_INFO(STUDENT_ID),
CLASS_START_DATE Date,
CLASS_END_DATE Date,
FACULTY Varchar(50),
Test1 float,
Test2 float,
Retest float)

--9. Create ASAS_marks_info table with following columns 
--a) Student_ID: should accept maximum of 10 characters, should not accept null values & should create a 
--reference to student_info table 
--b) Class_start_Date
--c) Class_End_Date
--d) Faculty
--e) MT1
--f) MT2
--g) Final_test
--h) Retest

Use NIKHIL_ANALYTICS

Create table ASAS_marks_info(
STUDENT_ID Varchar(11) Foreign Key References STUDENT_INFO(STUDENT_ID),
CLASS_START_DATE Date,
CLASS_END_DATE Date,
FACULTY Varchar(50) Not Null,
MT1 float,
MT2 float,
Final_test float,
Retest float)

--10.Create FULL_LENGTH_marks_info table with following columns
--a) Student_ID: should accept maximum of 10 characters, should not accept null values & should create a 
--reference to student_info table 
--b) Class_start_Date
--c) Class_End_Date
--d) Faculty
--e) R_test
--f) SAS_test
--g) SQL_test
--h) Excel_test
--i) VBA_test
--j) Python_test
--k) Tableau_test

Create Table FULL_LENGTH_marks_info(
STUDENT_ID Varchar(11) Foreign Key References STUDENT_INFO(STUDENT_ID),
CLASS_START_DATE Date,
CLASS_END_DATE Date,
FACULTY Varchar(50),
R_test float,
SAS_test float,
EXCEL_test float,
VBA_test float,
Python_test float,
Tableau_test float)

--11.Create Placement_Activity table with following columns 
 -- a) Column Name
--b) Student_ID: should accept maximum of 10 characters, should not accept null values &should create a 
--reference to student_info table
-- c) Mock_interview1: should accept maximum of 50 characters
-- d) Mock_interview2: should accept maximum of 50 characters
-- e) Mock_interview3: should accept maximum of 50 characters
-- f) Resume Finalised: should accept maximum of 50 characters
-- g) Profile_Building: should accept maximum of 50 characters
-- h) Certificate_Issued: should accept only YES/NO
-- i) Actual_course_enddate

Create Table PLACEMENT_ACTIVITY(
STUDENT_ID Varchar(11) Foreign Key References STUDENT_INFO(STUDENT_ID),
Mock_interview1 Varchar(50),
Mock_interview2 Varchar(50),
Mock_interview3 Varchar(50),
Resume_Finalised Varchar(50),
Profile_Building Varchar(50),
Certificate_Issued Varchar(50) not null check (Certificate_Issued IN('YES','NO')),
Actual_Course_enddate date)
