SELECT * FROM pg_catalog.pg_tables;


-- QUESTION No:1

-- Create the student_batch table
CREATE TABLE student_batch (
    StudentID INT,
    CourseID INT,
    EnrollmentYear INT
);

-- Insert sample records into the student_batch table
INSERT INTO student_batch (
		StudentID, 
		CourseID, 
		EnrollmentYear
) VALUES
(1, 101, 2019),(1, 102, 2019),(1, 103, 2019),(1, 104, 2019),(1, 105, 2019),(1, 106, 2019),(1, 107, 2019),(1, 108, 2019),(1, 109, 2019),(1, 110, 2019),(2, 101, 2019),(2, 102, 2019),(2, 103, 2019),(2, 104, 2019),(2, 105, 2019),(2, 106, 2019),(2, 107, 2019),(2, 108, 2019),(2, 109, 2019),(2, 110, 2019),(3, 101, 2019),(3, 102, 2019),(3, 103, 2019),(3, 104, 2019),(3, 105, 2019),(3, 106, 2019),(3, 107, 2019),(3, 108, 2019),(4, 101, 2019),(4, 102, 2019),(4, 103, 2019),(4, 104, 2019),(4, 105, 2019),(4, 106, 2019),(4, 107, 2019),(4, 108, 2019),(4, 109, 2019),(1, 105, 2020),(1, 106, 2020),(3, 107, 2020),(4, 108, 2019),(4, 109, 2020),(2, 106, 2020),(1, 107, 2020),(4, 110, 2020),
(4, 111, 2020);

-- View Tble
select * from student_batch;

/* Write a query to get the list of StudentID(s) who had enrolled in all courses available in 2019.
Suppoese there were 10 couses available in 2k19, the qeury should return the StudentID(s) who were enrolled in all courses/
*/

-- 10 courses were available in 2k19
select
	count(DISTINCT(sb.courseid)) 
from student_batch as sb 
where sb.enrollmentyear=2019;

 SELECT sb.studentid,
       Count(DISTINCT( sb.courseid ))
FROM   student_batch AS sb
WHERE  sb.enrollmentyear = 2019
GROUP  BY sb.studentid
HAVING Count(DISTINCT( sb.courseid )) = (SELECT Count(DISTINCT( sb.courseid ))
                                         FROM   student_batch AS sb
                                         WHERE  sb.enrollmentyear = 2019);  
	
	

-- Question No --2
CREATE TABLE t1(c1 INT);
CREATE TABLE t2(c2 VARCHAR);
INSERT INTO t1 VALUES (4),(6),(7),(9),(3),(9);
INSERT INTO t2 VALUES (1),(5),(9),(2),(2),(11);

-- What will be the output?
select * from t1; -- c1 INT      4,6,7,9,3,9
select * from t2; -- c2 VARCHAR  1,5,9,2,2,11

SELECT 
	t1.c1 
FROM t1
RIGHT JOIN t2 ON t1.c1 = CAST(t2.c2 AS INT); -- NO Order place because VARCHAR -- NA,NA,NA,NA,9,9,NA


SELECT 
	t1.c1 
FROM t1
LEFT JOIN t2 ON t1.c1 = CAST(t2.c2 AS INT); -- 3,4,6,7,9,9 ordered since it's INT


SELECT 
	t1.c1 
FROM t1
INNER JOIN t2 ON t1.c1 = CAST(t2.c2 AS INT)


SELECT 
	t1.c1 
FROM t1
FULL OUTER JOIN t2 ON t1.c1 = CAST(t2.c2 AS INT--
	
SELECT 
	t1.c1 
FROM t1
INNER JOIN t2 ON t1.c1 = CAST(t2.c2 AS INT); -- NA,NA,3,4,NA,6,7,9,9,NA


