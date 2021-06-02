/*Stored Procedures*/

CREATE Procedure TEST
AS
Select * from EmployeeDemographics

EXECUTE TEST

CREATE PROCEDURE Temp_Employee_Stored
AS

DROP TABLE IF EXISTS #temp_Employee3

CREATE TABLE #temp_Employee3(
FirstName varchar(50),
LastName varchar(50),
Gender varchar(50),
Salary int,
TotalGender int,
AvgSalary int);

INSERT INTO #temp_Employee3
SELECT FirstName, LastName, Gender, Salary
, COUNT(Gender) OVER (PARTITION By Gender) as TotalGender
, AVG(Salary) OVER (PARTITION By Gender) as AvgSalary
FROM SQLTUTORIAL.dbo.EmployeeDemographics emp
JOIN SQLTUTORIAL.dbo.EmployeeSalary sal
	ON emp.EmployeeID=sal.EmployeeID
WHERE Salary > '70000'

SELECT * FROM #temp_Employee3

EXECUTE Temp_Employee_Stored

--Editing Procedure(Using Parameters)

ALTER PROCEDURE [dbo].[Temp_Employee_Stored]
@JobTitle
AS

DROP TABLE IF EXISTS #temp_Employee3;

CREATE TABLE #temp_Employee3(
FirstName varchar(50),
LastName varchar(50),
Gender varchar(50),
Salary int,
TotalGender int,
AvgSalary int);

INSERT INTO #temp_Employee3
SELECT FirstName, LastName, Gender, Salary
, COUNT(Gender) OVER (PARTITION By Gender) as TotalGender
, AVG(Salary) OVER (PARTITION By Gender) as AvgSalary
FROM SQLTUTORIAL.dbo.EmployeeDemographics emp
JOIN SQLTUTORIAL.dbo.EmployeeSalary sal
	ON emp.EmployeeID=sal.EmployeeID
WHERE JobTitle=@JobTitle;

SELECT * FROM #temp_Employee3;

/*Subqueries*/
--In the SELECT, FROM and WHERE Statement

SELECT EmployeeID, Salary, (Select AVG(Salary) from EmployeeSalary) as AllAverage
from EmployeeSalary;

--Doing it with Partition BY

SELECT EmployeeID, Salary, AVG(Salary) over () as AllAverage
from EmployeeSalary;

--FROM (Aliasing Important)

Select A.EmployeeID, A.Age FROM (Select EmployeeID, FirstName, Age from EmployeeDemographics) A;

--WHERE(Only ONe Column from SubQUery)

Select EmployeeID, JobTitle, Salary from EmployeeSalary
WHERE EmployeeID IN (Select EmployeeID from EmployeeDemographics)