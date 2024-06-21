FROM debian:bullseye

RUN apt update -y && apt upgrade -y && apt-get install -y mariadb-server \
	curl

RUN apt-get install systemd -y

COPY conf/configuration.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

COPY tools/script_mariadb.sh /usr/local/bin/script_mariadb.sh

RUN chmod +x /usr/local/bin/script_mariadb.sh

EXPOSE 3306

CMD ["/usr/local/bin/script_mariadb.sh"]
