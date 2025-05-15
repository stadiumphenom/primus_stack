# Containerized Hass-MCP Server with SSE Support for n8n

This project containerizes the Hass-MCP server (a Model Context Protocol server for Home Assistant) and converts it to use Server-Sent Events (SSE) transport protocol for integration with n8n's MCP Client nodes.

## Overview

The solution consists of:
- A Docker container running the Hass-MCP server
- Supergateway to bridge STDIO communication to SSE
- Configuration for connecting n8n to the containerized MCP server

## Prerequisites

- Docker and Docker Compose installed on your host machine
- Home Assistant instance with a Long-Lived Access Token
- n8n instance running

## Files

- `Dockerfile`: Builds the container with both Python and Node.js
- `start.sh`: Script that starts the Hass-MCP server and the supergateway bridge
- `docker-compose.yml`: Configures the container using environment variables
- `.env`: Contains all necessary environment variables

## Quick Start

1. Clone this repository to your host machine

2. Update the `.env` file with your specific details:
   ```bash
   # Update Home Assistant URL and token
   HA_URL=<YOUR_HOME_ASSISTANT_URL>
   HA_TOKEN=<YOUR_HOME_ASSISTANT_TOKEN>
   
   # Update SSE port if needed (default: <YOUR_SSE_PORT>)
   SSE_PORT=<YOUR_SSE_PORT>
   
   # Update host IP address
   HOST_IP=<YOUR_HOST_IP>
   ```

3. Build and start the container:
   ```bash
   docker compose up -d
   ```

4. Verify the container is running:
   ```bash
   docker compose ps
   ```

## Configuring n8n to Connect to the Containerized MCP Server

1. Open your n8n instance at http://<YOUR_N8N_IP>:<YOUR_N8N_PORT>

2. Create a new workflow or edit an existing one

3. Add an "MCP Client" node from the node palette

4. Configure the MCP Client node with these settings:
   - Connection Type: "Server-Sent Events (SSE)"
   - SSE URL: `http://<YOUR_HOST_IP>:<YOUR_SSE_PORT>/sse`
   - Messages Post Endpoint: `http://<YOUR_HOST_IP>:<YOUR_SSE_PORT>/message`

5. Save the workflow

6. You can now use the MCP Client node to interact with your Home Assistant instance through Hass-MCP

## Modifying Environment Variables

To modify environment variables without affecting other configuration files:

1. Edit the `.env` file to update any values:
   ```bash
   nano .env
   ```

2. Restart the container to apply changes:
   ```bash
   docker compose down
   docker compose up -d
   ```

## Troubleshooting

### Container not starting

Check the logs for any errors:
```bash
docker compose logs
```

Common issues:
- Invalid Home Assistant URL or token
- Port conflicts on the host machine
- Network connectivity issues between the container and Home Assistant

### n8n cannot connect to the MCP server

Verify:
1. The container is running: `docker compose ps`
2. The SSE port is correctly exposed: `docker compose port hass-mcp-sse <YOUR_SSE_PORT>`
3. The HOST_IP in .env is correct and accessible from n8n
4. Network connectivity between n8n and the host running the container

## Security Considerations

### API Key Security

- Store your Home Assistant token securely in the `.env` file
- Ensure the `.env` file has restricted permissions: `chmod 600 .env`
- Do not commit the `.env` file to public repositories

### Network Access Controls

- The container exposes an HTTP endpoint, so use firewalls to restrict access
- If possible, use network segmentation to isolate the container on the same network as n8n
- Consider using a reverse proxy with TLS for secure communication

### Container Security

- Keep the container and dependencies updated
- Use specific version tags instead of "latest" for better control
- Run periodic security scans on your container images

## Maintenance

To update the container:

1. Pull the latest changes from the repository:
   ```bash
   git pull
   ```

2. Rebuild and restart the container:
   ```bash
   docker compose down
   docker compose build --no-cache
   docker compose up -d
   ```

## Logs and Monitoring

View container logs:
```bash
docker compose logs -f
```

Monitor container status:
```bash
docker compose ps
docker stats
```
