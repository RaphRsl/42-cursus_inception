#!/bin/bash

# Start MariaDB service
service mariadb start

# Wait to be sure it's running
sleep 10

# Create the database (if it doesn't exist)
echo "Creating database (if it doesn't exist)..."
mariadb  -e "CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;"

# Create the user (if it doesn't exist)
echo "Creating user (if it doesn't exist)..."
mariadb  -e "CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'localhost' IDENTIFIED BY '${SQL_PASSWORD}';"

# Giving all privileges on the database to the user
echo "Granting privileges on the database..."
mariadb  -e "GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASSWORD}' WITH GRANT OPTION;"

# Change root password
echo "Changing root password..."
mariadb -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';"

# Flush privileges to make sure changes are taken into account
echo "Flushing privileges..."
mariadb -p${SQL_ROOT_PASSWORD} -e "FLUSH PRIVILEGES;"

# Shut down MariaDB service
echo "Shutting down MariaDB service..."
mariadb-admin -u root -p"${SQL_ROOT_PASSWORD}" shutdown

# Wait to be sure it's not runnign anymore
sleep 10

# Restart MariaDB service in safe mode
exec mysqld_safe
 