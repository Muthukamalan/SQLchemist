/* TABLE CREATION */
-- Create department table
DROP TABLE IF EXISTS department;
CREATE TABLE department(department_id INT PRIMARY KEY, department    VARCHAR(50),location_id   INT );
-- Insert data into department table
INSERT INTO department (
			 department_id,
             department,
             location_id)
VALUES(10,'Accounting',122),(20,'Research',124),(30,'Sales',123),(40,'Operations',167);

-- Create emp_fact table
DROP TABLE IF EXISTS emp_fact;
CREATE TABLE emp_fact(
     employee_id   INT PRIMARY KEY,
     emp_name      VARCHAR(50),
     job_id        INT,
     manager_id    INT,
     hired_date    DATE,
     salary        DECIMAL(10, 2),
     department_id INT,
     FOREIGN KEY (department_id) REFERENCES department(department_id)
  );
-- Insert data into emp_fact table
INSERT INTO emp_fact
            (employee_id,
             emp_name,
             job_id,
             manager_id,
             hired_date,
             salary,
             department_id)
VALUES      
	(7369,'John',667,7902,'2006-02-20',800.00,10),
	(7499,'Kevin',670,7698,'2008-11-24',1550.00,20),
  (7505,'Jean',671,7839,'2009-05-27',2750.00,30),
  (7506,'Lynn',671,7839,'2007-09-27',1550.00,30),
  (7507,'Chelsea',670,7110,'2014-09-14',2200.00,30),
  (7521,'Leslie',672,7698,'2012-02-06',1250.00,30);

-- Create jobs table
DROP TABLE IF EXISTS jobs;

CREATE TABLE jobs
  (
     job_id   INT PRIMARY KEY,
     job_role VARCHAR(50),
     salary   DECIMAL(10, 2)
  );

-- Insert data into jobs table
INSERT INTO jobs
            (job_id,
             job_role,
             salary)
VALUES(667,'Clerk',800.00),
      (668,'Staff',1600.00),
      (669,'Analyst',2850.00),
      (670,'Salesperson',2200.00),
      (671,'Manager',3050.00),
      (672,'President',1250.00);  




/* EXPLOTE */

select * from public.department; -- department_id, department, location_id
SELECT * FROM public.emp_fact;   -- employee_id, emp_name, job_id, manager_id, hired_date, salary, department_id
SELECT * FROM public.jobs;


-- List out the department wise MIN,MAX,AVG salary of the employee
select 
	dept.department,
	max(emp.salary) as MAX_SALARY, 
	min(emp.salary) as MIN_SALARY,
	avg(emp.salary) as AVG_SALARY 
from department as dept
join  emp_fact as emp on emp.department_id = dept.department_id
group by dept.department;


-- Lit out employee who having 3rd highest salary.
with ranked_salary as(
	SELECT salary,ROW_NUMBER() OVER(ORDER BY salary) as rnk FROM emp_fact ORDER BY salary ASC
) SELECT emp_name from emp_fact 
join ranked_salary on emp_fact.salary=ranked_salary.salary 
where ranked_salary.rnk=3;


--  List out the department having at least four employees.
select 
	dept.department,count(emp.employee_id) as EMP_COUNT
from department as dept
join  emp_fact as emp on emp.department_id = dept.department_id
group by dept.department
having count(emp.employee_id)>=4;


-- Find out the employees who earn greater than the average salary for their department.
-- APPROACH:1
with emp_salary as (
	select 
		emp.emp_name,
		dept.department,
		emp.salary 
	from department as dept
	join emp_fact as emp on  emp.department_id = dept.department_id
), dept_avg_salary as (
	select 
		dept.department,
		avg(emp.salary) as AVG_SALARY 
	from department as dept 
	join  emp_fact as emp on emp.department_id = dept.department_id 
	group by dept.department
)
	select 
		emp_sal.emp_name, 
		emp_sal.department,
		emp_sal.salary,
		emp_sal.salary - dpt_avg_sal.avg_salary as difference_amount 
	from emp_salary as emp_sal
	join dept_avg_salary as dpt_avg_sal 
		on 
			emp_sal.department = dpt_avg_sal.department 
			and emp_sal.salary > dpt_avg_sal.AVG_SALARY;



-- APPROACH:2
SELECT 
    e1.employee_id,
    e1.emp_name,
    e1.salary,
    e1.department_id
FROM emp_fact as e1 
WHERE e1.salary > (SELECT
                    AVG(e2.salary)
                FROM emp_fact as e2
                WHERE e2.department_id = e1.department_id);