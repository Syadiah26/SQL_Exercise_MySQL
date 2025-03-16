-- Aggregate Functions
-- COUNT(*) 
	-- returns the number of rows in a table
    -- find the total number of customers
SELECT COUNT(*) AS total_customers
FROM customers;

-- COUNT (column name) (NULLs are ignored)
SELECT COUNT(phone) AS count_of_phone
FROM customers;

-- SUM()
	-- returns the sum of all values in a column
	-- works only with numeric columns
    -- NULLs are treated as 0
SELECT SUM(quantity) AS total_quantity
FROM order_items;

-- AVG()
	-- returns the average of values in a column
    -- work only with numeric columns
    -- NULLs are ignored
SELECT AVG(points) AS avg_points
FROM customers;

-- MIN()
	-- returns the minimum values in a column
    -- NULLs are ignored
SELECT MIN(points) AS min_poins
FROM customers;
    
-- MAX()
	-- return the maximum values in a column
SELECT MAX(points) AS max_poins
FROM customers;

-- find the earliest and latest order dates
SELECT 
	MIN(order_date) AS earliest_order_date, 
	MAX(order_date) AS latest_order_date
FROM orders;

-- misal mau tau siapa customer yang punya point tertinggi
SELECT first_name
FROM customers
WHERE points IN 
				(SELECT MAX(points)
				FROM customers);