#!/bin/bash
set -e

echo "=== YouTube MCP Server Container ==="
echo "Host IP: ${HOST_IP}"
echo "SSE Port: ${SSE_PORT}"

echo "Starting MCP server with supergateway..."
cd /app/mcp-youtube
supergateway --stdio "mcp-youtube" --port ${SSE_PORT}
