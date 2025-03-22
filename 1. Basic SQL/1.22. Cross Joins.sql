-- CROSS JOIN : join every records from the first table and every record from the second table 
-- ini kek kombinasi aja, misal kombinasi bbrp warna dgn bbrp ukuran itu pake cross join

SELECT
	c.first_name AS customer,
    p.name AS product
FROM customers c
CROSS JOIN products p
ORDER BY customer, product;

-- The implicit syntax for CROSS JOIN (not recommended), prefer use the explicit syntax because it is more clear.
SELECT
	c.first_name AS customer,
    p.name AS product
FROM customers c, products p
ORDER BY customer, product;

-- EXERCISE
-- Do a cross join between shippers and products
-- using the implicit syntax
-- and then using the explicit syntax

-- Using the implicit syntax
SELECT 
	sh.name AS shipper,
    p.name AS product
FROM shippers sh, products p
ORDER BY shipper, product;

-- Using the explicit syntax
SELECT 
	sh.name AS shipper,
    p.name AS product
FROM shippers sh
CROSS JOIN products p
ORDER BY shipper, product;