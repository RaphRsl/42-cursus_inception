FROM debian:bullseye

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get upgrade -y

RUN apt-get install -y --no-install-recommends wget ca-certificates php7.4 php-fpm php-mysql mariadb-client

# Update CA certificates
RUN update-ca-certificates

# Install wordpress and give permissions
RUN wget https://wordpress.org/wordpress-6.0.tar.gz -P /var/www \
	&& cd /var/www && tar -xzf wordpress-6.0.tar.gz && rm wordpress-6.0.tar.gz \
	&& chown -R www-data:www-data /var/www/wordpress

# Conf PHP
COPY ./conf/php.conf /etc/php/7.4/fpm/pool.d/www.conf



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
