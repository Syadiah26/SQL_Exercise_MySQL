SELECT *
FROM customers
-- ORDER BY first_name; -- ascending (ASC as default)
-- ORDER BY first_name DESC; -- descending
ORDER BY state DESC, first_name; -- sort by state then first name (ASC as default)

-- in MySQL we can select specific column and order by another column that are not selected
SELECT first_name, last_name
FROM customers
ORDER BY birth_date;

SELECT first_name, last_name, 10 AS points
FROM customers
ORDER BY points, first_name;

SELECT last_name, first_name, 10 AS points
FROM customers
ORDER BY 1, 2; -- order by last name kemudia first name

-- EXERCISE
-- select record dengan order_ide 2 di tabel order_items kemudia sort by total price in descending order
SELECT *
FROM order_items
WHERE order_id = 2
ORDER BY quantity * unit_price DESC;

SELECT *, quantity * unit_price AS total_price
FROM order_items
WHERE order_id = 2
ORDER BY total_price DESC;