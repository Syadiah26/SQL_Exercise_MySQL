USE sql_store;

SELECT *
FROM customers
WHERE state IN ('VA', 'GA', 'FL');

SELECT *
FROM customers
WHERE state NOT IN ('VA', 'GA', 'FL');

-- EXERCISE
-- Return products with
--  quantity in stock equal to 49, 38, 72

SELECT *
FROM products
WHERE quantity_in_stock IN (49, 38, 72);

-- BETWEEN
SELECT *
FROM customers
-- WHERE points >= 1000 AND points <= 3000;  -- gak efisien
WHERE points BETWEEN 1000 AND 3000;

-- EXERCISE
-- Return customers born between 1/1/1990 and 1/1/2000
SELECT * 
FROM customers
WHERE birth_date BETWEEN '1990-01-01' AND '2000-01-01';

SELECT *
FROM orders
WHERE customer_id IN ( 
						SELECT customer_id
                        FROM customers
                        WHERE points > 2000);