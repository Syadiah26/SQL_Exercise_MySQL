-- arithmetic expression
SELECT 
	last_name, 
    first_name, 
    points,  
    (points + 10) * 100
FROM customers;

-- penggunaan ALIAS (AS)
SELECT 
	last_name, 
    first_name, 
    points,  
    (points + 10) * 100 AS discount_factor
FROM customers;

-- dapat menggunakan tanda " " atau '' untuk penamaan dengan spasi
SELECT 
	last_name, 
    first_name, 
    points,  
    (points + 10) * 100 AS 'discount factor'
FROM customers;

-- UPDATE record customer id 1 state nya diganti Virginia
UPDATE `sql_store`.`customers` 
SET `state` = 'VA' 
WHERE (`customer_id` = '1');

-- get unique data
SELECT DISTINCT state
FROM customers;

-- EXERCISE
-- return all the product
-- name
-- unit price
-- new price (unit price *1.1)

SELECT *
FROM products;

SELECT name, unit_price, unit_price * 1.1 AS new_price
FROM products;