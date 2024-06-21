FROM debian:bullseye

RUN apt update -y && apt upgrade -y && apt install -y nginx

RUN mkdir -p /etc/nginx/ssl

RUN apt install -y openssl

RUN mkdir -p /var/run/nginx

COPY /conf/configuration /etc/nginx/nginx.conf

RUN chmod 755 /var/www/html

RUN chown -R www-data:www-data /var/www/html

COPY tools/script_nginx.sh /usr/local/bin/script_nginx.sh

RUN chmod +x /usr/local/bin/script_nginx.sh

CMD ["/usr/local/bin/script_nginx.sh"]
