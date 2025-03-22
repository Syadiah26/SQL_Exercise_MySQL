INSERT INTO customers
VALUES (
	DEFAULT, 
    'John', 
    'Smith', 
    '1990-01-01',
    NULL, -- or DEFAULT because the default is null
    'adress',
    'city',
    'CA',
    DEFAULT
    );

-- atau
INSERT INTO customers (last_name, first_name, birth_date, address, city, state)
VALUES (
	'Smith', 
    'John', 
    '1990-01-01',
    'address',
    'city',
    'CA'
    );