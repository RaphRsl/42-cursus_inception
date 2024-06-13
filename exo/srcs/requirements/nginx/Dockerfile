FROM debian:bullseye

# -y to force YES
RUN apt-get update && apt-get upgrade -y
RUN apt install nginx -y
RUN apt install vim -y
RUN apt install curl -y

# For secure connection with TLS
	# create a directory for the SSL certificate and key and install openssl
RUN mkdir -p /etc/nginx/ssl
RUN apt-get install openssl -y
	# create a self-signed SSL certificate
		# req: PKCS#10 format certificate request and certificate generating utility	
		# -nodes: no passphrase
		# -x509: output a self-signed certificate instead of a certificate request
		# -out: output file / -keyout: private key file
		# -subj: who is the certificate for
RUN openssl req -newkey rsa:4096 -days 42 -nodes -x509 \
-out /etc/ssl/certs/inception.crt \
-keyout /etc/ssl/private/inception.key \
-subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=rroussel.42.fr/UID=rroussel"

# Copy the configuration file
COPY conf/nginx.conf /etc/nginx/nginx.conf

# Give permissions to root user // main user
RUN chmod 755 /var/www/html
RUN chown -R www-data:www-data /var/www/html

# Launch nginx
CMD [ "nginx", "-g", "daemon off;" ]
