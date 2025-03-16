-- ALTER: mengubah struktur tabel dalam database
	-- menambah kolom baru pada tabel
    -- menghapus kolom pada tabel
    -- mengubah tipe data kolom
    -- menambah atau menghapus constraint pada kolom
    -- mengubah nama tabel

-- task: add new column called email to table persons

ALTER TABLE persons
ADD email VARCHAR(15) 	NOT NULL;

SELECT *
FROM persons;

DESCRIBE persons;