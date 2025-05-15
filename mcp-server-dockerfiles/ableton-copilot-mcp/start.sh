#!/bin/bash
set -e

# Log configuration for debugging
echo "Starting Ableton Copilot MCP Server"
echo "======================================"
echo "SSE Port: ${SSE_PORT}"
echo "Host IP: ${HOST_IP}"
echo "Ableton Live IP: ${ABLETON_IP}"
echo "Base Path: ${BASE_PATH}"
echo "======================================"

# Set NODE_OPTIONS to increase memory limit if needed
export NODE_OPTIONS="--max-old-space-size=4096"

# Start the supergateway with the MCP server
echo "Starting Supergateway with Ableton Copilot MCP server..."
supergateway --stdio "npx -y @xiaolaa2/ableton-copilot-mcp" --port ${SSE_PORT}
