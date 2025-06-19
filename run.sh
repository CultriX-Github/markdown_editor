#!/bin/bash

# Enhanced Markdown Editor - Docker Run Script
# Created by MiniMax Agent on 2025-06-19

set -e

echo "🚀 Starting Enhanced Markdown Editor..."

# Variables
IMAGE_NAME="enhanced-markdown-editor"
IMAGE_TAG="${1:-latest}"
CONTAINER_NAME="enhanced-markdown-editor"
PORT="${2:-8080}"

# Check if container is already running
if docker ps -q -f name="${CONTAINER_NAME}" | grep -q .; then
    echo "⚠️  Container '${CONTAINER_NAME}' is already running"
    echo "🔗 Access the editor at: http://localhost:${PORT}"
    exit 0
fi

# Remove existing stopped container if any
if docker ps -a -q -f name="${CONTAINER_NAME}" | grep -q .; then
    echo "🧹 Removing existing container..."
    docker rm "${CONTAINER_NAME}"
fi

echo "🔄 Starting new container..."

# Run the container
docker run -d \
    --name "${CONTAINER_NAME}" \
    -p "${PORT}:80" \
    --restart unless-stopped \
    "${IMAGE_NAME}:${IMAGE_TAG}"

echo "✅ Container started successfully!"
echo "🔗 Access the Enhanced Markdown Editor at: http://localhost:${PORT}"
echo "📊 Container status:"
docker ps | grep "${CONTAINER_NAME}"

echo ""
echo "🔧 Management commands:"
echo "  • Stop container: docker stop ${CONTAINER_NAME}"
echo "  • View logs: docker logs ${CONTAINER_NAME}"
echo "  • Remove container: docker rm ${CONTAINER_NAME}"
