/*Table1*/

CREATE TABLE EmployeeDemographics(
EmployeeID int,
FirstName varchar(50),
LastName varchar(50),
Age int,
Gender varchar(50));

/*Table2*/

CREATE TABLE EmployeeSalary(
EmpID int,
JobTitle char(15),
Salary int(10)
); 

INSERT INTO EmployeeDemographics VALUES
(1001, 'John', 'Wick' ,30, 'Male'),
(1002, 'Chris', 'Evans' ,45, 'Male'),
(1003, 'Nat', 'Johnson' ,28, 'Female'),
(1004, 'Hanna', 'Barbera' ,45, 'Female'),
(1005, 'Illios', 'Durelo' ,37, 'Male'),
(1006, 'Sonia', 'Wilson' ,34, 'Female');


DELETE FROM EmployeeDemographics WHERE EmployeeID=1001;

ALTER TABLE EmployeeSalary
MODIFY JobTitle char(30);

Insert into EmployeeSalary Values
(1002, 'Data Analyst', 760000),
(1003, 'Business Developer', 890000),
(1004, 'Database Admin', 670000),
(1005, 'Senior Software Developer', 540000),
(1006, 'Dev-ops', 660000);

INSERT INTO EmployeeDemographics VALUES
(1001, 'John', 'Wick' ,49, 'Male'),
(1007, 'Tom', 'Hanks' ,51, 'Male'),
(1008, 'Gal', 'Gadot' ,25, 'Female'),
(1009, 'Will', 'Smith' ,46, 'Male'),
(1010, 'Taylor', 'Grande' ,36, 'Female'),
(1011, 'Zack', 'Efron' ,22, 'Male');

Insert into EmployeeSalary Values
(1001, 'Data Scientist', 960000),
(1007, 'Salesforce Developer', NULL),
(1010, 'SAP Developer', 67000),
(1009, 'Project Lead', NULL),
(1008, 'Consultant', 78000),
(1011, 'Accountant', 80000);

Insert into EmployeeSalary Values
(NULL, 'Data Analyst', 870000),
(NULL, 'SQL Developer', 75000);

Update EmployeeDemographics SET Age=NULL where EmployeeID in (1005,1007);

INSERT INTO EmployeeDemographics VALUES
(NULL, 'Einstein', 'Welberk' ,56, 'Male');

/*Table 3*/

CREATE TABLE WarehouseEmployeeDemographics(
EmployeeID int,
FirstName varchar(50),
LastName varchar(50),
Age int,
Gender varchar(50));

INSERT INTO WarehouseEmployeeDemographics
SELECT * FROM EmployeeDemographics WHERE AGE>34;

INSERT INTO WarehouseEmployeeDemographics VALUES
(1015, 'Cyrus', 'Dakota' ,45, 'Male'),
(1017, 'Kenny', 'Sebastian' ,24, 'Male'),
(1018, 'Jackie', 'Chan' ,55, 'Male'),
(1019, 'Sia', 'Pierce' ,46, 'Female');

DELETE FROM EmployeeDemographics WHERE EmployeeID IN (1015,1017,1018,1019);

Insert into EmployeeSalary Values
(1005, 'Data Scientist', 100000),
(1006, 'Salesforce Developer', 88000),
(1021, 'SAP Developer', 77000);