#!/bin/bash

# Exit on error
set -e

# Initialize the locate database
echo "Initializing locate database..."
updatedb || true

# Log configuration for debugging
echo "===== MCP Server Configuration ====="
echo "SSE Host: ${SSE_HOST:-0.0.0.0}"
echo "SSE Port: ${SSE_PORT:-3008}"
echo "===================================="

# Set default values for optional variables
export SSE_HOST=${SSE_HOST:-0.0.0.0}
export SSE_PORT=${SSE_PORT:-3008}

echo "Starting supergateway with Everything Search MCP server..."

# Use supergateway to create SSE bridge for MCP server
exec npx supergateway \
    --stdio "python -m mcp_server_everything_search" \
    --port ${SSE_PORT} \
    --host ${SSE_HOST}
