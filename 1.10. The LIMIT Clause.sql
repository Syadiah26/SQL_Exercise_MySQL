SELECT *
FROM customers
-- LIMIT 3; -- take 3 records first
LIMIT 6, 3;  -- skip 6 record, than take 3 record

-- EXERCISE
-- get top three loyal customers
SELECT *
FROM customers
-- WHERE state = 'VA'
ORDER BY points DESC
LIMIT 3;