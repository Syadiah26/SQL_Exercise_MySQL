-- CONCAT(), LOWER(), UPPER(), TRIM(), LENGTH(), SUBSTRING()

-- CONCAT()
	-- returns a string by concatinating two or more string values
SELECT 
		CONCAT(first_name, ' ', last_name) AS full_name
FROM customers;

-- LOWER()
	-- converts a string to lowercase
    
-- UPPER()
	-- converts a string to uppercase
    SELECT UPPER(first_name) AS upper_first_name
    FROM customers;
    
-- TRIM()
	-- remove leading and trailing spaces from a string
    -- example: (left space)_MARIA_(right space)
    -- LTRIM() will remove character in the left side (in this case, the result will be 'MARIA_(right space)'
    -- RTRIM() will remove character in the right side (in this case, the result will be '(right case)_MARIA'
    -- TRIM() will remove character in the left and right side (in this case, the results will be 'MARIA'
    
-- UPDATE customers
-- SET last_name = ' MacCaffrey '
-- WHERE customer_id = 1;

SELECT 
	TRIM(last_name) 
    -- LTRIM(last_name)
    -- RTRIM(last_name)
FROM customers;
    
-- LENGTH()
	-- returns the length of a string
SELECT
	last_name, LENGTH(last_name) AS len_last_name
FROM customers;

-- UPDATE customers
-- SET last_name = 'MacCaffrey'
-- WHERE customer_id = 1;

SELECT 
	last_name, 
    TRIM(last_name) AS clean_last_name,
    LENGTH(last_name) AS len_last_name,
    LENGTH(TRIM(last_name)) AS clean_len_last_name
FROM customers;


-- SUBSTRING(column, start, length)
	-- returns substring from string
SELECT 
	last_name,
    SUBSTRING(last_name, 2, 3) AS sub_last_name
FROM customers;