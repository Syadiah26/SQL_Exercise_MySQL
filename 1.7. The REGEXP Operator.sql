-- regular expression
-- ^ : beginning
-- $ : end
-- | : logical OR
-- [abcd]
-- [a-f]

SELECT *
FROM customers
-- WHERE last_name LIKE '%field%'; -- ini sama dengan
-- WHERE last_name REGEXP 'field'; -- ga perlu pake character
-- WHERE last_name REGEXP '^field'; -- the last name must start with 'field'
-- WHERE last_name REGEXP 'field$'; -- must end with 'field'
-- WHERE last_name REGEXP 'field|mac|rose'; -- have somewhere 'field' or somewhere 'mac' or somewhere 'rose'
-- WHERE last_name REGEXP '^field|mac|rose'; -- have start with 'field' or somewhere 'mac' or somewhere 'rose'
-- WHERE last_name REGEXP 'field$|mac|rose'; -- have end with 'field' or somewhere 'mac' or somewhere 'rose'
-- WHERE last_name REGEXP '[gim]e'; -- have 'ge' or 'ie' or 'me' somewhere
-- WHERE last_name REGEXP 'e[yao]'; -- have 'ey' or 'ea' or 'eo' somewhere
WHERE last_name REGEXP '[a-h]e'; -- untuk mempersingkat '[abcdefgh]e'

-- EXERCISE
-- Get the customers whose
-- first names are ELKA or AMBUR
-- last names end with EY or ON
-- last names start with MY or contains SE
-- last names contain B followed R or U

SELECT *
FROM customers
WHERE first_name REGEXP 'elka|ambur';

SELECT *
FROM customers
WHERE last_name REGEXP 'ey$|on$';

SELECT *
FROM customers
WHERE last_name REGEXP '^my|se';

SELECT *
FROM customers
WHERE last_name REGEXP 'b[ru]'; -- atau bisa juga
-- WHERE last_name REGEXP 'br|bu';