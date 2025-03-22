USE sql_invoicing;
UPDATE invoices
SET 
	payment_total = invoice_total * 0.5, 
    payment_date = due_date
WHERE client_id =3;
-- WHERE client_id IN (3,4);

-- EXERCISE
-- Write a SQL statement to
-- give any customers born before 1990
-- 50 extra points

USE sql_store;
UPDATE customers
SET points = points + 50
WHERE birth_date < '1990-01-01';

UPDATE customers
SET 
	state = 'FL',
	points = points + 1000
WHERE customer_id = 1