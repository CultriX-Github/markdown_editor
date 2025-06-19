#!/bin/bash

# Enhanced Markdown Editor - Docker Build Script
# Created by MiniMax Agent on 2025-06-19

set -e

echo "🚀 Building Enhanced Markdown Editor Docker Image..."

# Variables
IMAGE_NAME="enhanced-markdown-editor"
IMAGE_TAG="${1:-latest}"
FULL_IMAGE_NAME="${IMAGE_NAME}:${IMAGE_TAG}"

echo "📦 Building image: ${FULL_IMAGE_NAME}"

# Build the Docker image
docker build -t "${FULL_IMAGE_NAME}" .

echo "✅ Docker image built successfully!"
echo "📋 Image details:"
docker images | grep "${IMAGE_NAME}" | head -1

echo ""
echo "🔧 Available commands:"
echo "  • Run with Docker: docker run -p 8080:80 ${FULL_IMAGE_NAME}"
echo "  • Run with Docker Compose: docker-compose up -d"
echo "  • Access editor: http://localhost:8080"

echo ""
echo "🎉 Build completed successfully!"
