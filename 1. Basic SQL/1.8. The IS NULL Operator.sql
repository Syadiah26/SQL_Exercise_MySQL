SELECT *
FROM customers
-- WHERE phone IS NULL; -- no hp kosong
WHERE phone IS NOT NULL; -- no hp tidak kosong

-- EXERCISE
-- get the orders that are not shipped

SELECT *
FROM orders
WHERE shipped_date IS NULL;