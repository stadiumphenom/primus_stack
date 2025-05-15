#!/bin/bash

# Print environment variables for debugging (excluding sensitive data)
echo "Starting Blinko MCP Server with the following configuration:"
echo "Host IP: ${HOST_IP}"
echo "SSE Port: ${SSE_PORT}"
echo "Blinko Domain: ${BLINKO_DOMAIN}"
echo "Blinko API Key: [REDACTED]"

# Create log file
LOG_FILE="/app/logs/mcp-server.log"
touch $LOG_FILE

echo "$(date): MCP Server starting..." >> $LOG_FILE

# Use npx directly as described in the README.md
echo "Starting supergateway on port ${SSE_PORT}..."
supergateway --stdio "npx -y mcp-server-blinko@0.0.6" --port ${SSE_PORT} 2>&1 | tee -a $LOG_FILE
