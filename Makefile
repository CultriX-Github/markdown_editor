# Enhanced Markdown Editor - Docker Makefile
# Created by MiniMax Agent

# Variables
IMAGE_NAME = enhanced-markdown-editor
CONTAINER_NAME = enhanced-markdown-editor
TAG = latest
PORT = 8080

# Default target
.PHONY: help
help:
	@echo "🚀 Enhanced Markdown Editor - Docker Commands"
	@echo ""
	@echo "Available commands:"
	@echo "  build       - Build the Docker image"
	@echo "  run         - Run the container"
	@echo "  stop        - Stop the container"
	@echo "  restart     - Restart the container"
	@echo "  logs        - View container logs"
	@echo "  shell       - Open shell in container"
	@echo "  clean       - Remove container and image"
	@echo "  status      - Show container status"
	@echo "  health      - Check health endpoint"
	@echo "  up          - Start with docker-compose"
	@echo "  down        - Stop with docker-compose"
	@echo ""
	@echo "🔗 Access the editor at: http://localhost:$(PORT)"

# Build the Docker image
.PHONY: build
build:
	@echo "🔨 Building Docker image..."
	docker build -t $(IMAGE_NAME):$(TAG) .
	@echo "✅ Build completed!"

# Run the container
.PHONY: run
run:
	@echo "🚀 Starting container..."
	@docker rm -f $(CONTAINER_NAME) 2>/dev/null || true
	docker run -d \
		--name $(CONTAINER_NAME) \
		-p $(PORT):80 \
		--restart unless-stopped \
		$(IMAGE_NAME):$(TAG)
	@echo "✅ Container started!"
	@echo "🔗 Access at: http://localhost:$(PORT)"

# Stop the container
.PHONY: stop
stop:
	@echo "🛑 Stopping container..."
	@docker stop $(CONTAINER_NAME) 2>/dev/null || true
	@echo "✅ Container stopped!"

# Restart the container
.PHONY: restart
restart: stop run

# View container logs
.PHONY: logs
logs:
	@echo "📋 Container logs:"
	docker logs -f $(CONTAINER_NAME)

# Open shell in container
.PHONY: shell
shell:
	@echo "🔧 Opening shell in container..."
	docker exec -it $(CONTAINER_NAME) sh

# Clean up container and image
.PHONY: clean
clean:
	@echo "🧹 Cleaning up..."
	@docker stop $(CONTAINER_NAME) 2>/dev/null || true
	@docker rm $(CONTAINER_NAME) 2>/dev/null || true
	@docker rmi $(IMAGE_NAME):$(TAG) 2>/dev/null || true
	@echo "✅ Cleanup completed!"

# Show container status
.PHONY: status
status:
	@echo "📊 Container status:"
	@docker ps | grep $(CONTAINER_NAME) || echo "Container not running"

# Check health endpoint
.PHONY: health
health:
	@echo "🏥 Checking health..."
	@curl -f http://localhost:$(PORT)/health 2>/dev/null && echo "✅ Healthy" || echo "❌ Unhealthy"

# Docker Compose commands
.PHONY: up
up:
	@echo "🚀 Starting with docker-compose..."
	docker-compose up -d
	@echo "✅ Services started!"
	@echo "🔗 Access at: http://localhost:$(PORT)"

.PHONY: down
down:
	@echo "🛑 Stopping docker-compose services..."
	docker-compose down
	@echo "✅ Services stopped!"

# Complete workflow
.PHONY: deploy
deploy: build run
	@echo "🎉 Deployment completed!"
	@echo "🔗 Access the Enhanced Markdown Editor at: http://localhost:$(PORT)"

# Development workflow
.PHONY: dev
dev:
	@echo "🔄 Development workflow..."
	$(MAKE) clean
	$(MAKE) build
	$(MAKE) run
	@echo "🎉 Development environment ready!"
