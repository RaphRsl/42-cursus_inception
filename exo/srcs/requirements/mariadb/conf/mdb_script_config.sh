#!/bin/sh

# start sql
service mysql start

# Wait for MariaDB to be fully up and running
while ! mysqladmin ping --silent; do
    echo "Waiting for MariaDB to be up and running..."
    sleep 2
done

# create database // user with password // give privileges // modify root password
mysql -e "CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;"
mysql -e "CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASSWORD}';" # @'localhost': This specifies that the user can only connect from the local machine (inside the same container) = ERROR
mysql -e "GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASSWORD}';"
mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';"

# reload database
mysql -e "FLUSH PRIVILEGES;"

#shutdown
mysqladmin -u root -p"${SQL_ROOT_PASSWORD}" shutdown


# restart in safe mode
exec mysqld_safe