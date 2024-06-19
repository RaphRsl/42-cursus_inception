FROM debian:bullseye

RUN apt-get update && apt-get upgrade -y
RUN apt-get -y install wget

RUN apt-get install -y wget php7.3 php7.3-fpm php7.3-mysql mariadb-client

# Install wordpress
RUN wget https://wordpress.org/wordpress-6.0.tar.gz -P /var/www
RUN cd /var/www && tar -xzf wordpress-6.0.tar.gz && rm wordpress-6.0.tar.gz

# Conf PHP
COPY ./conf/php.conf /etc/php/7.3/fpm/pool.d/www.conf

RUN chown -R www-data:www-data /var/www/wordpress


# Conf Wordpress
	# wp-cli = interface ligne de commande pour configurer wordpress
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp

COPY conf/wp_script_config.sh wp_script_config.sh

# Ensure the script is executable
RUN chmod +x /wp_script_config.sh

ENTRYPOINT ["bash", "wp_script_config.sh"]

# Expose port 9000 for PHP-FPM
EXPOSE 9000
