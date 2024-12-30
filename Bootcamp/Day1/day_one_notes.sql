/*
- database
	|_ schema
		|_ trigger
		|_ tables
		|_ 	procedure
		|_ views
*/

-- CREATE TABLE
DROP TABLE IF EXISTS employees;
CREATE TABLE employees (
	id INT,
	name VARCHAR(20),
	dept_id VARCHAR(10),
	salary FLOAT
)

/* Default schema
 * postgres - public
 * MSSQL - dbo
 * Oracle - sys
 */
select * from information_schema.tables where table_schema='public';
ALTER TABLE employees RENAME TO OJCEmployees;

SELECT * FROM ojcemployees;

ALTER TABLE ojcemployees ADD COLUMN DOJ DATE;

INSERT INTO ojcemployees(
	id,
	name,
	dept_id,
	salary,
	doj
)VALUES
(1,'Muthu','Anaytics',5000,to_date('2024-12-12','YYYY-MM-DD'));

DROP TABLE IF EXISTS ojcemployees;

SELECT to_date('2012-12-12','YYYY-MM-DD');
SELECT 'muthu';
SELECT 100;


CREATE TABLE DEPARTMANTS(
	id INT,
	name VARCHAR(20)
);

ALTER TABLE DEPARTMANTS ALTER COLUMN id TYPE VARCHAR(10);

SELECT * FROM DEPARTMANTS;


-- CONSTRAINTS:: Rules
/*
primary key::  used to have unique values + no null values
unique key::   used to have unique value but have null value too
check::        checkk the value in the column as per definition
not null::     does not allow null values
foreign key::  used to built relation
identity
default
*/
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS departmants;

CREATE TABLE DEPARTMANTS(
	id INT PRIMARY KEY,
	name VARCHAR(20) NOT NULL
);

CREATE TABLE EMPLOYEES (
	id INT PRIMARY KEY,
	name VARCHAR(20) NOT NULL,
	dept_id INT REFERENCES DEPARTMANTS(id),
	salary FLOAT CHECK (salary >= 0),
	doj DATE DEFAULT CURRENT_DATE
);

INSERT INTO departmants VALUES (1,'Analytics');
INSERT INTO employees VALUES 
	(1,'space',1,'500'),
	(2,'muthu',1,'120'),
	(3,'kamal',1,'220');

SELECT * FROM employees;
SELECT * FROM departmants;

DROP TABLE IF EXISTS employees,departmants,ojcemployees;
