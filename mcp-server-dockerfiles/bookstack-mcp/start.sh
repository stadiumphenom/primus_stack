#!/bin/sh

# Log environment configuration for debugging
echo "Starting BookStack MCP Server with SSE transport"
echo "Host: ${HOST:-0.0.0.0}"
echo "Port: ${PORT:-3003}"
echo "BookStack API URL: ${BOOKSTACK_API_URL}"
echo "BookStack API Token: ${BOOKSTACK_API_TOKEN:0:5}... (truncated for security)"
echo "BookStack API Key: ${BOOKSTACK_API_KEY:0:5}... (truncated for security)"

# Start supergateway with the MCP server as STDIO input
supergateway --stdio "node /app/build/app.js" --host ${HOST:-0.0.0.0} --port ${PORT:-3003}
