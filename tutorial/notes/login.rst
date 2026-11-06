mysql -h localhost -u root -p  

mysql -h localhost -u root -p -e "SELECT DISTINCT trade_date FROM stock_prices ORDER BY trade_date;" stock_db > output.csv

mysql -h localhost -u root -p stock_db -e "SELECT sub_industry, GROUP_CONCAT(name) AS names FROM stock_info GROUP BY sub_industry;" > output.csv


.. mysqldump -u root -p stock_db > stock_db.sql
mysqldump -u root -p --default-character-set=utf8 stock_db > stock_db.sql
gzip .\stock_db.sql .\stock_db.sql.gz
winget install -e --id GnuWin32.Gzip
$env:Path = $env:Path + ";C:\Program Files (x86)\GnuWin32\bin"
gzip -d .\stock_db.sql.gz
gunzip .\stock_db.sql.gz or gzip -d .\stock_db.sql.gz
CREATE DATABASE stock_db;

mysql -u root -p stock_db < stock_db.sql  // run on cmd
