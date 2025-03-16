-- urutannya : SELECT, FROM, JOIN, WHERE, GROUP BY, HAVING, ORDER BY, LIMIT
-- filter database pake WHERE
-- filter aggregate functions pake HAVING
-- HAVING will works only when using GROUP BY

SELECT 
	state, 
    MAX(points) AS max_points
FROM customers
GROUP BY state
HAVING max_points > 2000
ORDER BY max_points DESC;

SELECT 
	state, 
    COUNT(*) AS total_customer
FROM customers
GROUP BY state
HAVING total_customer > 1;

SELECT 
	state, 
    COUNT(*) AS total_customer
FROM customers
WHERE state != 'FL'
GROUP BY state
HAVING total_customer > 1;