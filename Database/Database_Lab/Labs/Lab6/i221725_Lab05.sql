create database Labtask1;
use Labtask1;
create table emp
	(empno numeric(4) not null, ename varchar(10), job varchar(9), mgr numeric(4), hiredate date, sal numeric(7, 2), comm numeric(7, 2), deptno numeric(2));

INSERT INTO emp VALUES
(7369, 'SMITH', 'CLERK', 7902, CONVERT(date, '17-DEC-1980'), 800, NULL, 20),
(7499, 'ALLEN', 'SALESMAN', 7698, CONVERT(date, '20-FEB-1981'), 1600, 300, 30),
(7521, 'WARD', 'SALESMAN', 7698, CONVERT(date, '22-FEB-1981'), 1250, 500, 30),
(7566, 'JONES', 'MANAGER', 7839, CONVERT(date, '2-APR-1981'), 2975, NULL, 20),
(7654, 'MARTIN', 'SALESMAN', 7698, CONVERT(date, '28-SEP-1981'), 1250, 1400, 30),
(7698, 'BLAKE', 'MANAGER', 7839, CONVERT(date, '1-MAY-1981'), 2850, NULL, 30),
(7782, 'CLARK', 'MANAGER', 7839, CONVERT(date, '9-JUN-1981'), 2450, NULL, 10),
(7788, 'SCOTT', 'ANALYST', 7566, CONVERT(date, '09-DEC-1982'), 3000, NULL, 20),
(7839, 'KING', 'PRESIDENT', NULL, CONVERT(date, '17-NOV-1981'), 5000, NULL, 10),
(7844, 'TURNER', 'SALESMAN', 7698, CONVERT(date, '8-SEP-1981'), 1500, 0, 30),
(7876, 'ADAMS', 'CLERK', 7788, CONVERT(date, '12-JAN-1983'), 1100, NULL, 20),
(7900, 'JAMES', 'CLERK', 7698, CONVERT(date, '3-DEC-1981'), 950, NULL, 30),
(7902, 'FORD', 'ANALYST', 7566, CONVERT(date, '3-DEC-1981'), 3000, NULL, 20),
(7934, 'MILLER', 'CLERK', 7782, CONVERT(date, '23-JAN-1982'), 1300, NULL, 10);


select ename, sal, sal + 300 as new_salary
from emp;


select ename, job, sal
from emp
where comm is null;


select job
from emp


select empno, ename, job, sal
from emp
where sal > 1500 and job like '%MAN%';


select ename, job
from emp
where job not in ('CLERK', 'ANALYST', 'SALESMAN');


select *
from emp
order by hiredate;