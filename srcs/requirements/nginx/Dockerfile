FROM debian:bullseye

RUN apt update -y && \
    apt upgrade -y && \
    apt install -y nginx openssl && \
    mkdir -p /etc/nginx/ssl /var/run/nginx && \
    openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=kboulkri.42.fr/UID=kboulkri" && \
    chmod 777 /etc/nginx/ssl/inception.crt /etc/nginx/ssl/inception.key

COPY conf/nginx.conf /etc/nginx/nginx.conf

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]