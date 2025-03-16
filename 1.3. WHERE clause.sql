-- select customer yang punya point greater than 3000
SELECT *
FROM customers
WHERE points > 3000;

-- operator: <, <=, >, >=, =, !=, <>
-- penggunaan != sama dengan <> (?)
SELECT *
FROM customers
-- WHERE state = 'VA';
-- WHERE state != 'VA';
WHERE state <> 'VA';

-- date, date actually not string
SELECT *
FROM customers
WHERE birth_date > '1990-01-01'; -- default fromate date in MySQL

-- EXERCISE
-- Get the orders placed this year
SELECT *
FROM orders
WHERE order_date >= '2019-01-01';