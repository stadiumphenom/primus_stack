#!/bin/sh
set -e

echo "Starting Gitea MCP Server in SSE mode"
echo "Gitea Host: ${GITEA_HOST}"
echo "SSE Port: ${SSE_PORT}"
echo "Debug Mode: ${DEBUG_MODE}"

# Set debug flag if enabled
DEBUG_FLAG=""
if [ "${DEBUG_MODE}" = "true" ]; then
  DEBUG_FLAG="-d"
  echo "Debug mode enabled"
fi

# Check if GITEA_INSECURE is set to true
INSECURE_FLAG=""
if [ "${GITEA_INSECURE}" = "true" ]; then
  INSECURE_FLAG="-insecure"
  echo "Insecure mode enabled - TLS certificate verification disabled"
fi

# Make sure logs directory exists
mkdir -p /home/gitea-mcp/.gitea-mcp

# Run Gitea MCP Server directly in SSE mode
echo "Starting gitea-mcp in SSE mode"
echo "SSE endpoint will be available at http://0.0.0.0:${SSE_PORT}/sse"
echo "Message endpoint will be available at http://0.0.0.0:${SSE_PORT}/message"

exec /app/gitea-mcp \
  -t sse \
  -host "${GITEA_HOST}" \
  -token "${GITEA_ACCESS_TOKEN}" \
  -port "${SSE_PORT}" \
  ${INSECURE_FLAG} \
  ${DEBUG_FLAG}
