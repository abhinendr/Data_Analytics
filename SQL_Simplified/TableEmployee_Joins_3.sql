/*JOINS*/

DESCRIBE employeesalary;


SELECT * FROM EmployeeDemographics AS ED JOIN EmployeeSalary AS ES ON ED.EmployeeID=ES.EmpID;

SELECT * FROM EmployeeDemographics AS ED FULL OUTER JOIN EmployeeSalary AS ES ON ED.EmployeeID=ES.EmpID; /*Use with Union*/

SELECT * FROM EmployeeDemographics AS ED LEFT JOIN EmployeeSalary AS ES ON ED.EmployeeID=ES.EmpID;

SELECT * FROM EmployeeDemographics AS ED RIGHT JOIN EmployeeSalary AS ES ON ED.EmployeeID=ES.EmpID;

 SELECT * FROM demo_db_schema.employeesalary;

SELECT ED.EMPLOYEEID, ED.FirstName, ES.SALARY 
FROM EmployeeDemographics as ED JOIN EmployeeSalary as ES ON ED.EmployeeID=ES.EmpID
WHERE FirstName<>'John';


SELECT AVG(ES.SALARY), COUNT(ES.JobTitle) AS ProfessionNo
FROM EmployeeDemographics as ED JOIN EmployeeSalary as ES ON ED.EmployeeID=ES.EmployeeID
WHERE FirstName<>'John' GROUP BY JobTitle;

/*UNION*/

SELECT * FROM EMPLOYEEDEMOGRAPHICS
UNION
SELECT * FROM WAREHOUSEEMPLOYEEDEMOGRAPHICS;

SELECT * FROM EMPLOYEEDEMOGRAPHICS
UNION ALL
SELECT * FROM WAREHOUSEEMPLOYEEDEMOGRAPHICS;

SELECT EMPLOYEEID, FIRSTNAME, AGE
FROM EMPLOYEEDEMOGRAPHICS
UNION
SELECT EMPLOYEEID, JOBTITLE, SALARY
FROM EMPLOYEESALARY;

/* CASE */
SELECT FIRSTNAME, LASTNAME, AGE,
CASE
	WHEN AGE>35 THEN 'Old'
	WHEN AGE BETWEEN 25 AND 35 THEN 'Bachelors'
	ELSE 'Young'
END
FROM EMPLOYEEDEMOGRAPHICS
WHERE AGE IS NOT NULL
ORDER BY AGE;

SELECT FirstName, Lastname, JobTitle, Salary,
CASE
	WHEN JobTitle = 'Accountant' THEN (Salary*1.10)
	WHEN JobTitle = 'Data Analyst' then (Salary*1.05)
	WHEN JobTitle like '%Developer%' THEN (Salary*1.07)
	ELSE (Salary*1.03)
END AS AppraisalSalary
FROM EMPLOYEEDEMOGRAPHICS JOIN EMPLOYEESALARY ON EMPLOYEEDEMOGRAPHICS.EMPLOYEEID=EMPLOYEESALARY.EMPLOYEEID;

/*HAVING CLAUSE*/

SELECT JobTitle, count(JobTitle)
FROM EMPLOYEEDEMOGRAPHICS JOIN EMPLOYEESALARY ON EMPLOYEEDEMOGRAPHICS.EMPLOYEEID=EMPLOYEESALARY.EMPLOYEEID
WHERE COUNT(JobTitle)>1
GROUP BY JobTitle;

SELECT JobTitle, count(JobTitle)
FROM EMPLOYEEDEMOGRAPHICS JOIN EMPLOYEESALARY ON EMPLOYEEDEMOGRAPHICS.EMPLOYEEID=EMPLOYEESALARY.EMPLOYEEID
GROUP BY JobTitle
HAVING COUNT(JobTitle)>1; /*Having Uses Functions aggregate, WHERE Does Not*/

SELECT JobTitle, AVG(Salary)
FROM EMPLOYEEDEMOGRAPHICS JOIN EMPLOYEESALARY ON EMPLOYEEDEMOGRAPHICS.EMPLOYEEID=EMPLOYEESALARY.EMPLOYEEID
GROUP BY JobTitle
HAVING AVG(SALARY) > 100000
ORDER BY AVG(SALARY);

/*UPDATE DELETE*/

UPDATE EmployeeSalary
SET Salary=Salary/10
WHERE Salary>100000;

SELECT * FROM EMPLOYEESALARY;

/*ALIASING*/

SELECT Firstname + ' ' + Lastname AS FullName from EmployeeDemographics;

SELECT AVG(Age) as AVGAge from demo_db_schema.EmployeeDemographics;

/*PARTITION BY*/

SELECT * FROM demo_db_schema.EmployeeDemographics;

SELECT FirstName, LastName, Gender, Salary, COUNT(Gender) OVER (PARTITION BY Gender) as TotalGender
from demo_db_schema.EmployeeDemographics dem
JOIN demo_db_schema.EmployeeSalary sal
ON dem.EmployeeID=sal.EmployeeID;

			/*group by vs partition by*/

SELECT  Gender, COUNT(Gender)
from demo_db_schema.EmployeeDemographics dem
JOIN demo_db_schema.EmployeeSalary sal
ON dem.EmployeeID=sal.EmployeeID
GROUP BY Gender;

