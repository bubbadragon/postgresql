-- Question 1 - Create new table and populate it from different table

CREATE TABLE chicago_contacts (
	new_id GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	contact_id INT NOT NULL
);

INSERT INTO chicago_contacts (contact_id)
SELECT contact_id
FROM contacts
WHERE areacode = '312';

SELECT COUNT(*)
FROM chicago_contacts;

-- Question 2 - Temp table, pg_stat_all_tables

CREATE TEMP TABLE contacts_temp AS
SELECT *
FROM contacts
LIMIT 1000;

SELECT COUNT(*)
FROM contacts_temp;

SELECT relname, n_live_tup
FROM pg_stat_all_tables
WHERE relname = 'contacts_temp';

-- Shut down and restart system

SELECT COUNT(*)
FROM contacts_temp;

SELECT relname, n_live_tup
FROM pg_stat_all_tables
WHERE relname = 'contacts_temp';

-- Question 3 - Index, pg_stat_all_indexes

CREATE INDEX idx_lastname ON contacts(lastname);

SELECT *
FROM contacts
WHERE lastname = 'Bryson';

SELECT relname, indexrelname, idx_scan
FROM pg_stat_all_indexes
WHERE indexrelname = 'idx_lastname';

-- Question 4 - pg_database_size, pg_table_size

SELECT pg_size_pretty(pg_database_size(current_database()));

SELECT pg_size_pretty(pg_table_size('contacts');

-- Question 5 - pg_column_size, USING areacode::int

SELECT SUM(pg_column_size(areacode))
FROM contacts;

ALTER TABLE contacts
ALTER COLUMN areacode TYPE INT USING areacode::int;

SELECT SUM(pg_column_size(areacode))
FROM contacts;

-- Question 6 - EXPLAIN ANALYZE

EXPLAIN ANALYZE 
SELECT *
FROM contacts
WHERE contact_id = 10081;

CREATE INDEX idx_contact_id ON contacts(contact_id);

EXPLAIN ANALYZE 
SELECT *
FROM contacts
WHERE contact_id = 10081;

-- Question 7 - Metadata, pg_class

SELECT relname, reltuples
FROM pg_class
WHERE relname = 'contacts';

-- Question 8 - Vacuum, pgstattuple

ALTER TABLE contacts SET (autovacuum_enabled = off);

DELETE FROM contacts
WHERE contact_id <= 30000;

ANALYZE contacts;

CREATE EXTENSION pgstattuple;

SELECT *
FROM pgstattuple('contacts');

VACUUM contacts;
ANALYZE contacts;

SELECT *
FROM pgstattuple('contacts');

SELECT pg_size_pretty(pg_table_size('contacts'));

VACUUM FULL contacts;
ANALYZE contacts;

SELECT *
FROM pgstattuple('contacts');

ALTER TABLE contacts SET (autovacuum_enabled = on);

-- Question 9 - Index WHERE

CREATE INDEX idx_areacode ON contacts(areacode);

SELECT pg_size_pretty(pg_relation_size('idx_areacode'));

EXPLAIN
SELECT *
FROM contacts
WHERE areacode = '801';

CREATE INDEX idx_ut_areacodes ON contacts(areacode)
WHERE areacode IN ('801', '435');

SELECT pg_size_pretty(pg_relation_size('idx_ut_areacodes'));

EXPLAIN
SELECT * 
FROM contacts 
WHERE areacode = '801';

-- Question 10 - UPDATE

ALTER TABLE contacts
ADD COLUMN mydata TEXT;

SELECT pg_size_pretty(pg_table_size('contacts'));

UPDATE contacts
SET mydata = 'Fear is the mind killer.';

SELECT pg_size_pretty(pg_table_size('contacts'));

SELECT mydata
FROM contacts

-- Bonus Question

/* The index is not being used because of the LIKE '%gmail.com'. The system is trying to do a sequential search
	instead of using the index. One work around to this is to create a new column with the emails column stored
	in reverse. This places the % at the end of the query, allowing the index to be used
\*


