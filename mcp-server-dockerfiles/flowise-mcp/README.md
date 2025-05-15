# Containerized MCP-Flowise with SSE Transport

This repository contains everything needed to run the MCP-Flowise server in a Docker container with Server-Sent Events (SSE) transport support for n8n integration.

## Overview

The solution uses:
- Python 3.12 for running the MCP-Flowise server
- Supergateway to convert STDIO transport to SSE transport
- Docker and Docker Compose for containerization

## Files

- `Dockerfile`: Defines the container image with Python, Node.js, and required dependencies
- `start.sh`: Script that launches the MCP server with Supergateway
- `docker-compose.yml`: Configuration for container deployment
- `.env`: Environment variable configuration

## Prerequisites

- Docker and Docker Compose installed on your host
- Flowise API server running and accessible
- Your Flowise API key

## Quick Start

1. Clone this repository

2. Configure environment variables:
   ```bash
   cp .env.example .env
   ```
   
3. Edit the `.env` file with your specific configuration:
   - Set `FLOWISE_API_KEY` to your actual Flowise API key
   - Set `FLOWISE_API_ENDPOINT` to your Flowise server URL
   - Modify other settings as needed (see Configuration section)

4. Build and start the container:
   ```bash
   docker compose up -d
   ```

5. Verify the container is running:
   ```bash
   docker compose ps
   ```

## Configuration

### Essential Environment Variables

- `HOST_IP`: IP address where the MCP server will run
- `SSE_PORT`: Port for the SSE endpoint
- `FLOWISE_API_KEY`: Your Flowise API key (required)
- `FLOWISE_API_ENDPOINT`: URL of your Flowise server (default: http://localhost:3000)

### Optional Environment Variables

- `FLOWISE_SIMPLE_MODE`: Set to "true" for FastMCP mode (simpler with just list_chatflows and create_prediction tools)
- `FLOWISE_CHATFLOW_ID`: ID of a specific chatflow to use (for FastMCP mode)
- `FLOWISE_ASSISTANT_ID`: ID of a specific assistant to use (for FastMCP mode)
- `FLOWISE_CHATFLOW_DESCRIPTION`: Description for the chatflow tool (for FastMCP mode)
- `FLOWISE_WHITELIST_ID`: Comma-separated list of chatflow IDs to include
- `FLOWISE_BLACKLIST_ID`: Comma-separated list of chatflow IDs to exclude
- `FLOWISE_WHITELIST_NAME_REGEX`: Regex pattern for chatflow names to include
- `FLOWISE_BLACKLIST_NAME_REGEX`: Regex pattern for chatflow names to exclude
- `DEBUG`: Set to "true" for verbose logging

## Modifying Environment Variables

To modify environment variables without affecting other configuration files:

1. Edit only the `.env` file
2. Restart the container:
   ```bash
   docker compose down
   docker compose up -d
   ```

## n8n Configuration

To connect n8n to this MCP server:

1. Add an MCP Client node in your n8n workflow
2. Configure the node with:
   - Connection Type: "Server-Sent Events (SSE)"
   - SSE URL: `http://<YOUR_HOST_IP>:<YOUR_SSE_PORT>/sse`
   - Messages Post Endpoint: `http://<YOUR_HOST_IP>:<YOUR_SSE_PORT>/message`

3. Ensure your n8n instance has the environment variable `N8N_COMMUNITY_PACKAGES_ALLOW_TOOL_USAGE=true`

### Example Configuration for n8n

In your n8n workflow, configure the MCP Client node:

- **Connection Type**: Server-Sent Events (SSE)
- **SSE URL**: http://<YOUR_HOST_IP>:<YOUR_SSE_PORT>/sse
- **Messages Post Endpoint**: http://<YOUR_HOST_IP>:<YOUR_SSE_PORT>/message

## Operational Modes

### FastMCP Mode (Simple Mode)

Set `FLOWISE_SIMPLE_MODE=true` in your `.env` file to expose only two tools:
- `list_chatflows`: Lists all available chatflows
- `create_prediction`: Creates predictions using a specified chatflow

This mode is suitable for simpler configurations.

### LowLevel Mode (Default)

Set `FLOWISE_SIMPLE_MODE=false` or leave it unset to dynamically register all chatflows as separate tools.

Each chatflow will be exposed as a separate tool with its own name and description.

## Security Considerations

- **API Key Protection**: Store your Flowise API key securely in the `.env` file, which is not tracked by Git
- **Network Security**: Ensure only trusted networks can access the container ports
- **Container Security**: The container runs with minimal privileges and dependencies

## Troubleshooting

### Container fails to start

Check logs:
```bash
docker compose logs mcp-flowise
```

### Connection issues with n8n

- Verify the container is running
- Check network connectivity between n8n and the container
- Ensure the SSE port is accessible from n8n

### MCP server errors

Increase verbosity:
```bash
# Modify .env file
DEBUG=true

# Restart container
docker compose down
docker compose up -d
```

## License

This project is licensed under the MIT License - see the LICENSE file for details.
