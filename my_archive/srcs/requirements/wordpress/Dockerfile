FROM debian:bullseye

RUN apt update -y && apt upgrade -y && apt install -y php7.4 \
		php-mysql \
		php-fpm \
		php-intl \
		php-curl \
		mariadb-client \
		wget

RUN wget https://wordpress.org/wordpress-6.4.3.tar.gz -P /var/www && \
	tar -xvf /var/www/wordpress-6.4.3.tar.gz -C /var/www && \
	rm -rf /var/www/wordpress-6.4.3.tar.gz && \
	mv /var/www/wordpress /var/www/html

RUN chown -R root:root /var/www/html

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
	chmod +x wp-cli.phar && \
	mv wp-cli.phar /usr/local/bin/wp

EXPOSE 9000

COPY tools/script_wordpress.sh tools/script_wordpress.sh

RUN chmod +x tools/script_wordpress.sh

COPY conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf

RUN mkdir /run/php

RUN chmod 755 /run/php

ENTRYPOINT ["bash", "tools/script_wordpress.sh"]

