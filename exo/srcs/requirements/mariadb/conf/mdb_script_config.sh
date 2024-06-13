#!/bin/sh

# start sql
service mysql start;

# create database // user with password // give privileges // modify root password
mysql -e "CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;"
mysql -e "CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'localhost' IDENTIFIED BY '${SQL_PASSWORD}';"
mysql -e "GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASSWORD}';"
mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';"

# reload database
mysql -e "FLUSH PRIVILEGES;"

#shutdown
mysqladmin -u root -p$SQL_ROOT_PASSWORD shutdown

# restart
exec mysqld_safe