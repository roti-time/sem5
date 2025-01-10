-- Create Tables
CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY IDENTITY(1,1),
    DepartmentName NVARCHAR(50) NOT NULL
);

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY IDENTITY(1,1),
    EmployeeName NVARCHAR(50) NOT NULL,
    Salary INT NOT NULL,
    DepartmentID INT,
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

-- Insert Sample Data
INSERT INTO Departments (DepartmentName)
VALUES ('HR'), ('IT'), ('Finance'), ('Marketing');

INSERT INTO Employees (EmployeeName, Salary, DepartmentID)
VALUES 
('Alice', 45000, 1),
('Bob', 55000, 1),
('Charlie', 40000, 2),
('Diana', 60000, 2),
('Eve', 50000, 3),
('Frank', 35000, 3),
('Grace', 30000, 4),
('Hank', 25000, 4),
('Ivy', 20000, 4);

-- Create Procedure to Display Department with Minimum Average Salary
CREATE PROCEDURE MinAvgSalaryDepartment
AS
BEGIN
    SELECT TOP 1 DepartmentName
    FROM Departments
    INNER JOIN Employees ON Departments.DepartmentID = Employees.DepartmentID
    GROUP BY DepartmentName
    ORDER BY AVG(Salary) ASC;
END;

-- Create Procedure to Display Employees Below a Specified Salary in a Department
CREATE PROCEDURE EmployeesWithSalary (
    @Salary INT,
    @DepartmentName NVARCHAR(50)
)
AS
BEGIN
    SELECT EmployeeName, Salary, DepartmentName
    FROM Employees
    INNER JOIN Departments ON Employees.DepartmentID = Departments.DepartmentID
    WHERE Salary < @Salary AND DepartmentName = @DepartmentName;
END;

-- Create DDL Trigger to Notify on Table Creation
CREATE TRIGGER TableCreationNotification
ON DATABASE
FOR CREATE_TABLE
AS
BEGIN
    PRINT 'Table has been created successfully.';
END;

-- Create Log Table for DML Trigger
CREATE TABLE LogTable (
    Activity VARCHAR(40),
    LogDate DATETIME
);

-- Create DML Trigger to Log Insertions
CREATE TRIGGER InsertLogTrigger
ON Employees
AFTER INSERT
AS
BEGIN
    INSERT INTO LogTable (Activity, LogDate)
    VALUES ('Data inserted into Employees table', GETDATE());
END;

-- Create Function to Return Total Salaries by Department
CREATE FUNCTION TotalSalariesByDepartment (
    @DepartmentName NVARCHAR(50)
)
RETURNS INT
AS
BEGIN
    DECLARE @TotalSalary INT;
    SELECT @TotalSalary = SUM(Salary)
    FROM Employees
    INNER JOIN Departments ON Employees.DepartmentID = Departments.DepartmentID
    WHERE DepartmentName = @DepartmentName;

    RETURN @TotalSalary;
END;


EXEC MinAvgSalaryDepartment;

EXEC EmployeesWithSalary @Salary = 50000, @DepartmentName = 'Marketing';

CREATE TABLE TestTable (ID INT);

INSERT INTO Employees (EmployeeName, Salary, DepartmentID)
VALUES ('Jack', 40000, 1);
SELECT * FROM LogTable;

SELECT dbo.TotalSalariesByDepartment('IT');
