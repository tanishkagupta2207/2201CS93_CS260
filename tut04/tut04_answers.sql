-- General Instructions
-- 1.	The .sql files are run automatically, so please ensure that there are no syntax errors in the file. If we are unable to run your file, you get an automatic reduction to 0 marks.
-- Comment in MYSQL 

-- 1
SELECT first_name, last_name
FROM employees;
-- 2
SELECT department_name, location
FROM departments;
-- 3
SELECT project_name, budget
FROM projects;
-- 4
SELECT e.first_name, e.last_name, e.salary
FROM employees e
JOIN departments d ON e.department_id = d.department_id
WHERE d.department_name = 'Engineering';
-- 5
SELECT project_name, start_date
FROM projects;
-- 6
SELECT e.first_name, e.last_name, d.department_name
FROM employees e
JOIN departments d ON e.department_id = d.department_id;
-- 7
SELECT project_name
FROM projects
WHERE budget > 90000;
-- 8
SELECT SUM(budget) AS total_budget
FROM projects;
-- 9
SELECT first_name, last_name, salary
FROM employees
WHERE salary > 60000;
-- 10
SELECT project_name, end_date
FROM projects;
-- 11
SELECT department_name, location
FROM departments
WHERE location IN ('New Delhi', 'Noida', 'Gurgaon');
-- 12
SELECT AVG(salary) AS average_salary
FROM employees;
-- 13
SELECT e.first_name, e.last_name, d.department_name
FROM employees e
JOIN departments d ON e.department_id = d.department_id
WHERE d.department_name = 'Finance';
-- 14
SELECT project_name
FROM projects
WHERE budget BETWEEN 70000 AND 100000;
-- 15
SELECT d.department_name, COUNT(e.emp_id) AS employee_count
FROM departments d
LEFT JOIN employees e ON d.department_id = e.department_id
GROUP BY d.department_name;