mysql -h localhost -u root -p  

mysql -h localhost -u root -p -e "SELECT DISTINCT trade_date FROM stock_prices ORDER BY trade_date;" stock_db > output.csv

mysql -h localhost -u root -p stock_db -e "SELECT sub_industry, GROUP_CONCAT(name) AS names FROM stock_info GROUP BY sub_industry;" > output.csv