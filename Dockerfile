FROM n8nio/n8n

# Render.com configuration
ENV N8N_HOST=n8nselfhost-render.onrender.com
ENV N8N_PROTOCOL=https
ENV WEBHOOK_URL=https://n8nselfhost-render.onrender.com
ENV N8N_EDITOR_BASE_URL=https://n8nselfhost-render.onrender.com

# PostgreSQL Database Configuration
ENV DB_TYPE=postgresdb
ENV DB_POSTGRESDB_SSL=true
ENV DB_POSTGRESDB_SCHEMA=public

# Disable file permissions check for Render
ENV N8N_ENFORCE_SETTINGS_FILE_PERMISSIONS=false

# Render assigns PORT dynamically, n8n will use N8N_PORT
ENV N8N_PORT=$PORT

# Use Render's PORT environment variable
EXPOSE $PORT