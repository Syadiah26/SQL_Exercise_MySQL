-- UNION ALL :combines the rows without removing duplicates
-- UNION : combines the rows and it removes any duplicates
-- In UNION the data types of columns must match (misal varchar gabisa match sama integer)
-- banyak kolom yang bakal digabungkan harus sama

SELECT 
	order_id,
    order_date,
    'Active' AS status
FROM orders
WHERE order_date >= '2019-01-01'
UNION
SELECT 
	order_id,
    order_date,
    'Archived' AS status
FROM orders
WHERE order_date < '2019-01-01';

-- contoh lain
SELECT first_name AS full_name
FROM customers
UNION
SELECT name
FROM shippers;

-- EXERCISE
SELECT
	customer_id, 
    first_name, 
    points,
    'Bronze' AS type
FROM customers
WHERE points < 2000
UNION
SELECT
	customer_id, 
    first_name, 
    points,
    'Silver' AS type
FROM customers
WHERE points BETWEEN 2000 AND 3000
UNION
SELECT
	customer_id, 
    first_name, 
    points,
    'Gold' AS type
FROM customers
WHERE points > 3000
ORDER BY first_name;

USE sql_store;
SELECT first_name, last_name
FROM customers
UNION -- or misal pake UNION ALL
SELECT first_name, last_name
FROM sql_hr.employees;

