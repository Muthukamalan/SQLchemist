DROP TABLE IF EXISTS employees;

CREATE TABLE employees (
    Emp_ID INT PRIMARY KEY,
    Emp_Name VARCHAR(50),
    Manager_ID INT
);


INSERT INTO employees (Emp_ID, Emp_Name, Manager_ID) VALUES
(1, 'John', 3),
(2, 'Philip', 3),
(3, 'Keith', 7),
(4, 'Quinton', 6),
(5, 'Steve', 7),
(6, 'Harry', 5),
(7, 'Gill', 8),
(8, 'Rock', NULL);

-- Explore
SELECT * from employees;

-- Given table employees, write a  query to display employee names along with manager names
select 
	   emp.emp_id   as emp_id,
	   emp.emp_name as emp_name,
	   emp.manager_id as manager_id,
       mng.emp_name as manager_name
from employees as emp
    inner join employees as mng
        on emp.manager_id = mng.emp_id;

