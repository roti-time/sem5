create database labtask6d;
use labtask6d;

create table dept(
deptno int,
dname varchar(14),
loc varchar(13),
primary key(deptno),
);

insert into dept values (10, 'accounting', 'new york');
insert into dept values (20, 'research', 'dallas');
insert into dept values (30, 'sales', 'chicago');
insert into dept values (40, 'operations', 'boston');

create table emp
(empno int,
deptno int,
ename varchar(10),
job varchar(9),
mgr numeric (4),
hiredate date,
sal numeric (7, 2),
comm numeric(7, 2),
foreign key (deptno) references dept(deptno),
primary key (empno)
);

insert into emp values(7369, 10, 'smith', 'clerk', 7982, convert (date, '17-dec-1980'), 800, null);
insert into emp values(7499, 40, 'allen', 'salesman',7698, convert(date, '28-feb-1981'), 1688,388);
insert into emp values(7521, 30, 'ward', 'salesman', 7698, convert (date, '22-feb-1981'), 1250, 500);
insert into emp values(7566, 10, 'jones', 'manager',7839, convert (date, '2-apr-1981'), 2975, null);
insert into emp values(7654, 10, 'martin', 'salesman',7698, convert (date, '28-sep-1981'), 1250, 1400);
insert into emp values(7698, 40, 'blake', 'manager',7839, convert (date, '1-may-1981'), 2850, null);
insert into emp values(7782, 30, 'clark', 'manager',7839, convert (date, '9-jun-1981'), 2450, null);
insert into emp values(7788, 10, 'scott', 'analyst', 7566, convert(date, '9-dec-1982'), 3080, null);
insert into emp values(7839, 30, 'king', 'president', null, convert(date, '17-nov-1981'), 5000, null);
insert into emp values(7844, 30, 'turner', 'salesman',7698, convert (date, '8-sep-1981'), 1588, 8);
insert into emp values(7876, 10, 'adams','clerk', 7788, convert(date, '12-jan-1983'), 1100, null);
insert into emp values(7980, 30, 'james', 'clerk',7698, convert(date, '3-dec-1981'), 950, null);
insert into emp values(7902, 40, 'ford', 'analyst',7566, convert (date, '3-dec-1981'), 3000, null);
insert into emp values(7934, 10, 'miller', 'clerk',7782, convert (date, '23-jan-1982'), 1300, null);
insert into emp values(7612, 20, 'cook', 'research',7566, convert (date, '3-dec-1981'), 3000, null);
insert into emp values(7634, 20, 'bairstow', 'research',7782, convert (date, '23-jan-1982'), 1300, null);
insert into emp values(7602, 20, 'broad', 'research',7566, convert (date, '3-dec-1981'), 3000, null);
insert into emp values(7134, 20, 'buttler', 'research',7782, convert (date, '23-jan-1982'), 1300, null);


--Task 1

SELECT d.dname AS department, LOWER(e.ename) AS employee,  e.sal AS salary
FROM emp e
JOIN dept d ON e.deptno = d.deptno
WHERE e.sal > 2000 
AND d.dname = 'research';


--Task 2

SELECT ename AS employee, sal AS salary, deptno AS department
FROM emp
WHERE deptno = 20  
AND (sal = (SELECT MAX(sal) FROM emp WHERE deptno = 20)
     OR sal = (SELECT MIN(sal) FROM emp WHERE deptno = 20));

--Task 3
SELECT ename AS employee, sal AS salary
FROM emp 
WHERE sal = (SELECT MAX(sal) 
             FROM emp 
             WHERE sal < (SELECT MAX(sal) FROM emp));

--Task 4
SELECT CONCAT(ename, ' is ', job) AS INTRO
FROM emp;
