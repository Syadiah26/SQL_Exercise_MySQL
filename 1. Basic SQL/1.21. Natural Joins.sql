-- NATURAL JOIN produce unexpected results so it is not recommended

USE sql_store;
SELECT 
	o.order_id,
    c.first_name
FROM orders o
NATURAL JOIN customers c;
