SELECT *
FROM customers
WHERE birth_date > '1990-01-01' AND points > 1000;

-- points dan state harus terpenuhi dua duanya, sedangka birth date engga.
SELECT *
FROM customers 
WHERE birth_date > '1990-01-01' OR points > 1000 AND state = 'VA';

-- urutan operator : 
-- 1. ()
-- 2. * / 
-- 3. +-

-- urutan operator : 
-- 1. AND
-- 2. OR

-- sehingga, untuk mempermudah, penulisannya menjadi:
SELECT *
FROM customers
WHERE birth_date > '1990-01-01' OR 
	  (points > 1000 AND state = 'VA');

-- penggunaan NOT
SELECT *
FROM customers
-- WHERE NOT (birth_date > '1990-01-01' OR points > 1000); -- ini sama dengan
WHERE birth_date <= '1990-01-01' AND points <= 1000;
-- karena (A U B)' = A' n B'

-- EXERCISE
-- from the order_items table, get the items
-- for order #6
--  where the total price is greater than 30

SELECT *
FROM order_items
WHERE order_id = 6 AND unit_price * quantity > 30;