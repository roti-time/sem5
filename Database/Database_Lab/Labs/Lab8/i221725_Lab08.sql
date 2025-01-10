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

SELECT * 
FROM tblEmployee


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
(25, 'Sanjay', 'Sawant', 65000, 3);

INSERT into tblDepartment VALUES (
1, 'Structured Query Language', 'Lahore'
);
INSERT into tblDepartment VALUES (
2, 'Finance and Management', 'Peshawar'
);
INSERT into tblDepartment VALUES (
3, 'SQL', 'Mumbai'
);
INSERT into tblDepartment VALUES (
4, 'SDM', 'Thane'
);
INSERT into tblDepartment VALUES (
5, 'MySQL', 'Chennai'
);
INSERT into tblDepartment VALUES (
6, 'DB2', 'Kolkata'
);
INSERT into tblDepartment VALUES (
7, 'Oracle', 'Delhi'
);
INSERT into tblDepartment VALUES (
8, 'Marketing', 'Delhi'
);
INSERT into tblDepartment VALUES (
9, 'Marketing', 'Mumbai'
);
INSERT into tblDepartment VALUES (
10, 'HR', 'Mumbai'
);
INSERT into tblDepartment VALUES (
11, 'Marketing', 'Swat'
);
INSERT into tblDepartment VALUES (
12, 'Data entry', 'Kabul'
);


--Task 1

SELECT 
    tblEmployee.id AS EMP_NUMBER, 
    CONCAT(tblEmployee.firstName, ' ', tblEmployee.lastName) AS FULL_NAME, 
    tblEmployee.salary, 
    tblDepartment.name AS DEPT_NAME, 
    tblDepartment.location AS DEPT_ADDRESS
FROM 
    tblEmployee
LEFT JOIN 
    tblDepartment
ON 
    tblEmployee.departID = tblDepartment.id;


--Task 2

SELECT 
	COUNT(tblEmployee.id) AS TOTAL_EMPS_IN_EACH_DEPARTMENT,
	tblDepartment.name AS DNAME

FROM
	tblEmployee
JOIN
	tblDepartment
ON
	tblEmployee.departID = tblDepartment.id
GROUP BY
	tblDepartment.name;

--Task 3

SELECT
	tblDepartment.name AS department_name,
	tblDepartment.id AS department_id,
	tblDepartment.location AS department_location
FROM
	tblEmployee
JOIN
	tblDepartment
ON 
	tblEmployee.departid=tblDepartment.id
WHERE
	tblEmployee.salary = (SELECT MIN(salary) FROM tblEmployee);


--Task 4

SELECT 
    tblDepartment.name AS DEPT_NAME, 
    tblDepartment.location AS DEPT_ADDRESS
FROM 
    tblDepartment
JOIN 
    tblEmployee
ON 
    tblDepartment.id = tblEmployee.departID
GROUP BY 
    tblDepartment.name, tblDepartment.location
HAVING 
    AVG(tblEmployee.salary) = (
        SELECT MIN(avgSalary) 
        FROM (
            SELECT AVG(tblEmployee.salary) AS avgSalary 
            FROM tblEmployee
            JOIN tblDepartment
            ON tblEmployee.departID = tblDepartment.id
            GROUP BY tblDepartment.name
        ) AS subquery
    );


