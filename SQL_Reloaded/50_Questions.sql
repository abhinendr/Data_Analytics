select * from worker;
select * from title;
select * from bonus;
#Now Each question is going to be solved.

#1. Write an SQL query to fetch “FIRST_NAME” from Worker table using the alias name as <WORKER_NAME>.
SELECT FIRST_NAME AS WORKER_NAME FROM WORKER;

#2. Write an SQL query to fetch “FIRST_NAME” from Worker table in upper case.
SELECT UPPER(FIRST_NAME) FROM WORKER;

#3. Write an SQL query to fetch unique values of DEPARTMENT from Worker table.
SELECT DISTINCT(DEPARTMENT) FROM WORKER;

#4. Write an SQL query to print the first three characters of  FIRST_NAME from Worker table.
SELECT LEFT(FIRST_NAME,3) FROM WORKER;
SELECT SUBSTRING(FIRST_NAME,1,3) FROM WORKER;

#5. Write an SQL query to find the position of the alphabet (‘a’) in the first name column ‘Amitabh’ from Worker table
SELECT INSTR(FIRST_NAME,BINARY 'a') FROM WORKER WHERE FIRST_NAME = 'Amitabh';

#6. Write an SQL query to print the FIRST_NAME from Worker table after removing white spaces from the right side.
SELECT RTRIM(FIRST_NAME) FROM WORKER;

#.7 Write an SQL query to print the DEPARTMENT from Worker table after removing white spaces from the left side.
SELECT LTRIM(DEPARTMENT) FROM WORKER;

#.8 Write an SQL query that fetches the unique values of DEPARTMENT from Worker table and prints its length.
SELECT DISTINCT LENGTH(DEPARTMENT) FROM WORKER;

#.9 Write an SQL query to print the FIRST_NAME from Worker table after replacing ‘a’ with ‘A’.
SELECT REPLACE(FIRST_NAME,'a','A') FROM WORKER;

#10. Write an SQL query to print the FIRST_NAME and LAST_NAME from Worker table into a single column COMPLETE_NAME. A space char should separate them.
SELECT CONCAT(FIRST_NAME,' ',LAST_NAME) FROM WORKER;
SELECT CONCAT_WS(" ",FIRST_NAME,LAST_NAME,DEPARTMENT) FROM WORKER;

#11. Write an SQL query to print all Worker details from the Worker table order by FIRST_NAME Ascending.
SELECT * FROM WORKER ORDER BY FIRST_NAME;

#12. Write an SQL query to print all Worker details from the Worker table order by FIRST_NAME Ascending and DEPARTMENT Descending.
SELECT * FROM WORKER ORDER BY FIRST_NAME , DEPARTMENT DESC;

#13. Write an SQL query to print details for Workers with the first name as “Vipul” and “Satish” from Worker table.
SELECT * FROM WORKER WHERE FIRST_NAME IN ('Vipul','Satish');
SELECT * FROM WORKER WHERE FIRST_NAME = 'Vipul' OR FIRST_NAME= 'Satish';

#14. Write an SQL query to print details of workers excluding first names, “Vipul” and “Satish” from Worker table.
SELECT * FROM WORKER WHERE FIRST_NAME NOT IN ('Vipul','Satish');

#15. Write an SQL query to print details of Workers with DEPARTMENT name as “Admin”.
SELECT * FROM WORKER WHERE DEPARTMENT='Admin';
SELECT * FROM WORKER WHERE DEPARTMENT LIKE '%Admin%';

#16. Write an SQL query to print details of the Workers whose FIRST_NAME contains ‘a’.
SELECT * FROM WORKER WHERE FIRST_NAME LIKE '%a%';

#17. Write an SQL query to print details of the Workers whose FIRST_NAME ends with ‘a’.
SELECT * FROM WORKER WHERE FIRST_NAME LIKE '%a';

#18. Write an SQL query to print details of the Workers whose FIRST_NAME ends with ‘h’ and contains six alphabets.
SELECT * FROM WORKER WHERE FIRST_NAME LIKE '_____h';

#19. Write an SQL query to print details of the Workers whose SALARY lies between 100000 and 500000.
SELECT * FROM WORKER WHERE SALARY BETWEEN 100000 AND 500000;

#20. Write an SQL query to print details of the Workers who have joined in Feb’2014.
SELECT * FROM WORKER WHERE YEAR(JOINING_DATE)=2014 AND MONTH(JOINING_DATE)=2;

#21. Write an SQL query to fetch the count of employees working in the department ‘Admin’.
SELECT COUNT(WORKER_ID) FROM WORKER WHERE DEPARTMENT = 'Admin';
SELECT COUNT(*) FROM WORKER WHERE DEPARTMENT = 'Admin';

#22. Write an SQL query to fetch worker names with salaries >= 50000 and <= 100000.
SELECT CONCAT(FIRST_NAME,' ',LAST_NAME) AS Worker_Name, SALARY FROM WORKER WHERE SALARY  BETWEEN 50000 AND 100000;

SELECT CONCAT(FIRST_NAME, ' ', LAST_NAME) As Worker_Name, Salary FROM worker WHERE WORKER_ID IN 
(SELECT WORKER_ID FROM worker WHERE Salary BETWEEN 50000 AND 100000);

#23. Write an SQL query to fetch the no. of workers for each department in the descending order.
SELECT DEPARTMENT, COUNT(*) AS Number_of_Workers FROM WORKER 
GROUP BY DEPARTMENT ORDER BY DEPARTMENT DESC;

#24. Write an SQL query to print details of the Workers who are also Managers.
SELECT W.FIRST_NAME, T.WORKER_TITLE FROM Worker W INNER JOIN Title T ON W.WORKER_ID = T.WORKER_REF_ID WHERE T.WORKER_TITLE = 'Manager';

SELECT DISTINCT W.FIRST_NAME, T.WORKER_TITLE
FROM Worker W
INNER JOIN Title T
ON W.WORKER_ID = T.WORKER_REF_ID
AND T.WORKER_TITLE in ('Manager');

#25. Write an SQL query to fetch duplicate records having matching data in some fields of a table TITLE.
SELECT * FROM TITLE
GROUP BY WORKER_TITLE, AFFECTED_FROM
HAVING COUNT(*)>1;	

#26. Write an SQL query to show only odd rows from a table.
SELECT * FROM WORKER WHERE MOD(WORKER_ID,2) <> 0;

#27. Write an SQL query to show only even rows from a table.
SELECT * FROM WORKER WHERE MOD(WORKER_ID,2) = 0 ORDER BY WORKER_ID;

#28. Write an SQL query to clone a new table from another table.
CREATE TABLE DUP_WORKER AS SELECT * FROM WORKER;
SELECT * FROM DUP_WORKER;

CREATE TABLE DUP_WORKER1 LIKE WORKER;
SELECT * INTO DUP_WORKER2 FROM WORKER;

#29. Write an SQL query to fetch intersecting records of two tables.
SELECT * FROM WORKER WHERE WORKER_ID IN (SELECT WORKER_ID FROM DUP_WORKER);


#30. Write an SQL query to show records from one table that another table does not have.
SET SQL_SAFE_UPDATES = 0;
DELETE FROM DUP_WORKER WHERE WORKER_ID IN (1,3);
SELECT * FROM DUP_WORKER;

SELECT * FROM WORKER WHERE WORKER_ID NOT IN ( SELECT WORKER_ID FROM DUP_WORKER);

#31. Write an SQL query to show the current date and time.
SELECT NOW();
SELECT CURDATE();
SELECT CURTIME();
SELECT CURRENT_TIMESTAMP();

#32. Write an SQL query to show the top n (say 10) records of a table.
SELECT * FROM WORKER LIMIT 5;

#33. Write an SQL query to determine the nth (say n=5) highest salary from a table.
SELECT * FROM WORKER ORDER BY SALARY DESC LIMIT 4,1;
SELECT * FROM WORKER ORDER BY SALARY DESC;

#34. Write an SQL query to determine the 5th highest salary without using TOP or limit method. DIFFICULT
SELECT W1.FIRST_NAME, W1.SALARY,W2.FIRST_NAME, W2.SALARY FROM WORKER W1, WORKER W2 WHERE W1.SALARY>W2.SALARY ORDER BY W1.SALARY DESC, W1.FIRST_NAME, W2.SALARY DESC;

SELECT Salary
FROM Worker W1
WHERE 4 = (
 SELECT COUNT( DISTINCT ( W2.Salary ) )
 FROM Worker W2
 WHERE W2.Salary >= W1.Salary
 );
 
 #35.  Write an SQL query to fetch the list of employees with the same salary.
 SELECT W1.FIRST_NAME FROM WORKER W1, WORKER W2 WHERE W1.SALARY=W2.SALARY AND W1.WORKER_ID<>W2.WORKER_ID;
 
 #36. Write an SQL query to show the second highest salary from a table.
 SELECT MAX(SALARY) FROM WORKER WHERE SALARY NOT IN (SELECT MAX(SALARY) FROM WORKER);
 SELECT SALARY FROM WORKER ORDER BY SALARY DESC LIMIT 1 OFFSET 2;
 
 #37. Write an SQL query to show one row twice in results from a table
(SELECT * FROM WORKER WHERE DEPARTMENT='HR')
UNION ALL
SELECT * FROM WORKER WHERE DEPARTMENT='HR';

#38. Write an SQL query to fetch intersecting records of two tables.(Mysql Does not support INTERSECT)
(SELECT * FROM Worker);
#INTERSECT
(SELECT * FROM Dup_Worker);

SELECT DISTINCT * FROM WORKER W INNER JOIN DUP_WORKER D WHERE W.WORKER_ID=D.WORKER_ID;

#39. Write an SQL query to fetch the first 50% records from a table.(Use some kind of INdex/ID)
SELECT * FROM WORKER WHERE WORKER_ID <=  (SELECT COUNT(*)/2 FROM WORKER);

#40. Write an SQL query to fetch the departments that have less than five people in it.
SELECT DEPARTMENT FROM WORKER GROUP BY DEPARTMENT HAVING COUNT(WORKER_ID) < 5;

#41. Write an SQL query to show all departments along with the number of people in there.alter
SELECT DEPARTMENT, COUNT(WORKER_ID) FROM WORKER GROUP BY DEPARTMENT

#42. Write an SQL query to show the last record from a table.
SELECT * FROM WORKER WHERE WORKER_ID = (SELECT MAX(WORKER_ID) FROM WORKER);

#43. Write an SQL query to fetch the first row of a table.
SELECT * FROM WORKER WHERE WORKER_ID = (SELECT MIN(WORKER_ID) FROM WORKER);

#44. Write an SQL query to fetch the last five records from a table.
SELECT * FROM WORKER LIMIT 5 OFFSET 3;

#45.  Write an SQL query to print the name of employees having the highest salary in each department.
SELECT CONCAT_WS(" ",FIRST_NAME,LAST_NAME) AS FULLNAME, MAX(SALARY) OVER (PARTITION BY DEPARTMENT), DEPARTMENT FROM WORKER;

#46. Write an SQL query to fetch three max salaries from a table.
SELECT DISTINCT SALARY FROM WORKER ORDER BY SALARY DESC LIMIT 3;

#47. Write an SQL query to fetch three min salaries from a table.
SELECT DISTINCT SALARY FROM WORKER ORDER BY SALARY LIMIT 3;

#48. Write an SQL query to fetch nth max salaries from a table.
SELECT SALARY FROM WORKER ORDER BY SALARY LIMIT 1 OFFSET N;

#49. Write an SQL query to fetch departments along with the total salaries paid for each of them.
SELECT DEPARTMENT, SUM(SALARY) FROM WORKER GROUP BY DEPARTMENT;

#50. Write an SQL query to fetch the names of workers who earn the highest salary.
SELECT FIRST_NAME, SALARY FROM WORKER WHERE SALARY IN (SELECT MAX(SALARY) FROM WORKER);

#51. Write an SQL Query to create a cummulative or running totlal of the salary colunm from workers table.
SELECT *, SUM(SALARY) OVER ( ORDER BY WORKER_ID ) AS Running_Sal FROM WORKER;

#52. Write an SQL Query to find all paramters of Date
SELECT JOINING_DATE, MONTH(JOINING_DATE), MONTHNAME(JOINING_DATE), DAY(JOINING_DATE),
LEFT(DAYNAME(JOINING_DATE),3), YEAR(JOINING_DATE), QUARTER(JOINING_DATE),
WEEK(JOINING_DATE), WEEKOFYEAR(JOINING_DATE), HOUR(JOINING_DATE) FROM WORKER;

SELECT DATE(JOINING_DATE) FROM WORKER;

#53. Write an SQL Query to find difference between two consecutive joining dates.
SELECT DATEDIFF(JOINING_DATE, LEAD(JOINING_DATE,1) OVER (ORDER BY WORKER_ID)) FROM WORKER;

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


SELECT * FROM WORKER

