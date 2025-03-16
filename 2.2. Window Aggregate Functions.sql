-- Window Aggregate Function
	-- USE CASE:
		-- Overall analysis
        	-- Total per group analysis
        	-- Part-to-whole analysis
        	-- Comparison analysis (average and extreme (lowest/highest)
        	-- Identify duplicates
        	-- Outlier detection
        	-- Running total
        	-- Rolling total
        	-- Moving average

-- COUNT() for all data types
-- MIN(), MAX(), AVG(), SUM() just for the numeric values
-- Cara mengubah data type: misal integer ke float
	-- CAST (nama kolom AS FLOAT)
    -- Handling the NULL become zero if the NULLs means ZERO:
		-- COALESCE(nama kolom, 0)


-- COUNT(*): Returns the number of rows within a window, sensitive to the NULL value
-- COUNT(*): counts all the rows in the table, regardless of whether any values is NULL
-- COUNT(Column): counts the number of non-NULL values in the column
-- COUNT(*) EQUALS TO COUNT(1)
-- counts all the rows in the table, including the duplicates, not the unique values
-- COUNT | USE CASE
	-- 1. Overall Analysis
    -- 2. Category Analysis
    -- 3. Quality Checks: Identify NULLs
    -- 4. Quality Checks: Identify Duplicates

-- Find the total numbers of orders for each customers
SELECT 
	order_id,
    order_date,
    customer_id,
    COUNT(*) OVER() AS total_orders,
    COUNT(*) OVER(PARTITION BY customer_id) AS total_orders_by_customers
FROM orders;

-- Find the total numbers of  customers
-- Additionally provide all customers details

SELECT 
	*,
	COUNT(*) OVER() AS total_customers
FROM customers;

-- Find the total numbers of phone for the customers
-- ini bisa dipake buat ngecek ada NULL apa ngga kalo datanya gede (liat dari perbedaan total customer dan total tiap columnnnya)
SELECT
	*,
    COUNT(*) OVER() AS total_customers_stars,
    COUNT(1) OVER() AS total_customers_one,
    COUNT(phone) OVER() AS total_phones
FROM customers;


-- DATA QUALITY ISSUE
-- duplicates leads to inaccuracies in analysis
-- COUNT() can be used to identify duplicates

-- check whether the table 'orders' containts any duplicate rows
SELECT
	order_id,
    COUNT(*) OVER (PARTITION BY order_id) AS check_pk -- divides the data by the Primary Key
 FROM orders;
 
 SELECT *
 FROM
		(SELECT
				order_id,
				COUNT(*) OVER (PARTITION BY order_id) AS check_pk -- divides the data by the Primary Key
		FROM order_items) t
WHERE check_pk > 1;


-- SUM()
	-- returns the sum of values within a window
    -- use case: comparison analysis
    
-- Find the total sales across all orders and total sales of each product, additionally provide details such as order_id dan product_id
SELECT 
	*,
    quantity*unit_price AS sales,
    SUM(quantity*unit_price) OVER() AS total_sales,
    SUM(quantity*unit_price) OVER(PARTITION BY product_id) AS total_sales_by_product
FROM order_items;

-- Comparison use case
-- Find the percentage contribution of each product's sales to the total sales
SELECT 
		order_id,
		product_id,
		quantity*unit_price AS sales,
		SUM(quantity*unit_price) OVER () AS total_sales,
		quantity*unit_price/SUM(quantity*unit_price) OVER ()*100 AS percentage_contribution,
		round(quantity*unit_price/SUM(quantity*unit_price) OVER ()*100, 2) AS percentage_contribution_2dec
FROM order_items;
	
    
-- AVG()
-- returns the average of values within a window
-- NULL wil be ignored in calculation
-- NULL means ZERO

-- How to handling the NULLs? Check it out!
	-- AVG (COALESCE (quantity*unit_price, 0)) OVER (PARTITION BY product_id)
    
-- Find the average sales across all orders and the average sales for each product
-- Additionally provide details such as Order ID and Order Date
SELECT 
		oi.order_id,
		o.order_date,
        oi.product_id,
        quantity*unit_price AS sales,
        round(AVG (COALESCE(quantity*unit_price, 0)) OVER (),2) AS average_sales,
        round(AVG (COALESCE(quantity*unit_price, 0)) OVER (PARTITION BY product_id),2) AS average_sales
FROM order_items oi
JOIN orders o USING (order_id);

-- Find all orders where sales are higher than the average sales across all orders
SELECT *
FROM (	
		SELECT 
				oi.order_id,
				o.order_date,
				oi.product_id,
				quantity*unit_price AS sales,
				round(AVG (COALESCE(quantity*unit_price, 0)) OVER (),2) AS average_sales
		FROM order_items oi
		JOIN orders o USING (order_id))t
WHERE  sales > average_sales;


-- MIN/MAX
	-- MIN(): returns the lowest value within a window
    -- MAX(): returns the highest value within a window
	-- NULL will be ignored, so it is must be handled with COALESCE
    
-- find the highest and lowest sales of all orders
-- find the highest and lowest sales for each product
-- Additionally provide details such as order_id and order_date
SELECT 
	oi.order_id,
    o.order_date,
    oi.product_id,
    quantity*unit_price AS sales,
    MAX(COALESCE(quantity*unit_price,0)) OVER() AS highest_sales,
	MAX(COALESCE(quantity*unit_price,0)) OVER(PARTITION BY product_id) AS highest_sales_by_product,
    MIN(COALESCE(quantity*unit_price,0)) OVER() AS lowest_sales,
	MIN(COALESCE(quantity*unit_price,0)) OVER(PARTITION BY product_id) AS lowest_sales_by_product
FROM order_items oi
JOIN orders o USING (order_id);

-- Show the employees with the highest salaries
SELECT *
FROM
    (SELECT 
		*,
		MAX(COALESCE(salary,0)) OVER() AS highest_salary
	FROM employees)t
WHERE salary = highest_salary;

-- Find the deviation of each sale from both the minimum and maximum sales amount
SELECT 
	oi.order_id,
    o.order_date,
    oi.product_id,
    quantity*unit_price AS sales,
    MAX(COALESCE(quantity*unit_price,0)) OVER() AS highest_sales,
    MIN(COALESCE(quantity*unit_price,0)) OVER() AS lowest_sales,
    (quantity*unit_price) - MIN(COALESCE(quantity*unit_price,0)) OVER() AS DeviationFromMin,
    MAX(COALESCE(quantity*unit_price,0)) OVER() - quantity*unit_price AS DeviationFromMax
FROM order_items oi
JOIN orders o USING (order_id);

-- RUNNING AND ROLLING TOTAL
	-- Tracking Current sales with Target sales
    -- Trend Analysis: Providing insight into historical pattern
    -- Analysis over time
-- RUNNING TOTAL
	-- Aggregate all values from the beginning up to the current point without dropping off older data.
    -- CONTOH: SUM(Sales) OVER (ORDER BY Month) ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
SELECT
		oi.order_id,
        order_date,
        quantity*unit_price AS sales,
        SUM(quantity*unit_price) OVER (ORDER BY order_date ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS total_sales
FROM order_items oi
JOIN orders o USING (order_id);

-- ROLLING TOTAL (rolling or shifting window)
	-- Aggregate all values within a fixed time window (e.g 30 days)
    -- as new data is added, the oldest data point will be dropped
    -- CONTOH: SUM(Sales) OVER (ORDER BY Month) ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
SELECT
		oi.order_id,
        order_date,
        quantity*unit_price AS sales,
        SUM(quantity*unit_price) OVER (ORDER BY order_date ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS total_sales
FROM order_items oi
JOIN orders o USING (order_id);


-- MOVING AVERAGE
-- calculate the moving average of sales for each product over time (like the running total)
SELECT
		oi.order_id,
        product_id,
        order_date,
        quantity*unit_price AS sales,
        round(AVG(COALESCE (quantity*unit_price, 0)) 
					OVER (PARTITION BY product_id ORDER BY order_date ROWS UNBOUNDED PRECEDING),2) AS moving_average_of_sales
FROM order_items oi
JOIN orders o USING (order_id);

-- calculate the moving average of sales for each product over, including only the next order 
SELECT
		oi.order_id,
        product_id,
        order_date,
        quantity*unit_price AS sales,
		round(AVG(COALESCE (quantity*unit_price, 0)) 
				OVER (PARTITION BY product_id ORDER BY order_date ROWS UNBOUNDED PRECEDING),2) AS moving_average_of_sales,
        round(AVG(COALESCE (quantity*unit_price, 0)) 
					OVER (PARTITION BY product_id ORDER BY order_date ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING),2) AS rolling_average_of_sales
FROM order_items oi
JOIN orders o USING (order_id);