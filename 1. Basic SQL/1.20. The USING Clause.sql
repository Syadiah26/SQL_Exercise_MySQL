-- USING dipake kalo nama kolom primary key and foreign key nya sama
USE sql_store;
SELECT
	o.order_id,
    c.first_name,
    sh.name AS shipper
FROM orders o
JOIN customers c
	-- ON o.customer_id = c.customer_id;
    USING (customer_id) -- for shorter
LEFT JOIN shippers sh
	USING (shipper_id);
    
SELECT *
FROM order_items oi
JOIN order_item_notes oin
	-- ON oi.order_id = oin.order_id
    -- AND oi.product_id = oin.product_id;
    USING (order_id, product_id); -- for shorter

-- EXERCISE
USE sql_invoicing;

SELECT
	p.date,
    c.name AS client,
    p.amount,
    pm.name AS payment_method
FROM payments p
JOIN clients c
	USING (client_id)
JOIN payment_methods pm
	ON p.payment_method = pm.payment_method_id;
	