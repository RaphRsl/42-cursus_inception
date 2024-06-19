FROM debian:bullseye

# Update and install MariaDB server
RUN apt-get update && apt-get upgrade -y && apt-get install -y mariadb-server

# Copy configuration files
COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY conf/mdb_script_config.sh /mdb_script_config.sh

# Ensure the script is executable
RUN chmod +x /mdb_script_config.sh

# my bash script to configure the sql database
ENTRYPOINT ["bash", "mdb_script_config.sh"]

EXPOSE 3306
