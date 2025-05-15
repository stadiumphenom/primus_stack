#!/bin/bash
set -e

# Log configuration for debugging
echo "Starting OBS MCP Server with SSE transport"
echo "Host IP: ${HOST_IP:-0.0.0.0}"
echo "SSE Port: ${SSE_PORT:-3012}"
echo "OBS WebSocket URL: ${OBS_WEBSOCKET_URL:-ws://localhost:4455}"
echo "OBS WebSocket Password: ${OBS_WEBSOCKET_PASSWORD:-(password masked)}"

# Export environment variables for the MCP server
export OBS_WEBSOCKET_URL=${OBS_WEBSOCKET_URL:-ws://localhost:4455}
export OBS_WEBSOCKET_PASSWORD=${OBS_WEBSOCKET_PASSWORD:-}

# Start supergateway with the MCP server as STDIO input
exec supergateway --stdio "npm run start" --port ${SSE_PORT:-3012} --host ${HOST_IP:-0.0.0.0}
