FROM debian:bullseye

RUN apt update -y && \
    apt upgrade -y && \
    apt-get install -y wget php7.3 php-fpm php-mysql mariadb-client && \
    wget https://wordpress.org/wordpress-6.1.1.tar.gz -P /var/www/html && \
    cd /var/www/html && \
    tar -xzf /var/www/html/wordpress-6.1.1.tar.gz && \
    rm /var/www/html/wordpress-6.1.1.tar.gz && \
    chown -R root:root /var/www/html/wordpress && \
    wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

COPY conf/config.sh /
RUN chmod +x /config.sh

ENTRYPOINT ["./config.sh"]