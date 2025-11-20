.PHONY: help build run stop clean logs test rebuild shell

# Variables
IMAGE_NAME = task-api
CONTAINER_NAME = task-api-container
PORT = 5000

# Colores para output
GREEN = \033[0;32m
YELLOW = \033[1;33m
NC = \033[0m # No Color

help: ## Muestra esta ayuda
	@echo "$(GREEN)Comandos disponibles:$(NC)"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  $(YELLOW)%-15s$(NC) %s\n", $$1, $$2}'

build: ## Construir imagen Docker
	@echo "$(YELLOW)🏗️  Construyendo imagen Docker...$(NC)"
	docker build -t $(IMAGE_NAME):latest .
	@echo "$(GREEN)✅ Imagen construida exitosamente$(NC)"

run: ## Ejecutar contenedor
	@echo "$(YELLOW)🚀 Ejecutando contenedor...$(NC)"
	docker run -d -p $(PORT):5000 --name $(CONTAINER_NAME) $(IMAGE_NAME):latest
	@echo "$(GREEN)✅ Contenedor ejecutándose en http://localhost:$(PORT)$(NC)"

stop: ## Detener contenedor
	@echo "$(YELLOW)🛑 Deteniendo contenedor...$(NC)"
	docker stop $(CONTAINER_NAME)
	@echo "$(GREEN)✅ Contenedor detenido$(NC)"

clean: stop ## Detener y eliminar contenedor
	@echo "$(YELLOW)🗑️  Eliminando contenedor...$(NC)"
	docker rm $(CONTAINER_NAME)
	@echo "$(GREEN)✅ Contenedor eliminado$(NC)"

logs: ## Ver logs del contenedor
	@echo "$(YELLOW)📋 Mostrando logs (Ctrl+C para salir)...$(NC)"
	docker logs -f $(CONTAINER_NAME)

test: ## Ejecutar tests
	@echo "$(YELLOW)🧪 Ejecutando tests...$(NC)"
	docker run --rm $(IMAGE_NAME):latest pytest test_app.py -v

rebuild: clean build run ## Reconstruir completamente

shell: ## Acceder al shell del contenedor
	@echo "$(YELLOW)🐚 Accediendo al contenedor...$(NC)"
	docker exec -it $(CONTAINER_NAME) /bin/bash

ps: ## Ver contenedores activos
	@echo "$(YELLOW)📊 Contenedores activos:$(NC)"
	docker ps

prune: ## Limpiar imágenes no usadas
	@echo "$(YELLOW)🧹 Limpiando...$(NC)"
	docker image prune -f
	@echo "$(GREEN)✅ Limpieza completada$(NC)"

compose-up: ## Iniciar con docker-compose
	@echo "$(YELLOW)🚀 Iniciando con docker-compose...$(NC)"
	docker-compose up -d
	@echo "$(GREEN)✅ Aplicación corriendo$(NC)"

compose-down: ## Detener docker-compose
	@echo "$(YELLOW)🛑 Deteniendo docker-compose...$(NC)"
	docker-compose down
	@echo "$(GREEN)✅ Aplicación detenida$(NC)"

compose-logs: ## Ver logs de docker-compose
	@echo "$(YELLOW)📋 Logs de docker-compose...$(NC)"
	docker-compose logs -f

dev: ## Modo desarrollo sin Docker
	@echo "$(YELLOW)💻 Iniciando en modo desarrollo...$(NC)"
	python app.py
