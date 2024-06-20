#!bin/bash

#wait to be sure that the database is ready
sleep 30

cd /var/www/wordpress

# Retry mechanism for database connection
MAX_RETRIES=10
RETRIES=0
until wp config create --allow-root \
                       --dbname=$SQL_DATABASE \
                       --dbuser=$SQL_USER \
                       --dbpass=$SQL_PASSWORD \
                       --dbhost=mariadb:3306 --path='/var/www/wordpress' || [ $RETRIES -eq $MAX_RETRIES ]; do
  echo "Waiting for database to be ready..."
  RETRIES=$((RETRIES + 1))
  sleep 5
done

if [ ! -e /var/www/wordpress/wp-config.php ]; then
    echo "wordpress is not installed yet"
	wp config create	--allow-root \
						--dbname=$SQL_DATABASE \
						--dbuser=$SQL_USER \
						--dbpass=$SQL_PASSWORD \
    					--dbhost=mariadb:3306 --path='/var/www/wordpress' || { echo "ERROR - wp config create failed"; exit 1; }

	sleep 2

	wp core install     --url=$DOMAIN_NAME \
						--title=$SITE_TITLE \
						--admin_user=$ADMIN_USER \
						--admin_password=$ADMIN_PASSWORD \
						--admin_email=$ADMIN_EMAIL \
						--allow-root \
						--path='/var/www/wordpress' || { echo "ERROR - wp core install failed"; exit 1; }

	wp user create      --allow-root \
						--role=author $USER1_LOGIN $USER1_MAIL \
						--user_pass=$USER1_PASS \
						--path='/var/www/wordpress' >> /log.txt

    wp theme install hestia --activate --allow-root --path="/var/www/wordpress" || { echo "wp theme install failed"; exit 1; }
fi

# Create folder /run/php if not exist
if [ ! -d /run/php ]; then
    mkdir -p /run/php
    chown -R www-data:www-data /run/php
fi

# start php-fpm
/usr/sbin/php-fpm7.4 -F