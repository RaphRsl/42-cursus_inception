#!/bin/sh

	
# create a self-signed SSL certificate
	# req: PKCS#10 format certificate request and certificate generating utility	
	# -nodes: no passphrase
	# -x509: output a self-signed certificate instead of a certificate request
	# -out: output file / -keyout: private key file
	# -subj: who is the certificate for
openssl req -x509 -nodes -keyout ${KEYS} -out ${CERTS} -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=${DOMAIN_NAME}/UID=${USER}"

sed -i "s/domain_name/${DOMAIN_NAME}/g" "/etc/nginx/nginx.conf"

# Launch nginx
nginx -g "daemon off;"
