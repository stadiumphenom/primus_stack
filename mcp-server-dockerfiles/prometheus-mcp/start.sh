#!/bin/bash
set -e
echo "===== Prometheus MCP Server with SSE Transport ====="
echo "Starting up with the following configuration:"
echo "- Host IP: ${HOST_IP:-<YOUR_HOST_IP>}"
echo "- SSE Port: ${SSE_PORT:-<YOUR_SSE_PORT>}"
echo "- Prometheus URL: ${PROMETHEUS_URL}"
# Check if Prometheus URL is set
if [ -z "${PROMETHEUS_URL}" ]; then
  echo "ERROR: PROMETHEUS_URL environment variable is not set!"
  echo "Please set it to your Prometheus server URL"
  echo "Example: http://your-prometheus-server:9090"
  exit 1
fi
# Log authentication method if present
if [ ! -z "${PROMETHEUS_USERNAME}" ] && [ ! -z "${PROMETHEUS_PASSWORD}" ]; then
  echo "- Authentication: Basic Auth (username/password)"
elif [ ! -z "${PROMETHEUS_TOKEN}" ]; then
  echo "- Authentication: Bearer Token"
else
  echo "- Authentication: None"
fi
# Log organization ID if set (for multi-tenant setups)
if [ ! -z "${ORG_ID}" ]; then
  echo "- Organization ID: ${ORG_ID}"
fi
echo "Starting supergateway to convert STDIO to SSE..."
echo "SSE endpoint will be available at: http://${HOST_IP:-<YOUR_HOST_IP>}:${SSE_PORT:-<YOUR_SSE_PORT>}/sse"
echo "Messages POST endpoint will be available at: http://${HOST_IP:-<YOUR_HOST_IP>}:${SSE_PORT:-<YOUR_SSE_PORT>}/message"
# Run supergateway with the Prometheus MCP server as STDIO input
# The command is the entry point for the MCP server
exec supergateway --stdio "python -m prometheus_mcp_server.main" --port ${SSE_PORT:-<YOUR_SSE_PORT>}