FROM debian:bullseye

ENV DEBIAN_FRONTEND=noninteractive

# Update and install MariaDB server
RUN apt-get update && apt-get upgrade -y && apt-get install -y mariadb-server

# Copy configuration files
COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY conf/mdb_script_config.sh /usr/local/bin/mdb_script_config.sh

# Ensure the script is executable
RUN chmod +x /usr/local/bin/mdb_script_config.sh

# Create necessary directories and set permissions
RUN mkdir -p /run/mysqld && chown -R mysql:mysql /run/mysqld

# Copy .env file
# COPY ../../.env /root/.env

# Export environment variables
RUN export $(cat /root/.env | xargs)

# my bash script to configure the sql database
ENTRYPOINT ["bash", "mdb_script_config.sh"]

EXPOSE 3306
