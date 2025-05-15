#!/bin/bash

# Log configuration for debugging
echo "Starting TriliumNext MCP server with SSE transport"
echo "Host IP: ${HOST_IP}"
echo "SSE Port: ${SSE_PORT}"
echo "Trilium API URL: ${TRILIUM_API_URL}"
echo "Trilium API Token is set: $([ ! -z "${TRILIUM_API_TOKEN}" ] && echo "Yes" || echo "No")"

# Check if required environment variables are set
if [ -z "${TRILIUM_API_TOKEN}" ]; then
  echo "ERROR: TRILIUM_API_TOKEN environment variable is required but not set!"
  exit 1
fi

# Add explicit environment variables for the TriliumNext MCP server
export TRILIUM_API_URL="${TRILIUM_API_URL}"
export TRILIUM_API_TOKEN="${TRILIUM_API_TOKEN}"

# Start supergateway bridge
echo "Starting supergateway on port ${SSE_PORT}..."

# According to the official documentation, the correct syntax is:
# supergateway --stdio "command" --port port_number
supergateway --stdio "node /app/build/index.js" --port ${SSE_PORT}
