-- USE studentmanagement;
-- The table must already exist in the database.
-- If not, uncomment and run the following first:
-- CREATE TABLE employees (
--   id INT PRIMARY KEY,
--   name VARCHAR(100),
--   age INT,
--   email VARCHAR(100)
-- );
LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 9.3\\Uploads\\employees.csv' INTO TABLE employees FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\r\n' -- use '\n' if your file is LF-only
IGNORE 1 ROWS;
-- put this sql file under project_sql, then run it in mysql workbench, it will load the csv file into the employees table