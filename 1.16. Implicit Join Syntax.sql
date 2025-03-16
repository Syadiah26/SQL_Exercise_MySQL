USE sql_store;

SELECT *
FROM orders
JOIN customers
	ON orders.customer_id = customers.customer_id;
    
-- Implicit Join Syntax (not recommended)
SELECT *
FROM orders o, customers c
WHERE o.customer_id = c.customer_id;
