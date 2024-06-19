FROM debian:bullseye

RUN apt-get update -y
RUN apt-get install -y mariadb-server mariadb-client

COPY conf/50-server.cnf /etc/mysql/mariadb.conf.daemon
COPY tool/init.sql /etc/mysql/init.sql

RUN mkdir /run/mysqld

CMD ["mysqld"]