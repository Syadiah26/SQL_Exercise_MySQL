-- copy tabel orders ke tabel order_archived, tapi attributnya (PK, NN, AI, dll) bakal diabaikan (ga ikut ke copy)
CREATE TABLE order_archived AS
SELECT * FROM orders;
-- menghapus semua record di suatu tabel menggunakan TRUNCATE
-- menghapus suatu table menggunakan DROP

INSERT INTO order_archived
SELECT * 
FROM orders
WHERE order_date < '2019-01-01';

-- EXERCISE
USE sql_invoicing;

CREATE TABLE invoices_archived AS
SELECT 
	i.invoice_id,
    i.number,
    c.name AS client,
    i.invoice_total,
    i.payment_total,
    i.invoice_date,
    i.due_date,
    i.payment_date
FROM invoices i
JOIN clients c
	USING (client_id)
WHERE payment_date IS NOT NULL;