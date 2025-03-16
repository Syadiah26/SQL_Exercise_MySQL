-- There is no FULL JOIN in MySQL, and avoid using FULL JOIN in your project! (using FULL JOIN is not recommended)
-- FULL JOIN is combination of LEFT JOIN and RIGHT JOIN (union antara left join dan right join)
SELECT 
	c.customer_id,
    c.first_name,
    o.order_id
FROM customers c
LEFT JOIN orders o
	ON c.customer_id = o.customer_id
UNION
SELECT 
	c.customer_id,
    c.first_name,
    o.order_id
FROM customers c
RIGHT JOIN orders o
	ON c.customer_id = o.customer_id;