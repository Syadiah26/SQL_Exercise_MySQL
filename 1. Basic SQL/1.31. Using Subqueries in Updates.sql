-- POKOKNYA SEBELUM UPDATE, LIHAT DULU RECORD MANA YANG BAKAL TERUPDATE (run dulu subquery nya)

USE sql_invoicing;
UPDATE invoices
SET 
	payment_total = invoice_total * 0.5, 
    payment_date = due_date
WHERE client_id =
				(SELECT client_id
				FROM clients
				WHERE name = 'Myworks');
                
UPDATE invoices
SET 
	payment_total = invoice_total * 0.5, 
    payment_date = due_date
WHERE client_id IN
				(SELECT client_id
				FROM clients
				WHERE state IN ('CA', 'NY'));
                
-- LIHAT DULU OUTPUT SUBQUERYNYA
-- MISAL
UPDATE invoices
SET 
	payment_total = invoice_total * 0.5, 
    payment_date = due_date
WHERE payment_date IS NULL;
-- SEBELUM RUN YANG DI ATAS, LIHAT DULU
SELECT *
FROM invoices
WHERE payment_date IS NULL;

-- EXERCISE
USE sql_store;
-- LIHAT DULU OUTPUT SUBQUERY NYA
SELECT customer_id
FROM customers
WHERE points > 3000;
                
UPDATE orders
SET comments = 'Gold Customer'
WHERE customer_id IN
				(SELECT customer_id
                FROM customers
                WHERE points > 3000);
