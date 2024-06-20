#!/bin/sh

# Create necessary directories and set permissions
mkdir -p /run/mysqld
chown -R mysql:mysql /run/mysqld

# Ensure the data directory exists and has the correct permissions
chown -R mysql:mysql /var/lib/mysql

# Start MariaDB without networking to allow initial setup
mysqld_safe --skip-networking --skip-grant-tables &
pid="$!"

# Wait for MariaDB to be fully up and running
while ! mysqladmin ping --silent; do
    echo "Waiting for MariaDB to be up and running..."
    sleep 3
done

# Set root password // modify root password
mysql -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';"

# Restart MariaDB with networking
mysqladmin -u root -p"${SQL_ROOT_PASSWORD}" shutdown

# Wait for shutdown to complete
sleep 10

# Start MariaDB normally
mysqld_safe &

# Wait for MariaDB to be fully up and running again
while ! mysqladmin ping --silent; do
    echo "Waiting for MariaDB to be up and running..."
    sleep 3
done

# create database // user with password // give privileges
mysql -u root -p"${SQL_ROOT_PASSWORD}" -e "CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;"
mysql -u root -p"${SQL_ROOT_PASSWORD}" -e "CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASSWORD}';"
mysql -u root -p"${SQL_ROOT_PASSWORD}" -e "GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'%';"

# reload database
mysql -u root -p"${SQL_ROOT_PASSWORD}" -e "FLUSH PRIVILEGES;"

#shutdown
mariadb-admin -u root -p"${SQL_ROOT_PASSWORD}" shutdown

sleep 10

# restart in safe mode
exec mysqld_safe