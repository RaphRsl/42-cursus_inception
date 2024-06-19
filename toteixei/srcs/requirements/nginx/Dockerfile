FROM debian:bullseye

RUN apt update && apt upgrade
RUN apt-get install nginx openssl -y

COPY conf/nginx.conf /etc/nginx/conf.d

RUN mkdir /etc/nginx/ssl
RUN openssl req -x509 -sha256 -nodes -days 365 -newkey rsa:4096 \
    -keyout /etc/nginx/ssl/ssl_toteixei.key \
    -out /etc/nginx/ssl/ssl_toteixei.pem \
    -subj "/C=FR/ST=Paris/L=Paris/O=42 School/OU=toteixei/CN=toteixei/"

EXPOSE 443

RUN mkdir -p /run/nginx

CMD ["nginx", "-g", "daemon off;"]