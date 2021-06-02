select * from EmployeeDemographics;

SELECT FIRSTNAME FROM EmployeeDemographics;

SELECT TOP (3) FIRSTNAME FROM EmployeeDemographics;

SELECT DISTINCT GENDER FROM EmployeeDemographics;

SELECT COUNT (DISTINCT GENDER) AS TotalGender FROM EmployeeDemographics;

SELECT * FROM EmployeeSalary;

SELECT MIN(SALARY) FROM EmployeeSalary;

SELECT * FROM EmployeeDemographics WHERE AGE<=34;

SELECT * FROM EmployeeDemographics WHERE AGE<=40 OR GENDER='Male';

SELECT * FROM EmployeeDemographics WHERE LastName LIKE '%o%';

SELECT * FROM EmployeeDemographics WHERE FirstName is NOT NULL;

/*
Group BY and ORDER by*/

SELECT GENDER, COUNT(GENDER) FROM EmployeeDemographics GROUP BY GENDER;

SELECT GENDER, COUNT(GENDER) FROM EmployeeDemographics GROUP BY GENDER, AGE;

SELECT GENDER, COUNT(GENDER) FROM EmployeeDemographics WHERE AGE>27 GROUP BY GENDER ORDER BY COUNT(GENDER) DESC;

SELECT * FROM EmployeeDemographics ORDER BY AGE, GENDER DESC;

SELECT * FROM EmployeeDemographics ORDER BY 4, 5 DESC;

SELECT * FROM EmployeeDemographics ORDER BY EmployeeID;

SELECT * FROM SQLTUTORIAL.Dbo.employeesalary;

SELECT * FROM SQLTutorial.dbo.EmployeeDemographics;