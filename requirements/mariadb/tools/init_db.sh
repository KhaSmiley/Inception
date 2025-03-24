#!/bin/bash
# Vérifier si la base de données existe déjà
if [ -d "/var/lib/mysql/mysql" ]; then
    echo "La base de données existe déjà, vérification des permissions..."
    
    # Démarrage temporaire du serveur MySQL
    echo "Démarrage du serveur temporaire..."
    mysqld --user=mysql &
    
    # Attente que le service soit disponible
    echo "Attente de la disponibilité du serveur..."
    sleep 10
    
    # Vérification et ajout des permissions si nécessaire
    mysql -u root -p${MYSQL_ROOT_PASSWORD} << EOF
    CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};
    CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
    CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'localhost' IDENTIFIED BY '${MYSQL_PASSWORD}';
    GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';
    GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'localhost';
    FLUSH PRIVILEGES;
EOF
    
    # Arrêt propre du service temporaire
    echo "Arrêt du serveur temporaire..."
    mysqladmin -u root -p${MYSQL_ROOT_PASSWORD} shutdown
    
    echo "Démarrage direct..."
    exec mysqld_safe --user=mysql
    exit 0
fi
# Le reste de votre script reste inchangé...