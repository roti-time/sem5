/*USE Labtask1;

CREATE TABLE emp (
  empno NUMERIC(4) NOT NULL,
  ename VARCHAR(10),
  job VARCHAR(9),
  mgr NUMERIC(4),
  hiredate DATE,
  sal NUMERIC(7, 2),
  comm NUMERIC(7, 2),
  deptno NUMERIC(2)
);

INSERT INTO emp VALUES (7369, "SMITH", "CLERK", 7902, CONVERT(DATE, "1980-12-17", 23), 800, NULL, 20);
INSERT INTO emp VALUES (7499, "ALLEN", "SALESMAN", 7698, CONVERT(DATE, "1981-02-20", 23), 1600, 300, 30);
INSERT INTO emp VALUES (7521, "WARD", "SALESMAN", 7698, CONVERT(DATE, "1981-02-22", 23), 1250, 500, 30);
INSERT INTO emp VALUES (7566, "JONES", "MANAGER", 7839, CONVERT(DATE, "1981-04-02", 23), 2975, NULL, 20);
INSERT INTO emp VALUES (7654, "MARTIN", "SALESMAN", 7698, CONVERT(DATE, "1981-09-28", 23), 1250, 1400, 30);
INSERT INTO emp VALUES (7698, "BLAKE", "MANAGER", 7839, CONVERT(DATE, "1981-05-01", 23), 2850, NULL, 30);
INSERT INTO emp VALUES (7782, "CLARK", "MANAGER", 7839, CONVERT(DATE, "1981-06-19", 23), 2450, NULL, 10);
INSERT INTO emp VALUES (7788, "SCOTT", "ANALYST", 7566, CONVERT(DATE, "1982-12-09", 23), 3000, NULL, 20);
INSERT INTO emp VALUES (7839, "KING", "PRESIDENT", NULL, CONVERT(DATE, "1981-11-17", 23), 5000, NULL, 10);
INSERT INTO emp VALUES (7844, "TURNER", "SALESMAN", 7698, CONVERT(DATE, "1981-09-08", 23), 1500, 0, 30);
INSERT INTO emp VALUES (7876, "ADAMS", "CLERK", 7788, CONVERT(DATE, "1983-01-12", 23), 1100, NULL, 20);
INSERT INTO emp VALUES (7900, "JAMES", "CLERK", 7698, CONVERT(DATE, "1981-12-03", 23), 950, NULL, 30);
INSERT INTO emp VALUES (7902, "FORD", "ANALYST", 7566, CONVERT(DATE, "1981-12-03", 23), 3000, NULL, 20);
INSERT INTO emp VALUES (7934, "MILLER", "CLERK", 7782, CONVERT(DATE, "1982-01-23", 23), 1300, NULL, 10);
*/
SELECT * FROM emp
/*TASK 1*/
SELECT empno,ename,sal, sal+300 AS Inceremented_Salary FROM emp 

/*TASK 2*/

SELECT empno,ename,sal,comm FROM emp WHERE comm IS NULL

/*TASK 3*/

SELECT DISTINCT job FROM emp

/*TASK 4*/

SELECT empno,ename,job,sal FROM emp WHERE sal > 1500

/* TASK 5*/

SELECT empno, ename, job 
FROM emp 
WHERE job NOT IN ('Analyst' , 'Clerk','Salesman')

/*TASK 6*/
SELECT * FROM emp ORDER BY hiredate

