#!/bin/sh

# Print environment variables to verify they are loaded
echo "SQL_ROOT_PASSWORD: ${SQL_ROOT_PASSWORD}"
echo "SQL_DATABASE: ${SQL_DATABASE}"
echo "SQL_USER: ${SQL_USER}"
echo "SQL_PASSWORD: ${SQL_PASSWORD}"

# Create necessary directories and set permissions
mkdir -p /run/mysqld
chown -R mysql:mysql /run/mysqld

# Ensure the data directory exists and has the correct permissions
chown -R mysql:mysql /var/lib/mysql

# Start MariaDB without grant tables to set the root password
echo "Starting MariaDB without grant tables..."
mysqld_safe --skip-grant-tables &
pid="$!"

# Wait for MariaDB to be fully up and running
while ! mysqladmin ping --silent; do
    echo "Waiting for MariaDB to be up and running..."
    sleep 3
done

# Set the root password using an alternative method
echo "Setting root password using alternative method..."
mysql -u root <<-EOSQL
    UPDATE mysql.user SET authentication_string=PASSWORD('${SQL_ROOT_PASSWORD}') WHERE User='root' AND Host='localhost';
    FLUSH PRIVILEGES;
EOSQL

# Shut down MariaDB to apply the root password
echo "Shutting down MariaDB..."
mysqladmin shutdown

# Wait for shutdown to complete
sleep 5

# Start MariaDB service normally
echo "Starting MariaDB service normally..."
mysqld_safe &
pid="$!"

# Wait for MariaDB to be fully up and running again
while ! mysqladmin ping -u root -p"${SQL_ROOT_PASSWORD}" --silent; do
    echo "Waiting for MariaDB to be up and running after restart..."
    sleep 3
done

# Create the database if it doesn't exist
echo "Creating database if it doesn't exist..."
mysql -u root -p"${SQL_ROOT_PASSWORD}" <<-EOSQL
    CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;
EOSQL

# Create the user if it doesn't exist
echo "Creating user if it doesn't exist..."
mysql -u root -p"${SQL_ROOT_PASSWORD}" <<-EOSQL
    CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'localhost' IDENTIFIED BY '${SQL_PASSWORD}';
EOSQL

# Grant all privileges to the user on the database
echo "Granting privileges..."
mysql -u root -p"${SQL_ROOT_PASSWORD}" <<-EOSQL
    GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'%';
EOSQL

# Flush privileges to ensure changes take effect
echo "Flushing privileges..."
mysql -u root -p"${SQL_ROOT_PASSWORD}" <<-EOSQL
    FLUSH PRIVILEGES;
EOSQL

# Shut down the MariaDB service
echo "Shutting down MariaDB service..."
mysqladmin -u root -p"${SQL_ROOT_PASSWORD}" shutdown

# Wait for shutdown to complete
sleep 10

# Restart MariaDB in safe mode
exec mysqld_safe
