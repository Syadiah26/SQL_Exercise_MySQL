USE sql_store;

-- % : any number of characters
-- _ : single character
SELECT *
FROM customers
-- WHERE last_name LIKE 'b%'; -- -- want to get customers who is last name start with 'b'
-- WHERE last_name LIKE 'brush%'; -- start with 'brush'
-- WHERE last_name LIKE '%b%'; -- want to get customer who have an b in their last name, whether it is at the beginning, in the middle, or at the end
-- WHERE last_name LIKE '%y'; -- end with 'y'
-- WHERE last_name LIKE '_____y'; -- the sixth character of their last name is 'y'
WHERE last_name LIKE 'b____y'; -- starts with 'b' and the sixth character is 'y';

-- EXERCISE
-- Get the customers whose 
--   Addresses contain TRAIL or AVENUE
--   Phone numbers end with 9
SELECT *
FROM customers
WHERE address LIKE '%trail%' OR 
	  address LIKE '%avenue%';

SELECT *
FROM customers
-- WHERE phone LIKE '%9'; -- end with 9
WHERE phone NOT LIKE '%9'; -- not end with 9