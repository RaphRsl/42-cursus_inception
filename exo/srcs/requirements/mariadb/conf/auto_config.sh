#!/bin/sh

#start my sql service
service mysql start;

# create a database (if the database does not exist)
mysql -e "CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;"

# create an user with a password (if the user does not exist)
mysql -e "CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'localhost' IDENTIFIED BY '${SQL_PASSWORD}';"

# give all privileges to the user
mysql -e "GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASSWORD}';"

#modify sql database
mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';"

#reload the database
mysql -e "FLUSH PRIVILEGES;"

#shutdown
mysqladmin -u root -p$SQL_ROOT_PASSWORD shutdown

#use exec to 
exec mysqld_safe