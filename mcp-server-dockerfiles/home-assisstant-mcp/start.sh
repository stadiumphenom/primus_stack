#!/bin/bash
set -e

# Log configuration for debugging
echo "Starting Hass-MCP SSE Bridge"
echo "Home Assistant URL: $HA_URL"
echo "SSE Port: $SSE_PORT"
echo "Host IP: $HOST_IP"

# Validate required environment variables
if [ -z "$HA_URL" ]; then
    echo "ERROR: HA_URL environment variable is not set"
    exit 1
fi

if [ -z "$HA_TOKEN" ]; then
    echo "ERROR: HA_TOKEN environment variable is not set"
    exit 1
fi

if [ -z "$SSE_PORT" ]; then
    echo "Using default SSE port: 3011"
    SSE_PORT=3011
fi

# Start supergateway with the MCP server as STDIO input
# Using the proper format: supergateway --stdio "COMMAND" --port PORT
echo "Starting supergateway bridge on port $SSE_PORT"
echo "Connecting to MCP server: python -m app"

# Use exec to replace the shell with the gateway process
exec supergateway --stdio "python -m app" --port $SSE_PORT
