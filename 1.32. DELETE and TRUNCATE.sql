-- HATI-HATI KALO PAKE FUNGSI INI
DELETE FROM invoices
WHERE invoice_id = 1;

SELECT client_id
FROM clients
WHERE name = 'Myworks';

DELETE FROM invoices
WHERE client_id = (
					SELECT client_id
					FROM clients
					WHERE name = 'Myworks');
                    
-- misal kita punya big data dan mau hapus semua datanya, mending pake TRUNCATE
-- kalo pake DELETE bakal makan waktu lama soalnya ngehapusnya per baris (?)/ mindai baris yg akan dihapus
-- TRUNCATE : ngosongin isi tabel/delete semua row dari suatu tabel
-- pakenya gini:
-- TRUNCATE customers; -- (dijadiin comments soalnya takut ke delete:(((()