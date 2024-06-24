FROM debian:bullseye

# -y to force YES
RUN apt update -y && apt upgrade -y && apt install -y nginx

# create a directory for the SSL certificate and key and install openssl
RUN mkdir -p /etc/nginx/ssl
RUN apt install -y openssl

RUN mkdir -p /var/run/nginx

# Copy the configuration file
COPY /conf/nginx.conf /etc/nginx/nginx.conf

# Give permissions to root user // main user
RUN chmod 755 /var/www/html
RUN chown -R www-data:www-data /var/www/html

# Copy the script file
COPY tools/script_nginx.sh /usr/local/bin/script_nginx.sh
RUN chmod +x /usr/local/bin/script_nginx.sh

CMD ["/usr/local/bin/script_nginx.sh"]
