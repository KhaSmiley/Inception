#!/bin/bash 

sleep 10

wp config create --allow-root \
    --dbname=$SQL_DATABASE \
    --dbuser=$SQL_USER \
    --dbpass=$SQL_PASSWORD \
    --dbhost=mariadb:3306 --path='/var/www/html/wordpress'

wp core install --allow-root \
    --url=https://kboulkri.42.fr \
    --title="Inception" \
    --admin_user=$WP_ADMIN_USER \
    --admin_password=$WP_ADMIN_PASSWORD \
    --admin_email=$WP// filepath: /home/inception/inception/srcs/requirements/wordpress/conf/config.sh
#!/bin/bash 

sleep 10

wp config create --allow-root \
    --dbname=$SQL_DATABASE \
    --dbuser=$SQL_USER \
    --dbpass=$SQL_PASSWORD \
    --dbhost=mariadb:3306 --path='/var/www/html/wordpress'

wp core install --allow-root \
    --url=https://kboulkri.42.fr \
    --title="Inception" \
    --admin_user=$WP_ADMIN_USER \
    --admin_password=$WP_ADMIN_PASSWORD \
    --admin_email=$WP