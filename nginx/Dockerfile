FROM debian:bullseye

# Met à jour et installe Nginx + OpenSSL
RUN apt update -y && apt upgrade -y
RUN apt install -y nginx openssl

# Crée un dossier pour les certificats SSL
RUN mkdir -p /etc/nginx/ssl

# Génère un certificat auto-signé
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/clé_privée.pem \
    -out /etc/nginx/ssl/certificat.pem \
    -subj "/CN=localhost"

# Copie la configuration Nginx
COPY cg.conf /etc/nginx/conf.d/default.conf

# Expose le port 443
EXPOSE 443

# Démarre Nginx en mode non-démon
CMD ["nginx", "-g", "daemon off;"]
