#!/bin/bash
set -e

# Log configuration for debugging
echo "Starting reaper-mcp-server with the following configuration:"
echo "Host IP: ${HOST_IP}"
echo "SSE Port: ${SSE_PORT}"
echo "Reaper Projects Directory: ${REAPER_PROJECTS_DIR}"

# Create any necessary directories
if [ ! -z "${REAPER_PROJECTS_DIR}" ] && [ ! -d "${REAPER_PROJECTS_DIR}" ]; then
    echo "Creating Reaper projects directory: ${REAPER_PROJECTS_DIR}"
    mkdir -p "${REAPER_PROJECTS_DIR}"
fi

# Start supergateway with the MCP server as STDIO input
echo "Starting supergateway with reaper-mcp-server..."
supergateway --stdio "python -m reaper_mcp_server.server --reaper-projects-dir=${REAPER_PROJECTS_DIR}" --port ${SSE_PORT} --host ${HOST_IP}
