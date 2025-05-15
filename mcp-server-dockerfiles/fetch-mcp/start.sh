#!/bin/bash
set -e

# Print environment variables for debugging (excluding sensitive data)
echo "Starting Fetch MCP Server with the following configuration:"
echo "HOST_IP: ${HOST_IP:-192.168.50.196}"
echo "SSE_PORT: ${SSE_PORT:-3020}"
echo "MCP_SERVER_COMMAND: npm start"

# Start the supergateway with the MCP server
echo "Starting supergateway..."
supergateway --stdio "npm start" --port ${SSE_PORT:-3020}
