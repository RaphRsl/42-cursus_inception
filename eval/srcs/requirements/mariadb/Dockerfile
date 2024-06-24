FROM debian:bullseye

# Update and install MariaDB server
RUN apt update -y && apt upgrade -y && apt-get install -y mariadb-server \
	curl

RUN apt-get install systemd -y

# Copy configuration file
COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

# Copy script file / Ensure the script is executable
COPY tools/script_mariadb.sh /usr/local/bin/script_mariadb.sh
RUN chmod +x /usr/local/bin/script_mariadb.sh

EXPOSE 3306

# launch my bash script to configure the sql database
CMD ["/usr/local/bin/script_mariadb.sh"]
