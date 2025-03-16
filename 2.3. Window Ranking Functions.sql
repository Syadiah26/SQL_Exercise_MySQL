-- Integer based ranking : discrete values (top/bottom N analysis) such as find the top three product
	-- RANK_NUMBER(), RANK(), DENSE_RANK(), NTILE(n)
-- Percentage based ranking : continous values (distribution analysis) such as find the top 20% of the product
	-- CUME_DIST(), PERCENT_RANK()
-- The FRAME clause are not allowed to used in the ranking functions


-- ROW_NUMBER() : Assign a unique number to each row in a window
	-- ROW_NUMBER() OVER (ORDER BY sales)
-- RANK() : Assign a rank to each row in a window, with gaps
	-- RANK() OVER (ORDER BY sales)
-- DENSE_RANK() : Assign a rank to each row in a window, without gaps
	-- DENSE_RANK() OVER (ORDER BY sales)
-- CUME_DIST() : calculates the cumulative distribution of a value within a set of values
	-- CUME_DIST() OVER (ORDER BY sales)
-- PERCENT_RANK() : returns the percentile ranking number of a row
	-- PERCENT_RANK() OVER (ORDER BY sales)
-- NTILE (n) : divides the rows into a specified number of approximately equal groups
	-- NTILE(2) OVER (ORDER BY sales)
    
    
    
-- UPDATE order_items
-- SET quantity = 10, unit_price = 9
-- WHERE order_id = 4;
-- rank the orders based on their sales from highest to lowest

-- 1. ROW_NUMBER() : 
	-- A unique ranking without gap/skipping
	-- it does not handle ties (jadi kalo ada 2 row yg nilainya sama, rank nya ga akan sama)
-- 2. RANK() : 
	-- Shared ranking, with gaps (ada rank yg diskip)
    -- It handles ties (kalo ada 2 nilai yang sama, nomor ranking nya akan sama)
-- 3. DENSE_RANK() : 
	-- Shared ranking, without gaps (ga ada rank number yg diskip)
    -- It handles ties
    
SELECT
    order_id,
    product_id,
    quantity*unit_price AS sales,
    ROW_NUMBER() OVER (ORDER BY quantity*unit_price DESC) AS sales_rank_row_number,
	RANK() 		 OVER (ORDER BY quantity*unit_price DESC) AS sales_rank_rank,
	DENSE_RANK() OVER (ORDER BY quantity*unit_price DESC) AS sales_rank_dense_rank
FROM order_items;

-- ROW_NUMBER USE CASE: TOP N ANALYSIS
	-- find the top highest sales for each product
SELECT *
FROM
	(SELECT
		order_id,
		product_id,
		quantity*unit_price AS sales,
		ROW_NUMBER() OVER (PARTITION BY product_id ORDER BY quantity*unit_price DESC) AS sales_rank_row_number
	FROM order_items) t
WHERE sales_rank_row_number = 1;

-- ROW_NUMBER USE CASE: BOTTOM N ANALYSIS
	-- find the lowest 2 customers based on their total sales
SELECT *
FROM (
SELECT 
	o.customer_id,
    SUM(quantity*unit_price) AS total_sales,
	ROW_NUMBER() OVER (ORDER BY SUM(quantity*unit_price)) AS rank_customer
FROM order_items oi
JOIN orders o USING (order_id)
GROUP BY customer_id
) t 
WHERE rank_customer <= 2;

-- CREATE TABLE customer_archived AS
-- SELECT * FROM customers;

-- INSERT INTO customer_archived
-- VALUES (2, 'Ines', 'Brushfield', '1986-04-13', '804-427-9456', '14187 Commercial Trail', 'Hampton', 'VA', '947'),
-- 			(5, 'Clemmie', 'Betchley', '1973-11-07', NULL, '5 Spohn Circle', 'Arlington', 'TX', 3675);

-- ROW_NUMBER USE CASE: GENERATE UNIQUE IDs
	-- assign unique customer_IDs to the rows of the customer_archived table
SELECT 
	*,
    customer_id,
    ROW_NUMBER() OVER (ORDER BY customer_id, birth_date) AS UniqueID
FROM customer_archived;

-- ROW_NUMBER USE CASE: IDENTIFY DUPLICATES
	-- identify duplicate rows in the table 'customer_archived' and return a clean result without any duplicates
SELECT * FROM (
SELECT 
	*,
    ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY customer_id, points) AS rn
FROM customer_archived) t
WHERE rn =1;


-- NTILE(n):
	-- divides the rows into a specified number of approximately equal groups (buckets)
    -- bucket size = number of rows / number of buckets
    -- misal jumlah rownya 4, trus bucketnya 2, maka 4/2 = 2 (2 row pertama nilainya 1, 2 row kedua nilainya 2)
    -- kalo misal jumlah rowsnya ganjil misal 5, bucketnya 2, maka larger groups come first, 
		-- jadi pembagiannya 3 row pertama nilainya 1, trus 2 row di bawah nilainya 2
SELECT 
		*,
		quantity*unit_price AS sales,
        COUNT(*) OVER() AS number_of_rows,
		NTILE (3) OVER (ORDER BY quantity*unit_price DESC) AS three_buckets,
		NTILE (4) OVER (ORDER BY quantity*unit_price DESC) AS four_buckets,
		NTILE (5) OVER (ORDER BY quantity*unit_price DESC) AS five_buckets
FROM order_items;

-- NTILE USE CASE: 
	-- 1. DATA SEGMENTATION
		-- segment all orders into three categories: high, medium, and lower sales
SELECT *,
	CASE 	WHEN Buckets = 1 THEN 'High'
			WHEN Buckets = 2 THEN 'Medium'
            ELSE 'Low'
	END SalesSegmentations
FROM (
SELECT 
	order_id,
	quantity*unit_price AS sales,
    NTILE(3) OVER (ORDER BY quantity*unit_price DESC) AS Buckets
FROM order_items) t;
        
    -- 2. EQUALIZING LOAD PROCESSING (ETL PROCESSING)
		-- in order to export the data, divide the orders into 4 groups
SELECT
    *,
	NTILE(4) OVER (ORDER BY order_id) AS buckets
FROM order_items;

-- PERCENTAGE-BASED RANKING : continous values from 0 to 1 (distribution analysis) such as find the top 20% of the product
	-- CUME_DIST() stand for cumulative distribution
		-- Position number of the value / number of rows
        -- kalo misal row 2 dan 3 nilainya sama, maka number of the value ngambil row yang terakhir, dalam hal ini 3
        -- dan kalo nilainya sama, percentage nya akan sama
        
    -- PERCENT_RANK() (PERCENTILE) : the relative position of each row
		-- (Position number of value - 1) / (number of rows - 1)
		-- kalo misal row 2 dan 3 nilainya sama, maka number of the value ngambil row yang pertama, dalam hal ini 2
		-- dan kalo nilainya sama, percentage nya akan sama

-- find the products that fall within the highest 40% of prices
SELECT 
		*,
		CONCAT (CumDist * 100, '%') AS CumDistPercentage
FROM (
		SELECT
				name AS product,
				unit_price,
				CUME_DIST() OVER (ORDER BY unit_price DESC) AS CumDist
FROM products) t 
WHERE CumDist <= 0.4;
    
    
SELECT 
		*,
		CONCAT (PercentRank * 100, '%') AS PercentRankPercentage
FROM (
		SELECT
				name AS product,
				unit_price,
				round(PERCENT_RANK() OVER (ORDER BY unit_price DESC), 3) AS PercentRank
FROM products) t 
WHERE PercentRank <= 0.4;
    







