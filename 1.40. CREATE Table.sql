-- COLUMN Definition
-- Column name (could be anything)
-- Data type (int, varchar, date, char, dll)
-- Constraints (primary key, not null, unique, default, dll)
-- kalo kita udah define PRIMARY KEY, maka udah otomatis unique and not null.alter

CREATE TABLE sql_store.persons (
	id 			INT				PRIMARY	KEY		AUTO_INCREMENT,
    person_name	VARCHAR(50) 	NOT NULL,
    birth_date	DATE,
    phone		VARCHAR(15)		NOT NULL		UNIQUE
)

SELECT*
FROM persons;

DESCRIBE persons;