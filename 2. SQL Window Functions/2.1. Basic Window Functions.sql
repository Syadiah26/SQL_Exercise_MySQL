-- Window functions: Perform calculations (e.g aggregation) on a specific subset of data without losing the level of details of rows.
-- Use GROUP BY for simple aggregations (SIMPLE DATA ANALYSIS)
-- Use Window Functions for keep aggregations + keep details (ADVANCED DATA ANALYSIS)
-- GROUP BY have Aggregate functions: COUNT(expr), SUM(expr), AVG(expr), MIN(expr), MAX(expr)
-- WINDOW FUNCTIONS have:
	-- Aggregate functions: COUNT(expr), SUM(expr), AVG(expr), MIN(expr), MAX(expr)
    -- Rank functions: ROW_NUMBER(), RANK(), DENSE_RANK(), CUME_DIST(), PERCENT_RANK(), NTILE(n)
    -- Value (Analytics) functions: LEAD(expr, offset, default), LAG(expr, offset, default), FIRST_VALUE(expr), LAST_VALUE(expr)
    
-- Window syntax consists of Windows functions(SUM, COUNT, RANK, dll) + OVER Clause
	-- OVER clause consists of:
		-- PARTITION Clause
        	-- ORDER Clause (required for RANK and VALUE function)
        	-- FRAME CLAUSE
-- contoh:
	-- AVG(Sales) OVER (PARTITION BY category ORDER BY order_date ROWS UNBOUNDED PRECEDING
    -- AVG(Sales) OVER (PARTITION BY category ORDER BY order_date ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING
    -- RANK() OVER (PARTITION BY Month ORDER BY Sales DESC) -- (RANK harus diikuti dengan ORDER BY)
    -- NTILE(2) OVER (ORDER BY order_date)
	-- LEAD(Sales 2, 10) OVER (ORDER BY order_date)
    -- SUM (CASE WHEN Sales > 100 THEN 1 ELSE 0 END) OVER (ORDER BY order_date)
    -- SUM(Sales) OVER (PARTITION BY product_id, order_status)
    
    
-- Find the total sales across all orders
SELECT 
    SUM(quantity*unit_price) AS total_sales
FROM order_items;

-- Using window functions
SELECT 
    order_id,
    quantity*unit_price AS sales,
    SUM(quantity*unit_price) OVER() AS total_sales
FROM order_items;

-- Find the total sales for each product
SELECT 
	product_id, 
    SUM(quantity*unit_price) AS total_sales
FROM order_items
GROUP BY product_id;

-- Find the total sales for each product, additionally provide details such order id, quantity, and unit_price
SELECT 
	order_id,
	product_id, 
    quantity*unit_price AS sales,
    SUM(quantity*unit_price) OVER (PARTITION BY product_id) AS total_sales,
    unit_price
FROM order_items;


-- Find the total sales for each product, additionally provide details such order id, order date, and quantity
SELECT 
	oi.order_id,
    order_date,
	product_id, 
    quantity*unit_price AS sales,
    SUM(quantity*unit_price) OVER (PARTITION BY product_id) AS total_sales
FROM order_items oi
JOIN orders o USING(order_id);


 
-- Find the total sales across all product and the total sales for each product,
-- additionally provide details such order id, order date, and sales    
SELECT 
	order_id,
	product_id, 
    quantity*unit_price AS sales,
    SUM(quantity*unit_price) OVER() AS total_sales,
    SUM(quantity*unit_price) OVER (PARTITION BY product_id) AS total_sales_by_productid
FROM order_items;

-- Find the total sales for each combination of product and order status
SELECT 
	oi.order_id,
    oi.product_id,
    oi.quantity*oi.unit_price AS sales,
	os.name AS status,
    SUM(oi.quantity*oi.unit_price) OVER (PARTITION BY product_id, status) AS TotalSalesByProductandStatus
FROM order_items oi
JOIN orders o
			USING(order_id)
JOIN order_statuses os
	ON o.status = os.order_status_id;

-- ORDER BY : sort a data within a window
-- Rank each order base on their sales from highest to lowest
SELECT
	order_id,
    quantity*unit_price AS sales,
    RANK() OVER (ORDER BY quantity*unit_price DESC) AS rank_sales
FROM order_items;

-- WINDOW FRAME
-- Defines a subset of rows within each window that is relevan for the calculation
-- contoh:
-- AVG(Sales) OVER (PARTITION BY Category ORDER BY OrderDate ROWS BETWEEN CURRET ROW AND UNBOUNDED FOLLOWING)
	-- FRAME types: ROWS and RANGE
	-- Frame boundary (lower value): CURRENT ROW, N PRECEDING, UNBOUNDED PRECEDING
		-- N PRECEDING: diikuti n row sebelum current row
	-- Frame boundary (higher value): CURRENT ROW, N FOLLOWING, UNBOUNDED FOLLOWING (the last possible row within a window)
		-- N FOLLOWING: diikuti n row setelah current row
-- FRAME Clause can only use together with ORDER BY clause
-- Lower value must be BEFORE the higher value 
-- For only PRECEDING, the CURRENT ROW can be skipped
	-- example: ROWS BETWEEN CURRENT ROW AND 2 FOLLOWING menjadi ROWS 2 FOLLOWING
-- DEFAULT FRAME: SQL uses DEFAULT FRAME, if ORDER BY is used without FRAME
				-- default: ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW

SELECT 
	oi.order_id,
    oi.product_id,
    oi.quantity*oi.unit_price AS sales,
	os.name AS status,
    SUM(oi.quantity*oi.unit_price) 
				OVER (PARTITION BY os.name ORDER BY order_id ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS TotalSales1,
	SUM(oi.quantity*oi.unit_price) 
				OVER (PARTITION BY os.name ORDER BY order_id ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS TotalSales2,
	SUM(oi.quantity*oi.unit_price) 
				OVER (PARTITION BY os.name ORDER BY order_id ROWS BETWEEN CURRENT ROW AND 2 FOLLOWING) AS TotalSales3,
	SUM(oi.quantity*oi.unit_price) 
				OVER (PARTITION BY os.name ORDER BY order_id ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS TotalSales4,
	SUM(oi.quantity*oi.unit_price) 
				OVER (PARTITION BY os.name ORDER BY order_id ROWS UNBOUNDED PRECEDING) AS TotalSales_Cummulative
FROM order_items oi
JOIN orders o
			USING(order_id)
JOIN order_statuses os
	ON o.status = os.order_status_id;
    
-- 4 RULES WINDOW FUNCTIONS:
	-- 1. Window functions can be used ONLY in SELECT and ORDER BY Clauses
	-- 2. Nesting window functions is not allowed!
    -- 3. SQL execute WINDOW functions after WHERE clause
    -- 4. WINDOW functions can be used together with GROUP BY in the same query, ONLY if the same column are used 
		-- (execute group by first then window functions)
		-- for example: rank customers based on their total sales
-- rank customers based on their total sales
SELECT 
	o.customer_id,
    SUM(oi.quantity*oi.unit_price) AS total_sales,
    RANK() OVER (ORDER BY SUM(oi.quantity*oi.unit_price) DESC) AS rank_customer
FROM order_items oi
JOIN orders o USING (order_id)
GROUP BY customer_id;