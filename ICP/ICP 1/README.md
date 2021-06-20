1.List the empno,ename,jobtitle,and hiredate of employee from the employee table.

    create keyspace test with replication={'class':'SimpleStrategy', 'replication_factor':1};
    use test;
    CREATE TABLE emp(ID int PRIMARY KEY, Name text, jobtitle text, hiredate date);
    INSERT INTO emp(ID, Name, jobtitle, hiredate) VALUES (1, 'Bob', 'Janitor', '2010-10-10');
    INSERT INTO emp(ID, Name, jobtitle, hiredate) VALUES (2, 'Joe', 'Programmer', '1990-07-19');
    INSERT INTO emp(ID, Name, jobtitle, hiredate) VALUES (3, 'Bill', 'Analyst', '2015-01-01');
    SELECT * FROM test.emp;

![](https://github.com/mwhol/CS-490/blob/master/ICP/ICP%201/Screenshot%20from%202018-06-10%2012-47-37.png?raw=true)

2.List the name,salary of the employees who are clerks.

    ALTER TABLE test.emp ADD salary int;
    UPDATE emp SET jobtitle  = 'clerk' WHERE id  = 1;
    UPDATE emp SET salary  = 50000 WHERE id  = 1;
    UPDATE emp SET salary  = 10000 WHERE id  = 2;
    UPDATE emp SET salary  = 15000 WHERE id  = 3;
    SELECT name, salary FROM test.emp WHERE jobtitle = 'clerk' ALLOW FILTERING;

![](https://github.com/mwhol/CS-490/blob/master/ICP/ICP%201/Screenshot%20from%202018-06-10%2012-47-56.png?raw=true)

3.List the name,job,salary of every employee joined on ‘december 17,1980’,

    UPDATE emp SET hiredate  = '1980-12-17' WHERE id  = 2;
    SELECT name, jobtitle, salary FROM test.emp WHERE hiredate  = '1980-12-17' ALLOW FILTERING;

![](https://github.com/mwhol/CS-490/blob/master/ICP/ICP%201/Screenshot%20from%202018-06-10%2012-48-07.png?raw=true)

4.List name and annual salary of all the employees.

    SELECT name, salary FROM test.emp ALLOW FILTERING;

![](https://github.com/mwhol/CS-490/blob/master/ICP/ICP%201/Screenshot%20from%202018-06-10%2012-48-18.png?raw=true)

5.List the department name & deptno for departments having deptno.>=20

    CREATE TABLE dept(ID int PRIMARY KEY, Name text, deptno int);
    INSERT INTO dept(ID, Name, deptno) VALUES (1, 'Tech', 20);
    INSERT INTO dept(ID, Name, deptno) VALUES (2, 'Finance', 30);
    SELECT * FROM test.dept WHERE deptno > 20 ALLOW FILTERING;

![](https://github.com/mwhol/CS-490/blob/master/ICP/ICP%201/Screenshot%20from%202018-06-10%2012-48-45.png?raw=true)

6.Display employees’ names, salary and manager values of those employees whose salary is 500 from EMP table using SELECT statement.

    ALTER TABLE test.emp ADD manager text;
    SELECT name, salary, manager FROM test.emp WHERE salary = 500 ALLOW FILTERING;

![](https://github.com/mwhol/CS-490/blob/master/ICP/ICP%201/Screenshot%20from%202018-06-10%2012-49-02.png?raw=true)