-- Retrieve data from tables
1.
SELECT * FROM salesman;

2.
SELECT "This is SQL Exercise, Practice and Solution";

3.
SELECT 5, 10, 15;

4.
SELECT 10 + 15;

5.
SELECT 1 + 2 - 3 * 4;

6.
SELECT name, commission
FROM salesman;

7.
SELECT ord_date, salesman_id, ord_no, purch_amt
FROM orders;

8.
SELECT DISTINCT salesman_id
FROM orders;

9.
SELECT name, city
FROM salesman
WHERE city = 'Paris'; 

10.
SELECT *
FROM customer
WHERE grade = 200;

11.
SELECT ord_no, ord_date, purch_amt
FROM orders
WHERE salesman_id = 5001;

12.
SELECT *
FROM nobel_win
WHERE YEAR = 1970;

13.
SELECT winner
FROM nobel_win
WHERE year = 1971
AND subject = 'Literature';

14.
SELECT year, subject
FROM nobel_win
WHERE winner = 'Dennis Gabor';

15.
SELECT winner
FROM nobel_win
WHERE year >= 1950
AND subject = 'Physics';

16.
SELECT year, subject, winner, country
FROM nobel_win
WHERE subject = 'Chemistry'
AND year BETWEEN 1965 AND 1975;

17.## question makes no sense
SELECT *
FROM nobel_win
WHERE category = 'Prime Minister'
AND year > 1972;

18.
SELECT *
FROM nobel_win
WHERE winner LIKE 'Louis%';

19.
SELECT winner
FROM nobel_win
WHERE subject = 'Physics' AND year = 1970 
OR subject = 'Economics' AND year = 1971;

20.
SELECT winner
FROM nobel_win
WHERE year = 1970
AND  subject NOT IN('Physiology', 'Economics');

21.## use union -redo question
SELECT winner
FROM nobel_win
WHERE category = 'Physiology' AND year < 1971
OR category = 'Peace' AND year >= 1974;

22.
SELECT *
FROM nobel_win
WHERE winner = 'Johannes Georg Bednorz';

23.
SELECT *
FROM nobel_win
WHERE subject NOT LIKE 'P%'
ORDER BY year DESC, winner;

24.Write a SQL query to find all the details of 1970 winners by the ordered to subject and winner name; but the list contain the subject Economics and Chemistry at last.
SELECT *
FROM nobel_win
WHERE year = 1970
AND subject NOT IN('Economics', 'Chemistry')
ORDER BY subject, winner
UNION
SELECT *
FROM nobel_win
WHERE year = 1970
AND subject IN('Economics', 'Chemistry');


SELECT * FROM nobel_win WHERE year=1970 ORDER BY 
CASE WHEN subject IN ('Economics','Chemistry') THEN 1
ELSE 0 END ASC, 
 subject, winner;


25.
SELECT *
FROM item_mast
WHERE pro_price BETWEEN 200 AND 600;

26.
SELECT AVG(pro_price)
FROM item_mast
WHERE pro_com = 16;

27.## doesnt specify to make an alias but my answer is correct
SELECT pro_name, pro_price
FROM item_mast;

28.
SELECT pro_name, pro_price
FROM item_mast
WHERE pro_price >= 250
ORDER BY pro_price DESC, pro_name;

29.
SELECT AVG(pro_price), pro_com
FROM item_mast
GROUP BY pro_com;

30.
SELECT pro_name, MIN(pro_price)
FROM item_mast;

31.
SELECT DISTINCT emp_lname
FROM emp_details;

32.
SELECT *
FROM emp_details
WHERE emp_lname = 'Snares';

33.
SELECT *
FROM empy_details
WHERE emp_dept = 57;

===================

BOOLEAN AND RELATIONAL OPERATORS

1.
SELECT *
FROM customer
WHERE grade > 100;

2.
SELECT *
FROM customer
WHERE city = 'New York'
AND grade > 100;

3.
SELECT *
FROM customer
WHERE city = 'New York'
OR grade > 100;

4.
SELECT *
FROM customer
WHERE city = 'New York'
OR grade <= 100;

5.
SELECT *
FROM customer
WHERE city != 'New York'
AND grade < 100;

6.## check NOT operator
SELECT *
FROM orders
WHERE ord_date <> '2012-09-10' AND salesman_id < 505
OR purch_amt < 1000.00;

7.
SELECT *
FROM salesman
WHERE (commission > .10 AND commission < .12)

8.### very confusing
SELECT *
FROM orders
WHERE (purch_amt < 200 OR 
ord_date <= CONVERT(date, '2012-02-10') )
AND customer_id > 3009

9.
SELECT *
FROM orders
WHERE ord_date != '20120817'
OR customer_id <= 3005
AND purch_amt >= 1000

10.###NO IDEA ASK DANI
SELECT 

11.
SELECT *
FROM emp_details
WHERE emp_lname = 'Dosni' OR emp_lname = 
'Mardy';

12.
SELECY *
FROM emp_details
WHERE department IN(47, 63);

==========================

-- WILDCARD AND SPECIAL OPERATORS

1.
SELECT *
FROM salesman
WHERE city = 'Paris' OR city = 'Rome';

2.
SELECT *
FROM salesman
WHERE city = 'Paris' AND city = 'Rome';

3.
SELECT *
FROM salesman
WHERE city IN('Paris', 'Rome');

4.
SELECT *
FROM salesman
WHERE customer_id IN(3007, 3008, 3009);

5.
SELECT *
FROM salesman
WHERE commission BETWEEN 0.12 AND 0.14;

6.
SELECT *
FROM orders
WHERE purch_amt BETWEEN 500 AND 4000
AND NOT IN(948.5, 1983.43);

7.
SELECT *
FROM salesman
WHERE name LIKE '[A-K]%';

8.
SELECT *
FROM salesman
WHERE name NOT LIKE '[A-K]%';

9.
SELECT *
FROM customer
WHERE cust_name LIKE 'B%';

10.
SELECT *
FROM customer
WHERE '%n';

11.
SELECT *
FROM salesman
WHERE name LIKE 'N__I%';


===============

-- AGGREGATE FUNCTIONS

1.
SELECT SUM(purch_amt)
FROM orders;

2.
SELECT AVG(purch_amt)
FROM orders;

3.
SELECT COUNT(DISTINCT salesman_id)
FROM orders;

4.
SELECT COUNT(*)
FROM customer
WHERE cust_name IS NOT NULL;

5.
SELECT COUNT(*)
FROM customer
WHERE grade IS NOT NULL;
——————
SELECT COUNT(ALL grade)
FROM customer;

6.
SELECT MAX(purch_amt)
FROM orders;

7.
SELECT MIN(purch_amt)
FROM orders;

8.
SELECT city, MAX(grade)
FROM customer
GROUP BY city;

9.
SELECT customer_id, MAX(purch_amt)
FROM orders
GROUP BY customer_id;

10.
SELECT customer_id, ord_date, MAX(purch_amt)
FROM orders
GROUP BY customer_id, ord_date;

11.
SELECT salesman_id ,MAX(purch_amt)
FROM orders
WHERE ord_date = '2012-08-17'
GROUP BY salesman_id;

12.
SELECT customer_id, MAX(purch_amt), ord_date
FROM orders
WHERE purch_amt > 2000
GROUP BY ord_date, customer_id;

13. 
SELECT customer_id, MAX(purch_amt), ord_date
FROM orders
WHERE purch_amt BETWEEN 2000 AND 6000
GROUP BY customer_id, ord_date;

14.
SELECT customer_id, ord_date, MAX(purch_amt)
FROM orders
WHERE purch_amt IN(2000, 3000, 5760, 6000) 
GROUP BY customer_id, ord_date;

15.
SELECT customer_id, MAX(purch_amt)
FROM orders
WHERE customer_id BETWEEN 3002 AND 3007
GROUP BY customer_id;

16.## recheck if you can use two AND's 
SELECT customer_id, MAX(purch_amt)
FROM orders
WHERE customer_id BETWEEN 3002 AND 3007
AND purch_amt > 1000
GROUP BY customer_id;

-- 
16.
SELECT customer_id, MAX(purch_amt)
FROM orders
WHERE customer_id BETWEEN 3002 AND 3007
GROUP BY customer_id
HAVING MAX(purch_amt) > 1000;

17.
SELECT salesman_id, MAX(purch_amt)
FROM orders
WHERE salesman_id BETWEEN 5003 AND 5008
GROUP BY salesman_id;

18.
SELECT COUNT(*)
FROM orders
WHERE ord_date = '20120817';

19.
SELECT COUNT(*)
FROM salesman
WHERE city IS NOT NULL;

20.## redo
SELECT COUNT(*)
FROM orders

21.
SELECT AVG(pro_price) AS "Average Price" -- use [] instead of " " in MSS
FROM item_mast;

22.
SELECT COUNT(*) AS "Number of Products $350 and Over"
FROM item_mast
WHERE pro_price >= 350;

23.
SELECT AVG(pro_price) AS "Average Price", pro_com AS "Company ID"
FROM item_mast
GROUP BY pro_com 
-- you can't reference your alias in the GROUP BY statement in MSS
-- if using PostgreSQL then you may apply Alias Name such as, "Company ID"

24.
SELECT SUM(dpt_allotment)
FROM emp_department;

25.
SELECT COUNT(*), emp_dept
FROM emp_details
GROUP BY emp_dept;

=====================================

--FORMATTING QUERY OUTPUT

1.
SELECT salesman_id, [name], city, concat(commission * 100, ' %') AS Commission
FROM salesman;

2.
SELECT 'For ' + ord_date + ', there are ' + COUNT(ord_no) + ' orders.')
FROM orders
GROUP BY ord_date;

3.
SELECT *
FROM orders
ORDER BY ord_no;

4. 
SELECT *
FROM orders
ORDER BY ord_date DESC;

5.
SELECT *
FROM orders
ORDER BY ord_date, purch_amt DESC;

6.
SELECT *
FROM customer
ORDER BY customer_id;

7.
SELECT salesman_id, ord_date, MAX(purch_amt)
FROM orders
GROUP BY salesman_id, ord_date
ORDER BY salesman_id, ord_date;

8.
SELECT cust_name, city, grade
FROM customer
ORDER BY grade DESC;

9.
SELECT customer_id, COUNT(ord_no), SUM(purch_amt)
FROM orders
GROUP BY customer_id
ORDER BY ord_no DESC, purch_amt DESC;


=====================================

-- Query on Multiple Tables

1.
SELECT customer.cust_name AS Customer, salesman.name AS Salesman
FROM salesman
JOIN customer ON salesman.city = customer.city;

2.
SELECT customer.cust_name AS Customer, salesman.name AS Salesman
FROM customer
LEFT JOIN salesman ON customer.salesman_id = salesman.salesman_id;

3.
SELECT a.ord_no, b.cust_name, a.customer_id, c.salesman_id
FROM orders a
  JOIN customer b ON b.customer_id = a.customer_id
  JOIN salesman c ON b.salesman_id = c.salesman_id
WHERE b.city <> c.city

4.
SELECT orders.ord_no, customers.cust_name
FROM orders, customers
WHERE orders.customer_id = customer.customer_id

--OR

SELECT orders.ord_no, customers.cust_name
FROM orders
JOIN customers ON orders.customer_id = customer.customer_id

5.
SELECT o.ord_no, c.cust_name, c.grade
FROM orders o 
  JOIN customer c ON o.customer_id = c.customer_id
  JOIN salesman s ON c.salesman_id = s.salesman_id
WHERE c.grade IS NOT NULL
AND s.city IS NOT NULL;

6.
SELECT c.cust_name, c.city, c.grade, s.name AS Salesman, s.commission
FROM customer c
JOIN salesman s ON c.salesman_id = s.salesman_id
WHERE s.commission BETWEEN 0.12 AND 0.14;

7.
SELECT ord_no, cust_name, commission AS "Commission%", (purch_amt * commission) AS "Commission"
FROM salesman
  JOIN orders   ON orders.salesman_id = salesman.salesman_id
  JOIN customer ON orders.customer_id = customer.customer_id
WHERE customer.grade >= 200 
AND customer.salesman_id IS NOT NULL;

===============================

--SQL JOINS