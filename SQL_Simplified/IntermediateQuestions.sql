#50. Write an SQL query to fetch the names of workers who earn the highest salary.
SELECT FIRST_NAME, SALARY FROM WORKER WHERE SALARY IN (SELECT MAX(SALARY) FROM WORKER);

#51. Write an SQL Query to create a cummulative or running totlal of the salary colunm from workers table.
SELECT *, SUM(SALARY) OVER ( ORDER BY WORKER_ID ) AS Running_Sal FROM WORKER;
SELECT *, MAX(SALARY) OVER ( ORDER BY WORKER_ID ) AS Cummulative_Salary FROM WORKER;

#52. Write an SQL Query to find all paramters of Date
SELECT JOINING_DATE, MONTH(JOINING_DATE), MONTHNAME(JOINING_DATE), DAY(JOINING_DATE),
LEFT(DAYNAME(JOINING_DATE),3), YEAR(JOINING_DATE), QUARTER(JOINING_DATE),
WEEK(JOINING_DATE), WEEKOFYEAR(JOINING_DATE), HOUR(JOINING_DATE) FROM WORKER;

SELECT DATE(JOINING_DATE) FROM WORKER;

#53. Write an SQL Query to find difference between two consecutive joining dates.
SELECT DATEDIFF(JOINING_DATE, LEAD(JOINING_DATE,1) OVER (ORDER BY WORKER_ID)) FROM WORKER;

SELECT LAG(JOINING_DATE,2) OVER (ORDER BY WORKER_ID) FROM WORKER;


#54. Write an SQL Query to ADD & Subtract Days, Months and Years to the Joining Date.
SELECT JOINING_DATE, DATE_ADD(JOINING_DATE,INTERVAL 10 MONTH),
DATE_SUB(JOINING_DATE, INTERVAL 2 YEAR) FROM WORKER;

#55. Write an SQL Query to Format Date as '23-Sep-2021'
SELECT DATE_FORMAT(JOINING_DATE,'%d-%b-%Y') FROM WORKER;

#56. Write an SQL Query to get the Latest date and Oldest Joining Date and the difference between them.
SELECT MAX(JOINING_DATE) AS NEW_DATE, MIN(JOINING_DATE) AS OLD_DATE, DATEDIFF(MAX(JOINING_DATE),MIN(JOINING_DATE)) FROM WORKER;

#57. Write an SQL query to get the first day AND Dayname of the current year.
SELECT MAKEDATE(YEAR(CURDATE()),1);
SELECT LAST_DAY(CURDATE());

#58. Write an SQL query to calculate the age in year.
SELECT ROUND(DATEDIFF(CURDATE(),'1996-10-22')/365);
SELECT YEAR(CURDATE())-YEAR('1996-10-22');

#Few SQL Queries of OVER Function
SELECT *, ROW_NUMBER() OVER (ORDER BY DEPARTMENT) FROM WORKER;
SELECT *, ROW_NUMBER() OVER (PARTITION BY DEPARTMENT) FROM WORKER ORDER BY DEPARTMENT;
SELECT *, MAX(SALARY) OVER (PARTITION BY DEPARTMENT), IF (SUM(SALARY) OVER (PARTITION BY DEPARTMENT)>500000, 'Passed', 'No') FROM WORKER ORDER BY DEPARTMENT;

#59. Write an SQL Query to find the Rank of Salary in Each Department.
#Rank Functions
SELECT * , RANK() OVER (PARTITION BY DEPARTMENT ORDER BY SALARY DESC) FROM WORKER; 

SELECT * , DENSE_RANK() OVER (PARTITION BY DEPARTMENT ORDER BY SALARY DESC) FROM WORKER; 

SELECT * , ROW_NUMBER() OVER (PARTITION BY DEPARTMENT ORDER BY SALARY DESC) FROM WORKER ORDER BY DEPARTMENT;

#60. Write an SQL Query to find the NULL Value in Salary and Replace it with 'Unavailable'
SELECT * , COALESCE(SALARY,'Unavailable') FROM WORKER;

SELECT COALESCE(SALARY, DATE(JOINING_DATE), DEPARTMENT) AS SALARY_JOININGDATE FROM WORKER;

#61. Write an SQL Query to create Salary in 3 Bands.
#CASE Funtion
SELECT FIRST_NAME, SALARY,
(CASE
	WHEN SALARY>=75000 AND SALARY<=350000 THEN 'Promotion Required'
    WHEN SALARY>=350000 AND SALARY<=700000 THEN 'Ok'
    ELSE 'Inactive'
END) AS STATUS
FROM WORKER;

SELECT FIRST_NAME, SALARY,
(CASE
	WHEN SALARY>=(SELECT MIN(SALARY) FROM WORKER) AND SALARY<=350000 THEN 'Promotion Required'
    WHEN SALARY>=350000 AND SALARY<=(SELECT MAX(SALARY) FROM WORKER) THEN 'Ok'
    ELSE 'Inactive'
END) AS STATUS
FROM WORKER;

#62. Write an SQL Query to find the Bonus for their Respective Worker Ids.
#Sample of Co-related Query, Inner Query driven by Outer Query
SELECT WORKER_ID, (SELECT SUM(BONUS_AMOUNT) FROM BONUS WHERE WORKER_REF_ID = WORKER_ID) FROM WORKER;

SELECT * FROM WORKER WHERE SALARY > (SELECT SALARY FROM WORKER ORDER BY SALARY LIMIT 1 OFFSET 4);

#63. Write an SQL Query to execute the Stored Procedure for some query.

DELIMITER //

CREATE PROCEDURE sp_getsal()
BEGIN
	SELECT WORKER_ID, SALARY FROM WORKER WHERE DEPARTMENT = 'Admin';
END //

DELIMITER ;

CALL sp_getsal()
#Using IN-OUT Params

DELIMITER //
CREATE PROCEDURE sp_params(inout Salary_T int, In dept varchar(10))
BEGIN
	SELECT SUM(SALARY) INTO Salary_T FROM WORKER WHERE DEPARTMENT = dept;
END //

DELIMITER ;

CALL sp_params(@T,'HR');
SELECT @T AS Sala;

DROP PROCEDURE sp_params;

#64. Write an SQL Query to Create a Virtual Table out of Worker Table.

CREATE VIEW table_sal
AS
SELECT WORKER_ID, SALARY FROM WORKER WHERE DEPARTMENT = 'Admin';

SELECT * FROM table_sal;

SHOW CREATE VIEW table_sal;

#65. Write an SQL Query to replace 'Amitabh' with 'Amy'

SELECT REPLACE(FIRST_NAME,'Amitabh','Ami') FROM WORKER WHERE FIRST_NAME LIKE '%Amitabh%';

#66. Write an SQL Query to CAST SALARY into INT

SELECT CAST(SALARY AS unsigned) AS Int_Salary FROM WORKER; 
SELECT CONVERT("2017-08-29", DATE);

#67. Scalar Subquery (Returing 1 row 1 column)- Find employees who salary is more than average salary earned by all employees.

SELECT FIRST_NAME, SALARY FROM WORKER WHERE SALARY > AVG(SALARY); #--This wont work
SELECT FIRST_NAME, SALARY FROM WORKER WHERE SALARY > (SELECT AVG(SALARY) FROM WORKER);

		#Can use in other clause also, like JOIN
SELECT O.*, I.SAL FROM WORKER O JOIN
(SELECT AVG(SALARY) AS SAL FROM WORKER) I
ON O.SALARY > I.SAL; 

#68. Multiple row(Returning Multiple rows and multiple columns) Subquery Find employees who earn the highest salary in each department.

SELECT * FROM WORKER WHERE (DEPARTMENT, SALARY) IN 
(SELECT DEPARTMENT, MAX(SALARY) FROM WORKER GROUP BY DEPARTMENT);

#69. Corelated Subquery- Subquery which is related to the outer query
# Find employees who earn more than the averaga salary of each department.

SELECT DISTINCT DEPARTMENT, AVG(SALARY) OVER (PARTITION BY DEPARTMENT) FROM WORKER;

#Building queries -
SELECT * FROM WORKER
WHERE SALARY > (SELECT AVG(SALARY) FROM WORKER WHERE DEPARTMENT = 'ADMIN'); #This is for one column

SELECT O.* FROM WORKER O 
WHERE O.SALARY > 
(SELECT AVG(SALARY) FROM WORKER I WHERE I.DEPARTMENT=O.DEPARTMENT); #For every Outer query ran, it will run subquery and compare. 

#70. Find Employees who do not got the bonus  -

SELECT * FROM WORKER O WHERE NOT EXISTS
(SELECT 1 FROM BONUS I WHERE I.WORKER_REF_ID<>O.WORKER_ID);
