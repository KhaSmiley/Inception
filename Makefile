# Variables
DC := docker-compose
DATA_DIR := /home/kboulkri/data
SSL_DIR := /home/kboulkri/inception/srcs/requirements/nginx/ssl

# Couleurs pour une meilleure lisibilité
GREEN := \033[0;32m
YELLOW := \033[0;33m
BLUE := \033[0;34m
RED := \033[0;31m
NC := \033[0m # No Color

# Règles principales
.PHONY: all stop start down clean fclean re logs help purge_volumes force_clean

all: setup
	@echo "${GREEN}Démarrage des services...${NC}"
	@docker ps -q | grep . || sudo $(DC) up --build -d

setup:
	@echo "${BLUE}Configuration des répertoires...${NC}"
	@sudo mkdir -p $(DATA_DIR)/mariadb
	@sudo mkdir -p $(DATA_DIR)/wordpress

purge_volumes:
	@echo "${RED}Suppression des volumes existants...${NC}"
	@sudo docker volume rm -f inception_mariadb_data 2>/dev/null || true
	@sudo docker volume rm -f inception_wordpress_data 2>/dev/null || true
	@echo "${GREEN}Volumes supprimés avec succès (ou inexistants).${NC}"

force_clean:
	@echo "${RED}Arrêt de tous les conteneurs...${NC}"
	@sudo docker stop $$(sudo docker ps -aq) 2>/dev/null || true
	@echo "${RED}Suppression de tous les conteneurs...${NC}"
	@sudo docker rm $$(sudo docker ps -aq) 2>/dev/null || true
	@echo "${RED}Suppression de tous les volumes...${NC}"
	@sudo docker volume rm $$(sudo docker volume ls -q) 2>/dev/null || true
	@echo "${YELLOW}Suppression des données...${NC}"
	@sudo rm -rf $(DATA_DIR)
	@sudo mkdir -p $(DATA_DIR)/mariadb
	@sudo mkdir -p $(DATA_DIR)/wordpress
	@echo "${GREEN}Nettoyage forcé terminé.${NC}"

stop:
	@echo "${YELLOW}Arrêt des services...${NC}"
	@sudo $(DC) stop

start:
	@echo "${GREEN}Redémarrage des services...${NC}"
	@sudo $(DC) start

down:
	@echo "${YELLOW}Arrêt et suppression des services...${NC}"
	@sudo $(DC) down

clean:
	@echo "${YELLOW}Nettoyage des conteneurs, images, réseaux et volumes...${NC}"
	@sudo $(DC) down --rmi all --volumes

fclean: clean
	@echo "${YELLOW}Nettoyage complet du système...${NC}"
	@sudo docker system prune -a --volumes -f
	@echo "${YELLOW}Suppression des données...${NC}"
	@sudo rm -rf $(DATA_DIR)
	@sudo rm -rf $(SSL_DIR)
	@echo "${GREEN}Nettoyage terminé.${NC}"

re: fclean all

logs:
	@echo "${BLUE}Affichage des logs...${NC}"
	@sudo $(DC) logs --follow

# Afficher l'aide avec des couleurs et une meilleure organisation
help:
	@echo "\n${BLUE}=== AIDE POUR UTILISER LE MAKEFILE ===${NC}\n"
	@echo "${GREEN}make${NC}\t\t\t- Configurer et démarrer tous les services"
	@echo "${YELLOW}make stop${NC}\t\t- Arrêter les services sans les supprimer"
	@echo "${GREEN}make start${NC}\t\t- Redémarrer les services après arrêt"
	@echo "${YELLOW}make down${NC}\t\t- Arrêter et supprimer les services"
	@echo "${YELLOW}make clean${NC}\t\t- Nettoyer conteneurs, images, réseaux et volumes"
	@echo "${YELLOW}make fclean${NC}\t\t- Nettoyage complet (volumes, données et dossiers)"
	@echo "${RED}make purge_volumes${NC}\t- Supprimer les volumes existants pour résoudre les conflits"
	@echo "${RED}make force_clean${NC}\t- Nettoyage forcé de tous les conteneurs et volumes Docker"
	@echo "${GREEN}make re${NC}\t\t- Effectuer un nettoyage complet puis redémarrer"
	@echo "${BLUE}make logs${NC}\t\t- Afficher les logs des services en temps réel"
	@echo "\n"