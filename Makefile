SHELL := /bin/bash

APP_PORT ?= 8088
COMPOSE ?= docker compose

.PHONY: help
help:
	@echo "Available targets:"
	@echo "  make up            - Start services in detached mode"
	@echo "  make up-build      - Build and start services"
	@echo "  make down          - Stop and remove services"
	@echo "  make restart       - Restart full stack"
	@echo "  make ps            - Show running containers"
	@echo "  make logs          - Stream compose logs"
	@echo "  make config        - Validate compose config"
	@echo "  make build-backend - Build backend image"
	@echo "  make build-frontend- Build frontend image"
	@echo "  make test          - Run backend tests"
	@echo "  make health        - Check API health endpoint"

.PHONY: up
up:
	@APP_PORT=$(APP_PORT) $(COMPOSE) up -d

.PHONY: up-build
up-build:
	@APP_PORT=$(APP_PORT) $(COMPOSE) up -d --build

.PHONY: down
down:
	@$(COMPOSE) down

.PHONY: restart
restart: down up

.PHONY: ps
ps:
	@$(COMPOSE) ps

.PHONY: logs
logs:
	@$(COMPOSE) logs -f --tail=200

.PHONY: config
config:
	@$(COMPOSE) config

.PHONY: build-backend
build-backend:
	@$(COMPOSE) build backend

.PHONY: build-frontend
build-frontend:
	@$(COMPOSE) build frontend

.PHONY: test
test:
	@cd backend && go test ./...

.PHONY: health
health:
	@curl -s http://localhost:$(APP_PORT)/api/v1/health
