-- panggil database yang mau dipake
USE sql_store;

-- kalo misalkan gak dipanggil di awal, berarti harus dipanggil tiap mau manggil table
-- example:
SELECT *
FROM sql_store.customers;

--  urutan penggunaan function:
-- SELECT -> FROM -> WHERE -> ORDER BY

-- select all column
SELECT *
FROM customers;

-- select specific column
SELECT customer_id, first_name, last_name
FROM customers;

-- WHERE function
SELECT *
FROM customers
WHERE customer_id = '1';

-- ORDER BY function
-- ASC for ascending (mengurutkan data dimulai abjad atau angka dari awal) (DEFAULT)
-- DESC for descending (mengurutkan data dimulai dari abjad atau angka terakhir)
SELECT *
FROM customers
-- WHERE customer_id = '1'
ORDER BY first_name;

SELECT *
FROM customers
ORDER BY first_name DESC;

-- menampilkan angka 1,2,3 dalam 3 kolom
SELECT 1,2,3;

SELECT *
FROM customers
-- WHERE customer_id = '1'
ORDER BY first_name;