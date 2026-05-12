-- Active: 1752124648940@@127.0.0.1@3306@menagerie

use menagerie;
drop table if exists pet;
CREATE TABLE pet (name VARCHAR(20), owner VARCHAR(20),
       species VARCHAR(20), sex CHAR(1), birth DATE, death DATE);

LOAD DATA LOCAL INFILE 'C:\\Users\\qslia\\Desktop\\SQL_Practice\\tutorial\\pet.txt' INTO TABLE pet
LINES TERMINATED BY '\r\n';

INSERT INTO pet
       VALUES ('Puffball','Diane','hamster','f','1999-03-30',NULL);

SELECT * FROM pet;

DELETE FROM pet;

UPDATE pet SET birth = '1989-08-30' WHERE name = 'Bowser';

SELECT * FROM pet WHERE name = 'Bowser';

-- export to excel file, using xlsx format， excexute command on terminal
-- mysql -u root -p -D menagerie -e "SELECT * FROM pet" > C:\\Users\\qslia\\Desktop\\SQL_Practice\\tutorial\\pet2.xlsx

SELECT name, species, birth FROM pet WHERE species = 'dog' OR species = 'cat';

SELECT name, birth, CURDATE(),
       TIMESTAMPDIFF(YEAR,birth,CURDATE()) as age
       FROM pet;

SELECT name, birth, MONTH(birth) as month FROM pet;

SELECT name, birth FROM pet
       WHERE MONTH(birth) = MONTH(DATE_ADD(CURDATE(),INTERVAL 1 MONTH));

SELECT name, birth FROM pet
       WHERE MONTH(birth) = MOD(MONTH(CURDATE()), 12) + 1;