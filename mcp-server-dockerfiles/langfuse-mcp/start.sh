#!/bin/bash

# Log configuration for debugging
echo "Starting Langfuse MCP Server with SSE transport"
echo "Host IP: ${HOST_IP}"
echo "SSE Port: ${SSE_PORT}"
echo "Using Langfuse Base URL: ${LANGFUSE_BASEURL}"

# Start supergateway with the MCP server as STDIO input
# The correct command format is: supergateway --stdio "command" --port port
supergateway --stdio "node /app/build/index.js" --port ${SSE_PORT}
