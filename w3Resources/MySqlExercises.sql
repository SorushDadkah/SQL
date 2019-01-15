--MySQL Exercises
--Basic SELECT statement
--1.
SELECT 
    first_name AS "First Name", 
    last_name  AS "Last Name"
FROM employees;

--2.
SELECT DISTINCT(department_id)
FROM employees;

--3.
SELECT *
FROM employees
ORDER BY first_name DESC;

--4.
SELECT first_name, last_name, salary, salary * .15 AS PF
FROM employees;

--5.
SELECT employee_id, first_name, last_name, salary
FROM employees
ORDER BY salary;

--6.
SELECT SUM(salary)
FROM employees;

--7.
SELECT MAX(salary), MIN(salary)
FROM employees;

--8.
SELECT AVG(salary), COUNT(employee_id)
FROM employees;

--9.
SELECT COUNT(employee_id)
FROM employees;

--10.
SELECT COUNT(job_id)
FROM employees;

--11.
SELECT UPPER(first_name)
FROM employees;

--12.
SELECT SUBSTRING(first_name, 1, 3)
FROM employees;

--13.
SELECT  171*214+625;

--14.
SELECT CONCAT(first_name, " ", last_name)
FROM employees;

--15.
SELECT REPLACE(first_name, ' ', '')
FROM employees;
--
SELECT TRIM(first_name)
FROM employees;

--16.
SELECT first_name, last_name, LENGTH(first_name) + LENGTH(last_name) AS "LENGTH OF NAME"
FROM employees;

--17.
SELECT first_name
FROM employees
WHERE first_name LIKE '%[0-9]%';

--18.
SELECT DISTINCT *
FROM employees
LIMIT 10;

--19.
SELECT DISTINCT *, ROUND(salar/12, 2) AS "Monthly Salary"
FROM employees


--Restricting and Sorting Data
--1.
SELECT CONCAT(first_name, '', last_name) AS "Employee", salary
FROM employees
WHERE salary NOT BETWEEN(10000 AND 15000);

--2.
SELECT CONCAT(first_name, '', last_name) AS "Employee", department_id
FROM employees
WHERE department_id IN(30, 100)
ORDER BY department_id;

--3. 
SELECT CONCAT(first_name, '', last_name) AS "Employee", salary
FROM employees
WHERE salary NOT BETWEEN(10000 AND 15000) 
AND department_id NOT IN( 30, 100);

--4.
SELECT CONCAT(first_name, '', last_name) AS "Employee", hire_date
FROM employees
WHERE YEAR(hire_date) LIKE '1987%';

--5.
SELECT first_name
FROM employees
WHERE first_name LIKE '%b%'
AND first_name LIKE '%c%'

--6.
SELECT last_name, job_id, salary
FROM employees
WHERE job_id IN("programmer", "st_clerk")
AND salary NOT IN(4500, 10000, 15000);

--7.
SELECT last_name
FROM employees
WHERE last_name LIKE '______';

--8.
SELECT last_name
FROM employees
WHERE last_name LIKE '__e%';

--9.
SELECT DISTINCT job_id
FROM employees

--10.
SELECT CONCAT(first_name, ' ', last_name) AS "Employee", salary, salary * .15
FROM employees

--11.
SELECT *
FROM employees
WHERE last_name IN('BLAKE', 'SCOTT', 'KING', 'FORD');


--Aggregate Functions and Group by
--1.
SELECT COUNT(DISTINCT job_id)
FROM employees;

--2.
SELECT SUM(salary)
FROM employees;

--3.
SELECT MIN(salary)
FROM employees;

--4.
SELECT MAX(salary)
FROM employees
WHERE job_id = 'IT_PROG';

--5.
SELECT AVG(salary), COUNT(*)
FROM employees
WHERE department = 90;

--6.
SELECT first_name, last_name, MIN(salary), MAX(salary), SUM(salary), AVG(salary)
FROM employees;

--7.
SELECT job_id, COUNT(*)
FROM employees
GROUP BY job_id;

--8.
SELECT MAX(salary) - MIN(salary) AS "difference in salary"
FROM employees;

--9.
SELECT manager_id, MIN(salary)
FROM employees
GROUP BY manager_id;

--10.
SELECT department_id, SUM(salary)
FROM employees
GROUP BY department_id;

--11.
SELECT AVG(salary), job_id
FROM employees
WHERE job_id != "IT_PROG"
GROUP BY job_id;

--12.
SELECT job_id, SUM(salary), MAX(salary), MIN(salary), AVG(salary)
FROM employees
WHERE department_id = 90
GROUP BY job_id;

--13.
SELECT job_id, MAX(salary)
FROM employees
GROUP BY job_id
HAVING MAX(salary) >= 4000;

--14.
SELECT AVG(salary), job_id
FROM employees
GROUP BY department_id
HAVING COUNT(employee_id) > 10;


--Subquery
--1.
SELECT first_name, last_name, salary
FROM employees
WHERE salary > (SELECT salary
                FROM employees
                WHERE last_name = 'Bull'
                );

--2.
SELECT first_name, last_name
FROM employees
WHERE department_id IN (SELECT department_id
                        FROM department
                        WHERE department_name = 'IT');

--3.
SELECT first_name, last_name
FROM employees
WHERE manager_id 
IN (SELECT manager_id  FROM departments WHERE location_id 
IN (SELECT location_id FROM locations   WHERE country_id='US' ));

--4.
SELECT first_name, last_name
FROM employees
WHERE employee_id
IN (SELECT manager_id FROM employee )

--5.
SELECT first_name, last_name
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees)

--6.
SELECT first_name, last_name, salary
FROM employees
WHERE salary 
IN (SELECT MIN(salary) FROM employees WHERE job_id)
IN (SELECT job_id  )

--7.Write a query to find the name (first_name, last_name), and salary of the employees who earns more than the average salary 
--  and works in any of the IT departments.
SELECT CONCAT(first_name, ' ', last_name) AS Employee, salary
FROM employees
WHERE department_id IN (SELECT department_id
                        FROM departments
                        WHERE department_id LIKE 'IT%')
AND salary > (SELECT AVG(salary) 
              FROM employees);

--8. Write a query to find the name (first_name, last_name), and salary of the employees who earns more than the earning of Mr. Bell.
SELECT CONCAT(first_name, ' ', last_name) AS Employee, salary
FROM employees
WHERE salary > (SELECT salary
                FROM employees
                WHERE last_name = 'Bell')
ORDER BY last_name; 

--9. Write a query to find the name (first_name, last_name), and salary
--   of the employees who earn the same salary as the minimum salary for all departments. 
SELECT CONCAT(first_name, ' ', last_name) AS Employee, salary
FROM employees
WHERE salary = (SELECT MIN(salary)
                FROM employees);

--10. Write a query to find the name (first_name, last_name), and salary
--    of the employees whose salary is greater than the average salary of all departments.
SELECT CONCAT(first_name, ' ', last_name) AS Employee, salary
FROM employees
WHERE salary > ALL (SELECT AVG(salary)
                    FROM employees
                    GROUP BY department_id);

--11. Write a query to find the name (first_name, last_name) and salary of the employees
--    who earn a salary that is higher than the salary of all the Shipping Clerk (JOB_ID = 'SH_CLERK').
--    Sort the results of the salary of the lowest to highest.
SELECT CONCAT(first_name, ' ', last_name) AS Employee, salary
FROM employees
WHERE salary > (SELECT MAX(salary)
                FROM employees 
                WHERE job_id = 'SH_CLERK') 
ORDER BY salary;

--12. Write a query to find the name (first_name, last_name) of the employees who are not supervisors.
SELECT CONCAT(first_name, ' ', last_name) AS Employee
FROM employees
WHERE employee_id NOT IN (SELECT manager_id FROM employees);

--13. Write a query to display the employee ID, first name, last name, and department names of all employees.
SELECT e.employee_id, CONCAT(e.first_name, ' ', e.last_name) AS Employee, d.department_name
FROM employees e 
LEFT JOIN departments d ON e.department_id = d.department_id;

--14. Write a query to display the employee ID, first name, last name, salary
--    of all employees whose salary is above average for their departments.
SELECT A.employee_id, CONCAT(A.first_name, ' ', A.last_name) AS Employee, A.salary
FROM employees A
LEFT JOIN ( SELECT AVG(salary), department_id
            FROM employees
            GROUP BY department_id 
          ) AS B
ON A.department_id = B.department_id
WHERE A.salary > B.avg_salary;

--15. Write a query to fetch even numbered records from employees table.
SELECT * 
FROM employees 
WHERE employee_id % 2 != 0;

--16. Write a query to find the 5th maximum salary in the employees table.
SELECT DISTINCT salary
FROM employees
ORDER BY Salary DESC
LIMIT 1, 4;

--17. Write a query to find the 4th minimum salary in the employees table.
SELECT DISTINCT salary
FROM employees
ORDER BY Salary
LIMIT 1, 4;

--18. Write a query to select last 10 records from a table.
SELECT *
FROM (SELECT * 
      FROM employees 
      ORDER BY employee_id DESC 
      LIMIT 10) b 
ORDER BY employee_id ASC;

--OR
--without subquery

SELECT *
FROM employees 
ORDER BY employee_id DESC 
LIMIT 10;

--19. Write a query to list the department ID and name of all the departments where no employee is working.
SELECT *
FROM departments 
WHERE department_id 
NOT IN (SELECT department_id FROM employees);

--OR

SELECT d.department_id, d.department_name FROM departments d
LEFT JOIN employees e 
ON d.department_id = e.department_id
WHERE e.employee_id IS NULL;

--20. Write a query to get 3 maximum salaries.
SELECT DISTINCT salary
FROM employees
ORDER BY salary DESC
LIMIT 3;

--21. Write a query to get 3 min salaries.
SELECT DISTINCT salary
FROM employees
ORDER BY salary
LIMIT 3;

--22. Write a query to get nth maximum salaries of employees.
SELECT *
FROM employees
ORDER BY salary DESC
LIMIT n-1, 1;


--Joins
--1.
SELECT l.location_id, l.street_address, city, l.state_province, c.country_name
FROM locations l
JOIN countries c
ON l.country_id = c.country_id

--2. 
SELECT CONCAT(first_name, ' ', last_name) AS "Name", department_id
FROM employees
JOIN departments
USING (department_id);

--3.
SELECT CONCAT(e.first_name, ' ', e.last_name) AS "Name", e.job_id, e.departmentid
FROM employees e
JOIN departments d ON e.department_id = d.department_id 
JOIN locations l   ON d.location_id = l.location_id
WHERE l.city = 'London';

--4.
SELECT e.employee_id, e.last_name, m.manager_id, m.last_name
FROM employees e
JOIN employees m ON e.manager_id = m.employee_id;

--5.
SELECT CONCAT(e.first_name, ' ', e.last_name) AS "Name", hire_date
FROM employees e
JOIN employees davies
ON davies.last_name = 'Jones'
WHERE davies.hire_date > e.hire_date;

--6.
SELECT d.deptartment_name, COUNT(e.employee_id)
FROM employees e
JOIN department d ON e.department_id = e.department_id
GROUP BY d.department_name

--7.
SELECT e.employee_id, e.job_id, (j.end_date-j.start_date)
FROM employees e
JOIN job_history j USING employee_id
WHERE department_id = 90;

--8.
SELECT e.department_id, e.department_name, d.first_name
FROM employees e
JOIN department d USING manager_id

--9.
SELECT d.department_name, e.first_name, e.last_name, l.city
FROM employees e
JOIN departments ON e.manager_id = d.manager_id
AND  d.location_id = l.location_id

--10.
SELECT j.job_title, AVG(e.salary)
FROM employees e
JOIN jobs j ON e.job_id = j.job_id
GROUP BY j.job_title

--11.
SELECT j.job_title, e.first_name, e.last_name, (e.salary - j.min_salary)
FROM employees e
JOIN jobs j USING job_id

--12.
SELECT j.*
FROM jobs_history j
JOIN employees e USING employee_id
WHERE e.salary > 10000;

--14.
SELECT e.first_name, e.last_name, e.hire_date, e.salary
FROM employees e
JOIN departments d ON e.manager_id = d.manager_id
WHERE DATEDIFF(now(), e.hire_date) / 365 > 15;


--Date and Time functions
--1. Write a query to display the first day of the month (in datetime format) three months before the current month.
SELECT TIMESTAMP(CURDATE() - INTERVAL 3 MONTH - INTERVAL 7 DAY);

--2. Write a query to display the last day of the month (in datetime format) three months before the current month.
SELECT TIMESTAMP(CURDATE() - INTERVAL 2 MONTH - INTERVAL 1 DAY);

--3. Write a query to get the distinct Mondays from hire_date in employees tables.
SELECT DISTINCT hire_date
FROM employees
WHERE WEEKDAY(hire_date) = 0;

--4. Write a query to get the first day of the current year.
SELECT DATE_FORMAT(CURDATE(), '01-01-%Y');
--OR
SELECT MAKEDATE(YEAR(NOW()),1);

--5. Write a query to get the last day of the current year.
SELECT LAST_DAY(DATE_ADD(NOW(), INTERVAL 11 MONTH));
--OR
SELECT DATE_FORMAT(CURDATE(), '12-31-%Y');
--OR
SELECT MAKEDATE(YEAR(NOW()),365);

--6. Write a query to calculate the age in year.
SELECT YEAR(CURRENT_TIMESTAMP) - YEAR("1990-01-20");

--7. Write a query to get the current date in the following format.
SELECT DATE_FORMAT(CURDATE(), '%M %D, %Y');

--8. Write a query to get the current date in Thursday September 2014 format. 
SELECT DATE_FORMAT(CURDATE(), '%W %M, %Y');

--9. Write a query to extract the year from the current date.
SELECT YEAR(NOW());

--10. Write a query to get the DATE value from a given day (number in N). 
--Sample days: 730677
--Output : 2000-07-11
SELECT FROM_DAYS('730677');

--11. Write a query to get the first name and hire date from employees table where hire date between '1987-06-01' and '1987-07-30'.
SELECT FIRST_NAME, HIREE_DATE
FROM employees
WHERE HIRE_DATE BETWEEN '1987-06-01' AND '1987-07-30';

--12. Write a query to display the current date in the following format.
--Sample output : Thursday 4th September 2014 00:00:00
SELECT DATE_FORMAT(NOW(), '%W %D %M %Y %T %p');

--13.  Write a query to display the current date in the following format.
--Sample output: 05/09/2014
SELECT DATE_FORMAT(NOW(), '%m/%d/%Y');

--14. Write a query to display the current date in the following format.
--Sample output: 12:00 AM Sep 5, 2014
SELECT DATE_FORMAT(NOW(), '%H:%i %p %b %e, %Y');

--15. Write a query to get the firstname, lastname who joined in the month of June.
SELECT FIRST_NAME, LAST_NAME
FROM employees
WHERE MONTH(HIRE_DATE) = 6;

--16. Write a query to get the years in which more than 10 employees joined. 
SELECT YEAR(HIRE_DATE)
FROM employees 
GROUP BY year(HIRE_DATE) 
HAVING COUNT(EMPLOYEE_ID) > 10;

--17. Write a query to get first name of employees who joined in 1987.
SELECT FIRST_NAME
FROM employees
WHERE YEAR(HIRE_DATE) = 1987;

--18. Write a query to get department name, manager name, and salary of the manager for all managers whose experience is more than 5 years.
SELECT d.department_name, CONCAT(e.first_name, ' ', e.last_name) AS Manager, e.salary
FROM departments d
JOIN employees e ON d.manager_id = e.manager_id
GROUP BY HIRE_DATE
WHERE TIMESTAMPDIFF(YEAR, e.HIRE_DATE, CURDATE()) > 5;

--19. Write a query to get employee ID, last name, and date of first salary of the employees.
SELECT e.employee_id, e.last_name, hire_date, LAST_DAY(hire_date)
FROM employees;

--20. Write a query to get first name, hire date and experience of the employees.
SELECT first_name, hire_date, DATEDIFF(NOW(), OrderDate) / 365 AS "Years of Experience"
FROM employees;  --returns years and months
--OR
SELECT first_name, hire_date, (YEAR(NOW()) - YEAR(hire_date)) AS "Years of Experience"
FROM employees;  --returns years only
--OR
SELECT first_name, hire_date, TIMESTAMPDIFF(YEAR, hire_date, NOW())
FROM employees;  --returns years only

--21. Write a query to get the department ID, year, and number of employees joined.
SELECT department_id, YEAR(hire_date) AS 'Year Hired', COUNT(employee_id) AS "Hired Employees"
FROM employees
GROUP BY YEAR(hire_date), department_id
ORDER BY department_id;


--Strings
--1.Write a query to get the job_id and related employee's id.
SELECT job_id, employee_id AS 'Employee ID'
FROM employees
GROUP BY job_id;

--2. Write a query to update the portion of the phone_number in the employees table, within the phone number the substring '124' will be replaced by '999'.
UPDATE employees
SET phone_number = REPLACE(phone_number, '124', '999');

--3. Write a query to get the details of the employees where the length of the first name greater than or equal to 8.
SELECT *
FROM employees
WHERE LENGTH(first_name) >= 8;

--4. Write a query to display leading zeros before maximum and minimum salary.
SELECT job_id, LPAD( max_salary, 7, '0') 'Max Salary', LPAD( min_salary, 7, '0') 'Min Salary' 
FROM jobs;

--5. Write a query to append '@example.com' to email field.
UPDATE employees
SET email = CONCAT(email, '@example.com');

--6. Write a query to get the employee id, first name and hire month.
SELECT employee_id, first_name, MONTH(hire_date)
FROM employees;

--7. Write a query to get the employee id, email id (discard the last three characters).
SELECT employee_id, REVERSE(SUBSTR(REVERSE(email), 4)) AS "Email ID"
FROM employees;

--8. Write a query to find all employees where first names are in upper case.
SELECT * 
FROM employees
WHERE first_name = BINARY UPPER(first_name);

--9. Write a query to extract the last 4 character of phone numbers.
SELECT RIGHT(phone_number, 4)
FROM employees;

--10. Write a query to get the last word of the street address.
SELECT location_id, street_address, SUBSTRING_INDEX(street_address, " ", -1) AS 'Last--word-of-street_address'

--11. Write a query to get the locations that have minimum street length.
SELECT * 
FROM locations
WHERE LENGTH(street_address) <= (SELECT MIN(LENGTH(street_address)) 
                                 FROM locations);

--12. Write a query to display the first word from those job titles which contains more than one words.
SELECT SUBSTRING_INDEX(job_title, " ", 1)
FROM jobs
WHERE SUBSTRING_INDEX(job_title, " ", 1);

SELECT job_title, SUBSTR(job_title,1, INSTR(job_title, ' ')-1)
FROM jobs;

--13. Write a query to display the length of first name for employees where last name contain character 'c' after 2nd position.
SELECT LENGTH(first_name)
FROM employees
WHERE last_name ILIKE '__%C%'; --ILIKE is not case-sensitive 
--OR
SELECT first_name, last_name FROM employees WHERE INSTR(last_name,'c') > 2;

--14. Write a query that displays the first name and the length of the first name for all employees whose name starts with the 
--    letters 'A', 'J' or 'M'. Give each column an appropriate label. Sort the results by the employees' first names.
SELECT first_name AS "Name", LENGTH(first_name) AS "Length"
FROM employees
WHERE first_name LIKE 'J%'
OR first_name LIKE 'M%'
OR first_name LIKE 'A%'
ORDER BY first_name;

--15. Write a query to display the first name and salary for all employees. Format the salary to be 10 characters long, 
--    LEFT-padded with the $ symbol. Label the column SALARY.
SELECT first_name, LPAD(salary, 10, '$') AS SALARY
FROM employees;

--16. Write a query to display the first eight characters of the employees' first names and indicates the amounts of their 
--    salaries with '$' sign. Each '$' sign signifies a thousand dollars. Sort the data in descending order of salary.
SELECT left(first_name, 8), REPEAT('$', FLOOR(salary/1000)) AS 'SALARY($)', salary
FROM employees
ORDER BY salary DESC;

--17. Write a query to display the employees with their code, first name, last name and hire date who hired either on
--    seventh day of any month or seventh month in any year.
SELECT employee_id, first_name, last_name, hire_date
FROM employees
WHERE DAY(HIRE_DATE) = 7
OR MONTH(HIRE_DATE)  = 7;