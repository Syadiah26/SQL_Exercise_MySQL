-- INNER JOIN sama aja ditulis JOIN
-- OUTER JOIN ada 2: LEFT JOIN and RIGHT JOIN (bisa ditulis LEFT OUTER JOIN dan RIGHT OUTER JOIN)
-- LEFT JOIN: semua record di left table bakal ditampilin
-- RIGHT JOIN: semua record di right table bakal ditampilin

USE sql_store;

-- LEFT JOIN with customers table as left (see the all customers)
SELECT 
	c.customer_id,
    c.first_name,
    o.order_id
FROM customers c
LEFT JOIN orders o
	ON c.customer_id = o.customer_id
ORDER BY c.customer_id;
    
-- RIGHT JOIN with orders table as right (see the all orders)
SELECT 
	c.customer_id,
    c.first_name,
    o.order_id
FROM customers c
RIGHT JOIN orders o
	ON c.customer_id = o.customer_id
ORDER BY c.customer_id;

-- EXERCISE
SELECT
	p.product_id,
    p.name,
    oi.quantity
FROM products p
LEFT JOIN order_items oi
	ON p.product_id = oi.product_id

ORDER BY p.product_id;