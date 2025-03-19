#!/bin/bash

# Arrêter le script en cas d'erreur critique, mais pas pour toutes les erreurs
set -eE

# Définir le chemin de l'installation de WordPress
WORDPRESS_PATH="/var/www/wordpress"

# Assurer que le dossier existe et est vide avant de commencer
mkdir -p "$WORDPRESS_PATH"
find "$WORDPRESS_PATH" -mindepth 1 -delete

echo "🔧 Configuration des permissions..."
# Définir les permissions et la propriété
chmod -R 755 "$WORDPRESS_PATH"
chown -R www-data:www-data "$WORDPRESS_PATH"

echo "📥 Téléchargement de WordPress..."
# Télécharger la dernière version de WordPress
wp core download --allow-root --path="$WORDPRESS_PATH"

echo "⏳ Attente que MariaDB soit prêt..."
# Attendre un peu que MariaDB soit prêt à accepter des connexions
sleep 10

echo "⚙️ Configuration de WordPress..."
# Configurer WordPress avec les variables passées via Docker Compose
wp core config --dbhost="mariadb:3306" --dbname="$WORDPRESS_DB_NAME" --dbuser="$WORDPRESS_DB_USER" --dbpass="$WORDPRESS_DB_PASSWORD" --allow-root --path="$WORDPRESS_PATH"

echo "🚀 Installation de WordPress..."
# Installer WordPress avec les informations d'administration fournies via Docker Compose
# Ajouter --skip-email pour éviter les erreurs d'envoi d'email
wp core install --url="$DOMAIN_NAME" --title="$WP_TITLE" \
     --admin_user="$ADMIN" --admin_password="$ADMIN_PASSWORD" --admin_email="$ADMIN_EMAIL" --allow-root --path="$WORDPRESS_PATH" --skip-email

echo "👤 Création de l'utilisateur..."
# Créer un nouvel utilisateur WordPress, en ignorant l'erreur s'il existe déjà
wp user create "$WP_USER" "$WP_EMAIL" --user_pass="$WP_PASSWORD" --role=author --allow-root --path="$WORDPRESS_PATH" || true

echo "🗑️ Nettoyage du cache..."
# Vider le cache WordPress pour éviter tout conflit
wp cache flush --allow-root --path="$WORDPRESS_PATH"

echo "🛠️ Configuration de PHP-FPM..."
# Modifier la configuration de PHP-FPM pour écouter sur le port 9000
sed -i '36 s@/run/php/php7.4-fpm.sock@9000@' /etc/php/7.4/fpm/pool.d/www.conf
mkdir -p /run/php

echo "🚀 Démarrage de PHP-FPM..."
# Démarrer PHP-FPM en mode premier plan pour que le conteneur continue à tourner
exec php-fpm7.4 -F