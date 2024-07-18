-- Create the student_details table
DROP TABLE IF EXISTS students;
CREATE TABLE students (
    ID INT PRIMARY KEY,
    Name VARCHAR(50),
    Gender CHAR(1)
);
-- Insert values
INSERT INTO students (ID, Name, Gender) 
VALUES 
    (1, 'Gopal', 'M'),
    (2, 'Rohit', 'M'),
    (3, 'Amit', 'M'),
    (4, 'Suraj', 'M'),
    (5, 'Ganesh', 'M'),
    (6, 'Neha', 'F'),
    (7, 'Isha', 'F'),
    (8, 'Geeta', 'F');

-- Explore 
SELECT * FROM students;

-- Given table student_details, write a query which displays names  alternately by gender and sorted  by ascending order of column ID
SELECT 
	id,
	CASE
            WHEN gender = 'M' THEN 0
            ELSE 100
          END  as assigned_vals,
	name,
	gender
FROM   students
ORDER  BY Row_number()
            OVER(
              partition BY gender
              ORDER BY id),                        -- since id act as row_number() already, so we order by id to resolve easily.
          CASE
            WHEN gender = 'M' THEN 0
            ELSE 100
          END ;