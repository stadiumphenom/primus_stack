#!/bin/bash
set -e

# Log configuration for debugging
echo "Starting Reaper MCP Server with the following configuration:"
echo "REAPER_HOST: ${REAPER_HOST}"
echo "REAPER_SEND_PORT: ${REAPER_SEND_PORT}"
echo "REAPER_RECEIVE_PORT: ${REAPER_RECEIVE_PORT}"
echo "SSE_PORT: ${SSE_PORT}"
echo "DEBUG_MODE: ${DEBUG_MODE}"

# Set additional debug flags if enabled
if [ "${DEBUG_MODE}" = "true" ]; then
  export PYTHONUNBUFFERED=1
  echo "Debug mode enabled - all output will be unbuffered"
fi

# Install missing commands
apt-get update && apt-get install -y --no-install-recommends procps && apt-get clean

# Directly use the osc_mcp_server.py script instead of the shell wrapper
echo "Using direct Python execution of osc_mcp_server.py"

# Update the OSC server script to use environment variables
sed -i "s/REAPER_OSC_HOST = \".*\"/REAPER_OSC_HOST = \"${REAPER_HOST}\"/" /app/reaper-mcp/osc_mcp_server.py
sed -i "s/REAPER_OSC_SEND_PORT = [0-9]*/REAPER_OSC_SEND_PORT = ${REAPER_SEND_PORT}/" /app/reaper-mcp/osc_mcp_server.py
sed -i "s/REAPER_OSC_RECEIVE_PORT = [0-9]*/REAPER_OSC_RECEIVE_PORT = ${REAPER_RECEIVE_PORT}/" /app/reaper-mcp/osc_mcp_server.py

# Patch the OSC server to correctly bind to 0.0.0.0
sed -i 's/server = BlockingOSCUDPServer((REAPER_OSC_HOST, REAPER_OSC_RECEIVE_PORT), dispatcher)/server = BlockingOSCUDPServer(("0.0.0.0", REAPER_OSC_RECEIVE_PORT), dispatcher)/' /app/reaper-mcp/osc_mcp_server.py

# Patch the logging to show correct binding information
sed -i 's/f"OSC server listening on {REAPER_OSC_HOST}:{REAPER_OSC_RECEIVE_PORT}"/f"OSC server listening on 0.0.0.0:{REAPER_OSC_RECEIVE_PORT}"/' /app/reaper-mcp/osc_mcp_server.py

echo "Starting supergateway with MCP command: python /app/reaper-mcp/osc_mcp_server.py"

# Start supergateway with the MCP server command as STDIO input
exec supergateway --stdio "python /app/reaper-mcp/osc_mcp_server.py" --port ${SSE_PORT}
