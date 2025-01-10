create database final

use final

create table office(
	OID INT PRIMARY KEY,
	addr varchar(100),
	city varchar(100));

create table manager(
	MID INT PRIMARY KEY,
	OID INT,
	name varchar(100),
	age INT,
	isSI varchar(1),
	phone varchar(100),
	gender varchar(1)
	FOREIGN KEY (OID) REFERENCES office(OID));

	

create table senior(
	SID INT PRIMARY KEY,
	OID INT,
	name varchar(100),
	age INT,
	gender varchar(1),
	phone varchar(100),
	FOREIGN KEY (OID) REFERENCES office(OID)
	);

create table Instructor(
	IID INT PRIMARY KEY,
	OID INT,
	name varchar(100),
	age INT,
	gender varchar(1),
	phone varchar(100),
	FOREIGN KEY (OID) REFERENCES office(OID)
	);

create table lesson(
	 CID INT,
	 LID INT PRIMARY KEY,
	 OID INT,
	 IID INT,
	 date varchar(100),
	 ROF varchar(100),
	 Remarks varchar(100),
	 Result varchar(1),
	 starttime varchar(100),
	 mileage INT,
	 milesdriven INT,

	 FOREIGN KEY (OID) REFERENCES office(OID),
	 FOREIGN KEY (CID) REFERENCES client(ID),
	 FOREIGN KEY (IID) REFERENCES instructor(IID)

	);
	
create table adminstaff(
	ASID INT PRIMARY KEY,
	OID INT,
	name varchar(100),
	age INT,
	gender varchar(1),
	phone varchar(100),
	FOREIGN KEY (OID) REFERENCES office(OID)
	);

	
create table client(
	ID INT PRIMARY KEY,
	OID INT,
	name varchar(100),
	age INT,
	gender varchar(1),
	phone varchar(100),
	addr varchar(100),
	driveattempt INT,
	drivestatus varchar(1),
	writeattempt INT,
	writestatus varchar(1),

	FOREIGN KEY (OID) REFERENCES office(OID)
	);
	
create table interview(
	CID INT,
	IID INT,
	inID INT PRIMARY KEY,
	remarks varchar(100),
	hasPDL varchar(1),

	FOREIGN KEY (IID) REFERENCES Instructor(IID),
	FOREIGN KEY (CID) REFERENCES client(ID)
	);

create table cars(
	REGNUM INT PRIMARY KEY,
	IID INT,
	fault varchar(1),

	FOREIGN KEY (IID) REFERENCES instructor(IID)
	);


	INSERT INTO office(OID, addr, city) VALUES
	(1, 'Bearsden', 'Glasgow'),
	(2, 'addr2', 'Glasgow'),
	(3, 'somewhere', 'another city'),
	(4, 'anywhere?', 'one more city'),
	(5, 'nowhere', 'I dont know city names');

	INSERT INTO manager(MID,OID,name,age,isSI,phone,gender) VALUES
	(1,1,'Micheal',56,'Y','123456','M'),
	(2,2,'Catherine',64,'Y','4575453','F'),
	(3,3,'Samuel',27,'Y','457744','M'),
	(4,4,'Alice',40,'Y','2365445','F'),
	(5,5,'Bob',59,'Y','865543','M');

	INSERT INTO instructor(IID,OID,name,age,gender,phone) VALUES
	(1,1,'Micheal',56,'M','123456'),
	(2,2,'Catherine',64,'F','4575453'),
	(3,3,'Samuel',27,'M','457744'),
	(4,4,'Alice',40,'F','2365445'),
	(5,5,'Bob',59,'M','865543'),
	(6,1,'Allen', 53,'F','3455467');

	INSERT INTO adminstaff(ASID,OID,name,age,gender,phone) VALUES
	(1,1,'Micheal',56,'M','123456'),
	(2,2,'Catherine',64,'F','4575453'),
	(3,3,'Samuel',27,'M','457744'),
	(4,4,'Alice',40,'F','2365445'),
	(5,5,'Bob',59,'M','865543'),
	(6,1,'Allen', 53,'F','3455467');

	INSERT INTO cars(REGNUM,IID,fault) VALUES
	(121212,1,'N'),
	(232323,2,'Y'),
	(343434,3,'N'),
	(454545,4,'Y'),
	(565656,5,'N'),
	(676767,6,'N');

	INSERT INTO client(ID,OID,name,age,gender,phone,addr,driveattempt,drivestatus,writeattempt,writestatus) VALUES
	(1,1,'c1',21,'F','345457','some addr1',1,'P',3,'F'),
	(2,2,'c2',31,'M','495759','some addr2',2,'F',1,'F'),
	(3,3,'c3',23,'F','683929','some addr3',0,'F',0,'F'),
	(4,4,'c4',34,'M','638265','some addr4',3,'P',1,'P'),
	(5,5,'c5',52,'F','798053','some addr5',1,'P',1,'P'),
	(6,1,'c6',45,'M','643456','some addr6',10,'F',1,'P');

	INSERT INTO interview(CID,IID,inID,remarks,hasPDL) VALUES
	(1,1,1,'good I guess','Y'),
	(2,2,2,'amazing?','Y'),
	(3,3,3,'good to go','Y'),
	(4,4,4,'just about right','Y'),
	(5,5,5,'whatever','Y');

	INSERT INTO lesson(CID,LID,OID,IID,date,ROF,Remarks,Result,starttime,mileage,milesdriven) VALUES
	(1,1,1,1,'1-1-2025','NIL','NIL','P','9:00 AM',23,32),
	(2,2,2,2,'1-2-2025','NIL','NIL','F','10:00 AM',17,21),
	(3,3,3,3,'1-3-2025','NIL','NIL','F','9:30 AM',19,17),
	(4,4,4,4,'1-4-2025','NIL','NIL','P','9:50 AM',31,40),
	(5,5,5,5,'1-5-2025','NIL','NIL','P','1:00 PM',9,22);

	INSERT INTO senior(SID,OID,name,age,gender,phone) VALUES
	(1,1,'Micheal',56,'M','123456'),
	(2,2,'Catherine',64,'F','4575453'),
	(3,3,'Samuel',27,'M','457744'),
	(4,4,'Alice',40,'F','2365445'),
	(5,5,'Bob',59,'M','865543'),
	(6,1,'Allen', 53,'F','3455467');


	-- Query 1
	SELECT name, phone FROM manager;

	--Query 2
	SELECT addr, city FROM office;

	--Query 3
	SELECT name FROM instructor
	JOIN office as o
	ON o.OID=instructor.OID
	WHERE instructor.gender='F' AND o.city='Glasgow' AND o.addr='Bearsden';

	--Query 10
	SELECT REGNUM FROM cars
	WHERE fault='N';

	--Query 9
	SELECT phone, name FROM instructor
	WHERE age>55;

	--Query 11
	SELECT cars.REGNUM
	FROM cars
	JOIN instructor as i
	ON i.IID=cars.IID
	WHERE i.OID=1;

	--Query 13

	SELECT name FROM client 
	WHERE driveattempt>3 AND drivestatus='F';