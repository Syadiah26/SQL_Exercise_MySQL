USE sql_store;
SELECT
	state, COUNT(*) AS total_customers
FROM customers
GROUP BY state
ORDER BY total_customers DESC;

-- urutannya : SELECT, FROM, JOIN, WHERE, GROUP BY, HAVING, ORDER BY, LIMIT

-- find the highest points for each state
SELECT state, MAX(points) AS max_points
FROM customers
GROUP BY state
ORDER BY max_points DESC;