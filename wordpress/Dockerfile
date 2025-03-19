FROM debian:bullseye

# Mise à jour des paquets et installation des outils nécessaires
RUN apt-get update && apt-get upgrade -y

# Installation de PHP 7.4 et autres outils nécessaires depuis les dépôts Debian officiels
RUN apt-get install -y wget php7.4 php7.4-fpm php7.4-mysql mariadb-client zsh git curl netcat mycli

# Installer WP-CLI
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/ \
    && ln -s /usr/local/bin/wp-cli.phar /usr/local/bin/wp

# Exposer le port pour PHP-FPM
EXPOSE 9000

# Copier le script de configuration
COPY wordpress.sh /usr/local/bin/wordpress.sh
RUN chmod +x /usr/local/bin/wordpress.sh

# Définir le point d'entrée
ENTRYPOINT ["/usr/local/bin/wordpress.sh"]
