#!/bin/bash

# Exit on error
set -e

# Log configuration for debugging
echo "===== MCP Server Configuration ====="
echo "SSE Host: ${SSE_HOST:-0.0.0.0}"
echo "SSE Port: ${SSE_PORT:-3007}"
echo "Docker Container: ${DOCKER_CONTAINER:-true}"
echo "===================================="

# Set default values for optional variables
export SSE_HOST=${SSE_HOST:-0.0.0.0}
export SSE_PORT=${SSE_PORT:-3007}
export DOCKER_CONTAINER=${DOCKER_CONTAINER:-true}

echo "Starting supergateway with Puppeteer MCP server..."

# Use supergateway to create SSE bridge for MCP server
exec npx supergateway \
    --stdio "npx @modelcontextprotocol/server-puppeteer" \
    --port ${SSE_PORT} \
    --host ${SSE_HOST}
