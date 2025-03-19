FROM debian:bullseye

# Installation des paquets nécessaires et nettoyage du cache
RUN apt-get update && apt-get install -y \
    mariadb-server \
    mariadb-client \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install -y sudo
# Création des répertoires nécessaires si absents
RUN mkdir -p /var/run/mysqld \
    && chown -R mysql:mysql /var/run/mysqld \
    && chmod 777 /var/run/mysqld

# Copie des fichiers de configuration
COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY tools/init_db.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/init_db.sh

# Exposition du port MySQL
EXPOSE 3306

# Commande de démarrage
ENTRYPOINT ["/usr/local/bin/init_db.sh"]