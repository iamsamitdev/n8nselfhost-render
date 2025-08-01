FROM n8nio/n8n

# Render.com configuration
ENV N8N_PROTOCOL=https
ENV WEBHOOK_URL=https://n8nselfhost-render.onrender.com
ENV N8N_EDITOR_BASE_URL=https://n8nselfhost-render.onrender.com

# PostgreSQL Database Configuration
ENV DB_TYPE=postgresdb
ENV DB_POSTGRESDB_SSL=true
ENV DB_POSTGRESDB_SCHEMA=public

# Force IPv4 for PostgreSQL connections (fix IPv6 issues)
ENV DB_POSTGRESDB_SSL_REJECT_UNAUTHORIZED=false

# Disable file permissions check for Render
ENV N8N_ENFORCE_SETTINGS_FILE_PERMISSIONS=false

# Task runners enabled
ENV N8N_RUNNERS_ENABLED=true

# Use Render's PORT environment variable
EXPOSE $PORT