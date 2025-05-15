# Containerized BookStack MCP Server with SSE Transport
This repository contains a containerized solution for running the BookStack MCP Server with Server-Sent Events (SSE) transport for integration with n8n.
## Overview
This solution:
1. Runs the BookStack MCP server in a container
2. Uses supergateway to convert STDIO protocol to SSE transport
3. Exposes SSE endpoints for n8n to connect to
## Files
- `Dockerfile`: Builds the container with Node.js, the MCP server, and supergateway
- `docker-compose.yml`: Configures the container with environment variables
- `start.sh`: Script that runs inside the container to start supergateway with the MCP server
- `.env`: Environment variables for configuration
## Prerequisites
- Docker and Docker Compose installed on your host system
- Access to a BookStack instance with API credentials
- n8n instance running (at <YOUR_N8N_IP>:<YOUR_N8N_PORT>)
## Setup Instructions
### 1. Configure Environment Variables
Edit the `.env` file with your BookStack API credentials:
   ```ini
   HOST=<YOUR_HOST_IP_OR_0.0.0.0>
   PORT=<YOUR_SSE_PORT>
   BOOKSTACK_API_URL=<YOUR_BOOKSTACK_API_URL>
   BOOKSTACK_API_TOKEN=<YOUR_BOOKSTACK_API_TOKEN>
   BOOKSTACK_API_KEY=<YOUR_BOOKSTACK_API_KEY>
   ```
### 2. Build and Start the Container
```bash
# Build the container
docker compose build
# Start the container
docker compose up -d
```
### 3. Configure n8n to Connect to the MCP Server
In n8n (http://<YOUR_N8N_IP>:<YOUR_N8N_PORT>), create a new MCP Client node with the following configuration:
1. Connection Type: "Server-Sent Events (SSE)"
2. SSE URL: `http://<YOUR_HOST_IP>:<YOUR_SSE_PORT>/sse`
3. Messages Post Endpoint: `http://<YOUR_HOST_IP>:<YOUR_SSE_PORT>/message`
Make sure you've set the n8n environment variable `N8N_COMMUNITY_PACKAGES_ALLOW_TOOL_USAGE=true` to enable MCP tools.
### 4. Using the MCP Server in n8n
Once connected, you can use the BookStack MCP server to search pages with the `search_pages` tool.
Example workflow:
1. Add an MCP Client node
2. Configure it with the SSE connection details
3. Set up the tool parameters:
   - `query`: Your search query
   - `page`: Page number (1-10)
   - `count`: Number of results (1-30)
4. Connect to other n8n nodes to process the search results
## Modifying Environment Variables
To modify environment variables without affecting other configuration files:
1. Edit the `.env` file to change values
2. Restart the container:
   ```bash
   docker compose down
   docker compose up -d
   ```
## Troubleshooting
### Check Container Logs
```bash
docker compose logs -f
```
### Verify Network Connectivity
Ensure n8n can reach the MCP server:
```bash
curl http://<YOUR_HOST_IP>:<YOUR_SSE_PORT>/sse
```
### Check Environment Variables
Verify that environment variables are being passed to the container:
```bash
docker compose exec mcp-bookstack-sse env | grep BOOKSTACK
```
## Security Considerations
### API Credentials
- Store API credentials only in the `.env` file, which should never be committed to version control
- Consider using Docker secrets for production deployments
- Periodically rotate your BookStack API credentials
### Network Access
- Expose the SSE port only to the network segment where n8n is running
- Use a reverse proxy with TLS if exposing over the internet
- Consider setting up a Docker network for n8n and the MCP server to communicate
### Container Security
- Keep the Node.js image updated
- Run container with non-root user (can be implemented in the Dockerfile)
- Use read-only filesystem where possible
- Implement resource limits in the Docker Compose file
