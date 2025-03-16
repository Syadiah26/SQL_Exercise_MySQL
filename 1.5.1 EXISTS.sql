-- Use EXISTS instead of IN for large tables
-- query di dalam exists itu gabisa di run sendiri, harus dirun semuanya sama query utamanya.

SELECT *
FROM orders
WHERE customer_id IN ( 
						SELECT customer_id
                        FROM customers
                        WHERE points > 2000);
-- sama dengan
SELECT *
FROM orders AS o
WHERE EXISTS (
				SELECT 1
				FROM customers AS c
				WHERE c.customer_id = o.customer_id
				AND points > 2000);