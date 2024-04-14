-- General Instructions
-- 1.	The .sql files are run automatically, so please ensure that there are no syntax errors in the file. If we are unable to run your file, you get an automatic reduction to 0 marks.
-- Comment in MYSQL 

-- 1
SELECT s.first_name, s.last_name, c.course_name
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
JOIN courses c ON e.course_id = c.course_id;
-- 2
SELECT c.course_name, e.grade
FROM enrollments e
JOIN courses c ON e.course_id = c.course_id;
-- 3
SELECT s.first_name, s.last_name, c.course_name, i.first_name AS instructor_first_name, i.last_name AS instructor_last_name
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
JOIN courses c ON e.course_id = c.course_id
JOIN instructors i ON c.instructor_id = i.instructor_id;
-- 4
SELECT s.first_name, s.last_name, s.age, s.city
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
JOIN courses c ON e.course_id = c.course_id
WHERE c.course_name = 'Mathematics';
-- 5
SELECT c.course_name, i.first_name AS instructor_first_name, i.last_name AS instructor_last_name
FROM courses c
JOIN instructors i ON c.instructor_id = i.instructor_id;
-- 6
SELECT s.first_name, s.last_name, e.grade, c.course_name
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
JOIN courses c ON e.course_id = c.course_id;
-- 7
SELECT s.first_name, s.last_name, s.age
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
GROUP BY s.student_id
HAVING COUNT(e.enrollment_id) > 1;
-- 8
SELECT c.course_name, COUNT(e.enrollment_id) AS enrolled_students
FROM courses c
LEFT JOIN enrollments e ON c.course_id = e.course_id
GROUP BY c.course_id;
-- 9
SELECT s.first_name, s.last_name, s.age
FROM students s
LEFT JOIN enrollments e ON s.student_id = e.student_id
WHERE e.enrollment_id IS NULL;
-- 10
SELECT c.course_name, AVG(grade) AS average_grade
FROM courses c
JOIN enrollments e ON c.course_id = e.course_id
GROUP BY c.course_id;
-- 11
SELECT s.first_name, s.last_name, c.course_name, e.grade
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
JOIN courses c ON e.course_id = c.course_id
WHERE e.grade > 'B';
-- 12
SELECT c.course_name, i.first_name AS instructor_first_name, i.last_name AS instructor_last_name
FROM courses c
JOIN instructors i ON c.instructor_id = i.instructor_id
WHERE i.last_name LIKE 'S%';
-- 13
SELECT s.first_name, s.last_name, s.age
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
JOIN courses c ON e.course_id = c.course_id
JOIN instructors i ON c.instructor_id = i.instructor_id
WHERE i.first_name = 'Dr. Akhil';
-- 14
SELECT c.course_name, MAX(e.grade) AS max_grade
FROM courses c
JOIN enrollments e ON c.course_id = e.course_id
GROUP BY c.course_id;
-- 15
SELECT s.first_name, s.last_name, s.age, c.course_name
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
JOIN courses c ON e.course_id = c.course_id
ORDER BY c.course_name ASC;