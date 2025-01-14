-- Create Database
CREATE DATABASE EmployeeManagement;

-- Use the newly created database
USE EmployeeManagement;

-- Creating the Department Table
CREATE TABLE tblDepartment (
    id INTEGER NOT NULL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    location VARCHAR(255) NOT NULL
);

-- Creating the Employee Table
CREATE TABLE tblEmployee (
    id INTEGER NOT NULL PRIMARY KEY,
    firstName VARCHAR(255) NOT NULL,
    lastName VARCHAR(255) NOT NULL,
    salary INTEGER NOT NULL,
    departID INTEGER NULL,
    FOREIGN KEY (departID) REFERENCES tblDepartment(id)
);

-- Inserting sample data into tblDepartment
INSERT INTO tblDepartment (id, name, location)
VALUES
(1, 'IT', 'New York'),
(2, 'HR', 'Los Angeles'),
(3, 'Finance', 'Chicago');

-- Inserting sample data into tblEmployee
INSERT INTO tblEmployee (id, firstName, lastName, salary, departID)
VALUES
(1, 'John', 'Doe', 50000, 1),
(2, 'Jane', 'Smith', 60000, 1),
(3, 'Alice', 'Brown', 40000, 2),
(4, 'Bob', 'Johnson', 70000, 3),
(5, 'Charlie', 'Davis', 30000, 2);

-- Procedure to Display Department with Minimum Average Salary
CREATE PROCEDURE MinAvgSalaryDept
AS
BEGIN
    SELECT TOP 1 name AS DepartmentName
    FROM (
        SELECT tblDepartment.name, AVG(tblEmployee.salary) AS AvgSalary
        FROM tblDepartment
        LEFT JOIN tblEmployee ON tblDepartment.id = tblEmployee.departID
        GROUP BY tblDepartment.name
    ) AS DeptAvg
    ORDER BY AvgSalary ASC;
END;

-- Procedure to Display Employees Below a Specified Salary
CREATE PROCEDURE EmployeesBelowSalary
    @Salary INT,
    @DepartmentName NVARCHAR(255)
AS
BEGIN
    SELECT e.firstName, e.lastName, e.salary, d.name AS DepartmentName
    FROM tblEmployee e
    INNER JOIN tblDepartment d ON e.departID = d.id
    WHERE d.name = @DepartmentName AND e.salary < @Salary;
END;

-- DDL Trigger to Notify Table Creation
CREATE TRIGGER NotifyTableCreation
ON DATABASE
FOR CREATE_TABLE
AS
BEGIN
    PRINT 'Table has been created successfully.';
END;

-- Creating Log Table
CREATE TABLE LogTable (
    Activity VARCHAR(40),
    ActivityDate DATETIME
);

-- DML After Insert Trigger to Maintain Log
CREATE TRIGGER LogInsertActivity
ON tblEmployee
AFTER INSERT
AS
BEGIN
    INSERT INTO LogTable (Activity, ActivityDate)
    VALUES ('Data inserted into tblEmployee', GETDATE());
END;

-- Function to Return Sum of Salaries in a Department
CREATE FUNCTION TotalSalariesByDept
    (@DepartmentName NVARCHAR(255))
RETURNS INT
AS
BEGIN
    DECLARE @TotalSalary INT;
    SELECT @TotalSalary = SUM(e.salary)
    FROM tblEmployee e
    INNER JOIN tblDepartment d ON e.departID = d.id
    WHERE d.name = @DepartmentName;
    RETURN @TotalSalary;
END;

-- Testing the Procedures, Triggers, and Functions

-- Execute Procedure to Find Department with Minimum Average Salary
EXEC MinAvgSalaryDept;

-- Execute Procedure to Find Employees Below a Certain Salary
EXEC EmployeesBelowSalary @Salary = 50000, @DepartmentName = 'HR';

-- Insert Data to Trigger Log
INSERT INTO tblEmployee (id, firstName, lastName, salary, departID)
VALUES (6, 'David', 'Wilson', 35000, 2);

-- Check Log Table
SELECT * FROM LogTable;

-- Execute Function to Get Total Salaries by Department
SELECT dbo.TotalSalariesByDept('IT');
