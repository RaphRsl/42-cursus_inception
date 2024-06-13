FROM debian:bullseye

RUN apt-get update && apt-get upgrade -y
RUN apt-get install mariadb-server -y

COPY conf/50-server.cnf	/etc/mysql/mariadb.conf.d/50-server.cnf
COPY conf/mdb_script_config.sh /mdb_script_config.sh

# my bash script to configure the sql database
ENTRYPOINT ["bash", "mdb_script_config.sh"]

EXPOSE 3306