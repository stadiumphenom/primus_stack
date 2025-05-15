#!/bin/sh

# Log configurations
echo "Starting OnlyOffice DocSpace MCP Bridge with configuration:"
echo "DOCSPACE_BASE_URL: ${DOCSPACE_BASE_URL}"
echo "DOCSPACE_ORIGIN: ${DOCSPACE_ORIGIN:-not set}"
echo "DOCSPACE_USER_AGENT: ${DOCSPACE_USER_AGENT:-not set}"
echo "DOCSPACE_API_KEY: ${DOCSPACE_API_KEY:-not set}"
echo "DOCSPACE_AUTH_TOKEN: ${DOCSPACE_AUTH_TOKEN:-not set}"
echo "DOCSPACE_USERNAME: ${DOCSPACE_USERNAME:-not set}"
echo "DOCSPACE_PASSWORD: ${DOCSPACE_PASSWORD:-not set}"

# Validate required environment variables
if [ -z "${DOCSPACE_BASE_URL}" ]; then
  echo "Error: DOCSPACE_BASE_URL environment variable is required"
  exit 1
fi

if [ -z "${DOCSPACE_API_KEY}" ] && [ -z "${DOCSPACE_AUTH_TOKEN}" ] && [ -z "${DOCSPACE_USERNAME}" ]; then
  echo "Error: Either DOCSPACE_API_KEY, DOCSPACE_AUTH_TOKEN, or DOCSPACE_USERNAME with DOCSPACE_PASSWORD must be provided"
  exit 1
fi

if [ -n "${DOCSPACE_USERNAME}" ] && [ -z "${DOCSPACE_PASSWORD}" ]; then
  echo "Error: DOCSPACE_PASSWORD is required when DOCSPACE_USERNAME is provided"
  exit 1
fi

# Ensure DOCSPACE_ORIGIN is always set
if [ -z "${DOCSPACE_ORIGIN}" ]; then
  # Default to the same value as DOCSPACE_BASE_URL if not set
  export DOCSPACE_ORIGIN="${DOCSPACE_BASE_URL}"
  echo "Setting DOCSPACE_ORIGIN to ${DOCSPACE_ORIGIN}"
fi

# Start the supergateway with the OnlyOffice DocSpace MCP server
exec npx -y supergateway \
  --stdio "npx --yes @onlyoffice/docspace-mcp" \
  --port 3001 \
  --baseUrl http://0.0.0.0:3001 \
  --ssePath /sse \
  --messagePath /message
