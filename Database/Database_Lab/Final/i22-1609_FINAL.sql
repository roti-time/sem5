create database EasyDrive

use EasyDrive;



-- TABLE CREATE START

create table Office (
	B_ID int Identity(1,1) NOT NULL Primary key,
	Located varchar(20) NOT NULL,
);

CREATE TABLE Employee (
	Emp_ID int IDENTITY (1,1) NOT NULL Primary key,
	B_ID int,
	Full_Name VARCHAR(20) NOT NULL,
	Job_title VARCHAR(20) NOT NULL,
	Salary int NOT NULL,
	gender char NOT NULL,

	Foreign KEY(B_ID)REFERENCES Office(B_ID)
);

CREATE TABLE Phone (
	Phone VARCHAR(15) NOT NULL,
	E_ID int,

	Foreign KEY (E_ID) REFERENCES Employee(EMP_ID)
);


CREATE TABLE Manager(
	M_ID int NOT NULL PRIMARY KEY,
	B_ID int,
	E_ID int,

	Foreign key (E_ID) References Employee(Emp_ID)

);





CREATE TABLE Client (
	CNIC int NOT NULL Primary key,
	Full_Name varchar(20) NOT NULL,
	Age INT NOT NULL,
	gender char,
	adress varchar(20),
	Reg_off int,

	FOREIGN KEY(Reg_off) References Office(B_ID)
);

CREATE TABLE Car(
	Reg_no varchar(7) NOT NULL Primary key,
	Mileage int NOT NULL,
	E_ID int,

	Foreign Key (E_ID) REFERENCES Employee(Emp_ID)
);

CREATE TABLE Faults(
	Car varchar(7) NOT NULL primary key,
	Descriptions varchar(30) NOT NULL,

	FOREIGN KEY (Car) REFERENCES Car(Reg_no)

);

CREATE TABLE Test(
	C_ID int,
	E_ID int,
	Delay_Count int,
	Result char,
	Record varchar(20),
	Test_Type varchar(20),
	Waqt DATE,

	Foreign key (C_ID) REFERENCES Client(CNIC),
	Foreign KEY (E_ID) REFERENCES Employee(Emp_ID)
);



CREATE TABLE Lesson(
	E_ID int NOT NULL,
	C_ID int NOT NULL,
	Record varchar(10),
	fee int,
	waqt DATE,

	Foreign key (E_ID) REFERENCES Employee(Emp_ID),
	Foreign key (C_ID) REFERENCES Client(CNIC)
);


-- TABLE CREATION END


-- DATA INSERTION START

-- office
Insert INTO Office VALUES('Glasgow, Sterlings');
Insert INTO Office VALUES('Glasgow, Bearsden');
Insert INTO Office VALUES('Glasgow, Kings');
Insert INTO Office VALUES('Glasgow, Pear');
Insert INTO Office VALUES('Glasgow, Odinson');

-- Employee
Insert INTO Employee VALUES(3,'Talha bin Obaid','Instructor',2500,'M');
Insert INTO Employee VALUES(2,'Fatima Khan','Senior Instructor',2500,'F');
Insert INTO Employee VALUES(1,'Ahmad Abdullah','Senior Instructor',2500,'M');
Insert INTO Employee VALUES(2,'Jalil Ahmad','Instructor',2500,'M');
Insert INTO Employee VALUES(3,'Muhammad Haseeb','Instructor',2500,'M');
Insert INTO Employee VALUES(2,'Maria Khokar','Instructor',2500,'F');
Insert INTO Employee VALUES(4,'Abdul Hadi','Staff',2500,'M');
Insert INTO Employee VALUES(4,'Talha bin Tuaha','Senior Instructor',2500,'M');
Insert INTO Employee VALUES(5,'Hania Amir','Senior Instructor',2500,'F');
Insert INTO Employee VALUES(3,'Umer Farooq','Senior Instructor',2500,'M');

-- Phone
INSERT INTO Phone VALUES(123456789123456,2);
INSERT INTO Phone VALUES(123456789123456,1);
INSERT INTO Phone VALUES(123456789123456,3);
INSERT INTO Phone VALUES(123456789123456,4);
INSERT INTO Phone VALUES(123456789123456,5);
INSERT INTO Phone VALUES(123456789123456,6);
INSERT INTO Phone VALUES(123456789123456,7);
INSERT INTO Phone VALUES(123456789123456,8);
INSERT INTO Phone VALUES(123456789123456,9);
INSERT INTO Phone VALUES(123456789123456,10);
INSERT INTO Phone VALUES(123456789654123,9);
INSERT INTO Phone VALUES(123456789654321,4);
INSERT INTO Phone VALUES(123456789987654,3);
INSERT INTO Phone VALUES(123456789987456,7);
INSERT INTO Phone VALUES(123456789741258,1);



--Manager
INSERT INTO Manager VALUES(1,2,2);
INSERT INTO Manager VALUES(2,1,3);
INSERT INTO Manager VALUES(3,4,8);
INSERT INTO Manager VALUES(4,5,9);
INSERT INTO Manager VALUES(5,3,10);

--Client
INSERT INTO Client Values(1,'Umer Niazi',12,'M','Layyah',5);
INSERT INTO Client Values(2,'Umer Farooq',22,'F','Multan',2);
INSERT INTO Client Values(3,'Umer Safdar',21,'M','Lahore',3);
INSERT INTO Client Values(4,'Umer Khan',45,'F','Larkana',1);
INSERT INTO Client Values(5,'Umer Choti',23,'M','Karachi',2);
INSERT INTO Client Values(6,'Umer Puri',14,'F','Islamabad',4);
INSERT INTO Client Values(7,'Umer Zyada',12,'M','Faisalabad',5);
INSERT INTO Client Values(8,'Umer Kabuli',15,'F','Layyah',3);
INSERT INTO Client Values(9,'Umer kuchbhi',18,'M','Karachi',1);
INSERT INTO Client Values(10,'Umer zyadti',20,'F','Lahore',1);

-- Car
INSERT INTO Car VALUES('abc1234',1000,1);
INSERT INTO Car VALUES('abq1234',100,2);
INSERT INTO Car VALUES('abw1234',3000,3);
INSERT INTO Car VALUES('abe1234',4000,4);
INSERT INTO Car VALUES('abr1234',5000,5);
INSERT INTO Car VALUES('abt1234',6000,6);
INSERT INTO Car VALUES('aby1234',7000,7);
INSERT INTO Car VALUES('abu1234',8000,8);
INSERT INTO Car VALUES('abh1234',900,9);
INSERT INTO Car VALUES('abb1234',4500,10);

-- Faults
INSERT INTO Faults Values('abc1234','Kharab Hogai');
INSERT INTO Faults Values('abr1234','Kharab Hogai');
INSERT INTO Faults Values('abb1234','Kharab Hogai');
INSERT INTO Faults Values('aby1234','Kharab Hogai');
INSERT INTO Faults Values('abh1234','Kharab Hogai');


-- Test
INSERT INTO Test VALUES(1,2,4,'P','This is a Record','Written','10-12-2007')
INSERT INTO Test VALUES(3,3,7,'P','This is a Record','Written','10-12-2013')
INSERT INTO Test VALUES(4,10,2,'P','This is a Record','Written','10-12-2024')
INSERT INTO Test VALUES(5,2,0,'P','This is a Record','Written','10-12-2025')
INSERT INTO Test VALUES(2,4,1,'P','This is a Record','Written','10-12-2054')
INSERT INTO Test VALUES(8,8,6,'P','This is a Record','Written','10-12-2065')

--Lesson
INSERT INTO Lesson VALUES(1,3,'Record',2400,'10-12-2007')
INSERT INTO Lesson VALUES(3,1,'Record',2400,'10-12-2008')
INSERT INTO Lesson VALUES(2,2,'Record',2400,'10-12-2005')
INSERT INTO Lesson VALUES(4,5,'Record',2400,'10-12-2008')
INSERT INTO Lesson VALUES(6,6,'Record',2400,'10-12-2002')
INSERT INTO Lesson VALUES(9,7,'Record',2400,'10-12-2000')

-- Question# 4

Select * FROM Manager

Select * from office
Select * FROM Phone
Select * From Client
Select * From Test
Select * FROM Employee
Select * FROM Car
Select * FROM Faults
Select * from office

-- 1) Multiple Phone Numbers
Select Full_Name,Phone From Employee,Phone,Manager Where Manager.E_ID=Employee.Emp_ID AND Manager.E_ID=Phone.E_ID;

-- 2)
Select Located From Office;

-- 3)
Select Full_Name From Employee,Office Where gender='F' AND Located='Glasgow, Bearsden' AND Job_title='Instructor';

-- 13)
Select Full_Name From Client, Test Where CNIC=C_ID AND Delay_Count>3 AND Result!='P';

-- 7)
Select Full_Name,Record as InterView_Details From Employee, Test where Emp_ID=E_ID;

-- 11)
Select Reg_no From Car,Office,Employee where Employee.Emp_ID=Car.E_ID AND Employee.B_ID=Office.B_ID AND Located='Glasgow, Bearsden';

-- 10)
Select Reg_no From Car,Faults where Car.Reg_no != Faults.Car;