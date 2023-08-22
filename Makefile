SHELL := /bin/bash

CONSOLE := php bin/console

update: ## Met à jour l'application après un git pull
	composer install
	npm run build
	$(CONSOLE) cache:clear
	symfony serve -d
.PHONY: update

init-db: ## Supprime et recrée la base de données
	$(CONSOLE) d:d:d --force
	$(CONSOLE) d:d:c
	symfony console make:migration
	$(CONSOLE) d:m:m --no-interaction
.PHONY: init-db

help: ## Si tu ne sais plus quelle commande faire
	@echo "Utilisation: make [command]"
	@echo ""
	@echo "Commandes existantes:"
	@echo ""
	@awk 'BEGIN {FS = ":.*?## "}/^[a-zA-Z_-]+:.*?## / {    printf "  \033[1;32m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)
	@echo ""