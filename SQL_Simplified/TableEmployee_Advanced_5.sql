/*CTE*/

WITH CTE_Employee as 
(SELECT FirstName, LastName, Gender, Salary
, COUNT(Gender) OVER (PARTITION By Gender) as TotalGender
, AVG(Salary) OVER (PARTITION By Gender) as AvgSalary
FROM demo_db_schema.EmployeeDemographics emp
JOIN demo_db_schema.EmployeeSalary sal
	ON emp.EmployeeID=sal.EmployeeID
WHERE Salary > '50000'
)
Select FirstName+' '+LastName  from CTE_Employee;

/*Temp Tables*/

CREATE TABLE #temp_Employee(
EmployeeID int,
JobTitle varchar(50),
Salary int);

Insert into #temp_Employee Values
(1001, 'HR', 76000),
(1002, 'Product Manager', 89000),
(1003, 'Delivery Manager', 120000),
(1004, 'Java Developer', 74000),
(1005, 'Trainee', 66000);

SELECT * FROM #temp_Employee;

CREATE TABLE #temp_Employee2(
FirstName varchar(50),
LastName varchar(50),
Gender varchar(50),
Salary int,
TotalGender int,
AvgSalary int);

INSERT INTO #temp_Employee2
SELECT FirstName, LastName, Gender, Salary
, COUNT(Gender) OVER (PARTITION By Gender) as TotalGender
, AVG(Salary) OVER (PARTITION By Gender) as AvgSalary
FROM demo_db_schema.EmployeeDemographics emp
JOIN demo_db_schema.EmployeeSalary sal
	ON emp.EmployeeID=sal.EmployeeID
WHERE Salary > '50000'

SELECT * FROM #temp_Employee2;

DROP TABLE IF EXISTS #temp_Employee; /*For Stored Procedures*/

/*String Functions*/

CREATE TABLE EmployeeErrors(
EmployeeID varchar(10),
FirstName varchar(50),
LastName varchar(50)
)

Insert into EmployeeErrors Values
('1001', 'Jimbo', 'Halbert'),
('1002', 'Pamela', 'Beasely'),
('1003', 'Toby', 'Maguire');

Select * from EmployeeErrors;

Update EmployeeErrors SET LastName='Flenderson - Fired' where EmployeeID='1003';

Update EmployeeErrors SET EmployeeID='  1002' where EmployeeID='1002';

Insert into EmployeeErrors Values
('1004', 'tonY', 'SharK');

--Using TRIM, LTRIM, RTRIM

SELECT EMPLOYEEID, TRIM(EMPLOYEEID) AS TRIMMEDID FROM EmployeeErrors;

SELECT EMPLOYEEID, RTRIM(EMPLOYEEID) AS TRIMMEDID FROM EmployeeErrors;

-- Using Replace

SELECT Lastname, REPLACE(LastName, '- Fired',' ') as LastNameFixed
FROM EmployeeErrors;

--Using SUbstring

SELECT FirstName, Substring(FirstName,1,3) as SlicingFirstName
FROM EmployeeErrors;

--Using FuzzyMacthing

Insert into EmployeeErrors Values
('1005', 'Jonathan', 'Sthatom');

SELECT FirstName, REPLACE(FirstName, 'Jonathan','Johnathan')
FROM EmployeeErrors;

UPDATE EmployeeErrors SET FirstName='Johnathan' WHERE EmployeeID='1005';

SELECT err.FirstName, SUBSTRING(err.FirstName,1,4),dem.FirstName, SUBSTRING(dem.FirstName,1,4)
FROM EmployeeErrors err
JOIN EmployeeDemographics dem
	ON SUBSTRING(err.FirstName,1,4)=SUBSTRING(dem.FirstName,1,4);

	/*Example Matching Alex and Alexander*/
	--Gender
	--Age
	--DOB

--UPPER And LOWER

Select UPPER(Firstname) from EmployeeErrors where EmployeeID='1004';


