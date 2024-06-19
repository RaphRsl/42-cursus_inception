FROM debian:bullseye

# Set environment variables to non-interactive to avoid errors during installation
ENV DEBIAN_FRONTEND=noninteractive

# -y to force YES
# For secure connection with TLS
	# create a directory for the SSL certificate and key and install openssl
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y nginx vim curl openssl && \
    mkdir -p /etc/nginx/ssl && \
    apt-get clean && rm -rf /var/lib/apt/lists/*
	
# create a self-signed SSL certificate
	# req: PKCS#10 format certificate request and certificate generating utility	
	# -nodes: no passphrase
	# -x509: output a self-signed certificate instead of a certificate request
	# -out: output file / -keyout: private key file
	# -subj: who is the certificate for
RUN openssl req -newkey rsa:4096 -days 42 -nodes -x509 \
	-out /etc/nginx/ssl/inception.crt \
	-keyout /etc/nginx/ssl/inception.key \
	-subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=rroussel.42.fr/UID=rroussel"

# Copy the configuration file
COPY conf/nginx.conf /etc/nginx/nginx.conf

# Give permissions to root user // main user
# Ensure the directory exists before setting permissions
RUN mkdir -p /var/www/html && \
    chmod 755 /var/www/html && \
    chown -R www-data:www-data /var/www/html

# Launch nginx
CMD [ "nginx", "-g", "daemon off;" ]

