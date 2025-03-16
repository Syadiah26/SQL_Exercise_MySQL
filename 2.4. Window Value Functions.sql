-- Access a value from other row
	-- LAG(expr, offset (optional), default value (optional)) : nyari data sebelum current row (use frame clause is not allowed)
	-- LEAD(expr, offset(optional), default value (optional)) : nyari data setelah current row (use frame clause is not allowed)
		-- offset: number of rows forward or backward from current row, default = 1
        -- default value: return default value if next/previous row is not available, default = NULL
	-- FIRST_VALUE(expr) : nyari data di row pertama (frame clause optional)
	-- LAST_VALUE(expr): nyari data di row terakhir (frame clause should be used)
-- ORDER Clause is required

-- USE Case: 
	-- Time Series Analysis
		-- Year-over-Year (YoY) Analysis : analyze the overall growth or decline of the business's performance over time
		-- Month-over-Month (MoM) Analysis : analyze short-term trends and discover pattern in seasonality
	-- Customer Retention Analysis

-- Analyze the MoM performance by finding the percentage change in sales between the current and previous month
SELECT 
		*,
		CurrentMonthSales - PreviousMonthSales AS MoM_Change,
        CONCAT(ROUND((CurrentMonthSales - PreviousMonthSales)/PreviousMonthSales * 100,1), '%') AS MoM_Change_Percentage
FROM
		(SELECT
			MONTH(order_date) AS OrderMonth,
			SUM(quantity*unit_price) AS CurrentMonthSales,
			LAG(SUM(quantity*unit_price)) OVER (ORDER BY MONTH(order_date)) AS PreviousMonthSales
		FROM order_items oi
		JOIN orders o USING (order_id)
		GROUP BY OrderMonth
		) t;
        
-- Customer Retention Analysis (mengukur customer behavior and loyalty)
	-- retention: kemampuan menyimpan/mempertahankan sesuatu dalam jangka tertentu
-- In order to analyze customer loyalty, rank customer based on the average days between their orders
SELECT 
	customer_id,
    COALESCE(AVG (DaysUntilNextOrder), 99999) AS AvgDays,
    RANK() OVER(ORDER BY COALESCE (AVG (DaysUntilNextOrder), 99999)) AS rank_avg_days
FROM (
		SELECT 
			order_id,
			customer_id,
			order_date AS CurrentOrder,
			LEAD(order_date) OVER (PARTITION BY customer_id ORDER BY order_date) AS NextOrder,
			DATEDIFF (LEAD(order_date) OVER (PARTITION BY customer_id ORDER BY order_date), order_date) AS DaysUntilNextOrder -- DATEDIFF(end date, start date)
		FROM orders
		ORDER BY customer_id, order_date
        ) t
GROUP BY customer_id;


-- FIRST_VALUE/LAST_VALUE
	-- FIRST_VALUE(expr) : nyari data di row pertama (frame clause optional)
	-- LAST_VALUE(expr): nyari data di row terakhir (frame clause should be used)
    -- default fraeme clause: RANGE BETWEEN UNBOUNDEND PRECEDING AND CURRENT ROW
    -- USE CASE: COMPARISON ANALYSIS
-- find the lowest and highest sales for each product
-- find the difference in sales between the current and the lowest sales
SELECT 
	order_id,
    product_id,
    quantity*unit_price AS sales,
    FIRST_VALUE(quantity*unit_price) OVER (PARTITION BY product_id ORDER BY quantity*unit_price) AS lowest_sales_by_product,
	LAST_VALUE(quantity*unit_price) OVER (PARTITION BY product_id ORDER BY quantity*unit_price 
											ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS highest_sales_by_product,
	quantity*unit_price - FIRST_VALUE(quantity*unit_price) OVER (PARTITION BY product_id ORDER BY quantity*unit_price) AS SalesDifference
FROM order_items;

