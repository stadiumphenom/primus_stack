# Containerized MCP Server for Memos with SSE Transport
This repository contains a Docker-based solution for running the [mcp-server-memos](https://github.com/LeslieLeung/mcp-server-memos) with Server-Sent Events (SSE) transport, allowing it to be used with n8n's MCP Client nodes.
## Overview
This solution:
1. Runs the Python-based MCP server for Memos in a container
2. Uses supergateway to convert from STDIO to SSE transport
3. Exposes the SSE endpoints for n8n to connect to
## Prerequisites
- Docker and Docker Compose installed on your host machine
- A Memos instance with an API key
- n8n installed and running with the MCP Client node (with `N8N_COMMUNITY_PACKAGES_ALLOW_TOOL_USAGE=true`)
## Files
- `Dockerfile`: Defines the container image that runs the Python-based MCP server
- `start.sh`: Script that starts the MCP server with supergateway
- `docker-compose.yml`: Orchestrates the container setup
- `.env`: Contains configuration variables
## Setup Instructions
### 1. Configure Environment Variables
Edit the `.env` file to set your Memos instance details:
```
# Memos Server Configuration
MEMOS_URL=<YOUR_MEMOS_URL>
MEMOS_API_KEY=<YOUR_MEMOS_API_KEY>
DEFAULT_TAG=#mcp
# Network Configuration
HOST_IP=<YOUR_HOST_IP>
SSE_PORT=<YOUR_SSE_PORT>
```
- `MEMOS_URL`: URL of your Memos instance
- `MEMOS_API_KEY`: Your Memos API key
- `DEFAULT_TAG`: Default tag to add to memos (default: #mcp)
- `HOST_IP`: IP address of your host machine
- `SSE_PORT`: Port for the SSE endpoint
### 2. Build and Start the Container
```bash
# Build and start the container
docker compose up -d
# View logs
docker compose logs -f
```
### 3. Configure n8n MCP Client
In n8n, create a new MCP Client node with the following configuration:
1. **Connection Type**: Server-Sent Events (SSE)
2. **SSE URL**: `http://<YOUR_HOST_IP>:<YOUR_SSE_PORT>/sse`
3. **Messages Post Endpoint**: `http://<YOUR_HOST_IP>:<YOUR_SSE_PORT>/message`
## Available Tools
The MCP server for Memos provides these tools:
- `search_memos`: Search for memos with keywords
- `create_memo`: Create a new memo
## Security Considerations
- The `.env` file contains sensitive information (API keys). Ensure it's not committed to public repositories.
- The container is configured to run on a local network. If exposing to the internet, add additional security measures.
- Consider using Docker secrets for storing API keys in production.
## Troubleshooting
If you encounter issues:
1. Check the logs: `docker compose logs -f`
2. Verify your Memos API key is correct
3. Ensure n8n can reach the MCP server at the specified URL
4. Confirm the `SSE_PORT` matches in both `.env` and n8n configuration
## Modifying Environment Variables
To modify environment variables:
1. Edit the `.env` file
2. Restart the container: `docker compose restart`
The environment variables are loaded from the `.env` file at container start time, so you don't need to modify any other configuration files.