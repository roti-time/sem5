/*create database labtask8;
use labtask8;

CREATE TABLE tblEmployee (
id INTEGER NOT NULL,
firstName VARCHAR(255) NOT NULL,
lastName VARCHAR(255) NOT NULL,
salary INTEGER NOT NULL,
departID INTEGER NULL
);

CREATE TABLE tblDepartment (
id INTEGER NOT NULL,
name VARCHAR(255) NOT NULL,
location VARCHAR(255) NOT NULL
);

INSERT INTO tblEmployee (id, firstName, lastName, salary, departID) VALUES
(1, 'Abhishek', 'Yadav', 37000, 1),
(2, 'Raj', 'Verma', 47500, 2),
(3, 'Tony', 'Bell', 44000, 3),
(4, 'Rahul', 'Sharma', 27000, NULL),
(5, 'Vishal', 'Maurya', 18500, 4),
(6, 'Vipin', 'Kakawat', 30000, 1),
(7, 'Vipin', 'Mehra', 30000, 2),
(8, 'Pradeep', 'Gupta', 30000, 1),
(9, 'Sumit', 'Jolly', 55000, 6),
(10, 'Jyoti', 'Mishra', 20000, NULL),
(11, 'Karan', 'Pratap', 25000, 2),
(12, 'Aleem', 'Shaikh', 30000, 1),
(13, 'Kavita', 'Thakur', 30000, 4),
(14, 'Sufyan', 'Mukadam', 30000, 5),
(15, 'Ashish', 'Mehra', 37000, NULL),
(16, 'Mehul', 'Joshi', 15000, 4),
(17, 'Payal', 'Yadav', 15000, 5),
(18, 'Swapnil', 'Patel', 36000, 5),
(19, 'Richa', 'Patel', 35000, NULL),
(20, 'Mahesh', 'Singh', 33000, 5),
(21, 'Kaleem', 'Khan', 8000, 4),
(22, 'Heena', 'Shaikh', 14000, NULL),
(23, 'Rahul', 'Kotian', 26000, 3),
(24, 'Naveen', 'Kapoor', 37000, NULL),
(25, 'Sanjay', 'Sawant', 65000, 3);

INSERT INTO tblDepartment (id, name, location) VALUES
(1, 'SQL', 'Mumbai'),
(2, 'Finance', 'Pune'),
(3, 'SDM', 'Thane'),
(4, 'MySQL', 'Chennai'),
(5, 'DB2', 'Kolkata'),
(6, 'Oracle', 'Delhi'),
(7, 'Marketing', 'Delhi'),
(8, 'Networking', 'Mumbai'),
(9, 'HR', 'Mumbai');*/

SELECT 
    e.id,
    CONCAT(e.firstName, ' ', e.lastName) AS fullname,
    e.salary,
    d.name AS department_name,
    d.location AS department_location
FROM 
    tblEmployee e
LEFT JOIN 
    tblDepartment d 
ON 
    e.departID = d.id;


SELECT 
    d.name AS department_name,
    COUNT(e.id) AS total_employees
FROM 
    tblDepartment d
JOIN 
    tblEmployee e ON d.id = e.departID
GROUP BY 
    d.name;


SELECT 
    d.name AS department_name, 
    e.salary
FROM 
    tblEmployee e
JOIN 
    tblDepartment d ON e.departID = d.id
WHERE 
    e.salary = (SELECT MIN(salary) FROM tblEmployee);


SELECT 
    d.name AS department_name, 
    AVG(e.salary) AS avg_salary
FROM 
    tblEmployee e
JOIN 
    tblDepartment d ON e.departID = d.id
GROUP BY 
    d.name
HAVING 
    AVG(e.salary) = (
        SELECT MIN(avg_salary)
        FROM (
            SELECT AVG(salary) AS avg_salary 
            FROM tblEmployee 
            GROUP BY departID
        ) AS avg_salaries
    );
