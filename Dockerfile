# Use nginx alpine image for lightweight deployment
FROM nginx:alpine

# Set maintainer
LABEL maintainer="MiniMax Agent"
LABEL description="Enhanced Markdown Editor - A modern, feature-rich markdown editor with live preview"

# Remove default nginx website
RUN rm -rf /usr/share/nginx/html/*

# Copy our markdown editor to nginx html directory
COPY improved_markdown_editor.html /usr/share/nginx/html/index.html

# Copy nginx configuration
COPY nginx.conf /etc/nginx/nginx.conf

# Create a simple landing page structure
RUN mkdir -p /usr/share/nginx/html/assets

# Expose port 80
EXPOSE 80

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD curl -f http://localhost/ || exit 1

# Start nginx
CMD ["nginx", "-g", "daemon off;"]
