#!/bin/bash

# Set the port from Render's environment variable
export N8N_PORT=${PORT:-5678}

echo "Starting n8n on port $N8N_PORT"
echo "Database host: $DB_POSTGRESDB_HOST"
echo "Database type: $DB_TYPE"

# Start n8n
exec n8n start
