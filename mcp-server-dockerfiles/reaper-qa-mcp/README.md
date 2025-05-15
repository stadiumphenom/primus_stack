# Containerized Reaper MCP Server with SSE Transport

This repository contains everything needed to containerize the Reaper MCP Server with Server-Sent Events (SSE) transport for use with n8n's MCP Client nodes.

## Overview

This solution:
1. Containerizes the STDIO-based Reaper MCP Server
2. Uses supergateway to convert STDIO to SSE transport
3. Exposes SSE endpoints for n8n to connect to

## Prerequisites

- Docker installed on your host system
- Docker Compose installed on your host system
- A directory containing Reaper projects that you want to analyze

## Files Included

- `Dockerfile`: Defines the container image with Python, Node.js, and necessary dependencies
- `start.sh`: Script that starts supergateway with the MCP server
- `docker-compose.yml`: Configures the container with environment variables and volumes
- `.env`: Contains configuration variables for the deployment

## Setup Instructions

### 1. Configure Environment Variables

Edit the `.env` file to match your environment:

```
# IP address where the MCP server will run (the container's host)
HOST_IP=<YOUR_HOST_IP>

# Port on which the SSE endpoint will be exposed
SSE_PORT=<YOUR_SSE_PORT>

# Path inside the container where Reaper projects will be accessed
REAPER_PROJECTS_DIR=/reaper_projects

# Path on the host machine that contains Reaper projects
# This directory will be mounted into the container
REAPER_PROJECTS_DIR_HOST=/path/to/your/reaper/projects
```

Make sure to update `REAPER_PROJECTS_DIR_HOST` to point to the directory on your host system that contains your Reaper projects.

### 2. Build and Start the Container

```bash
# Build the container
docker compose build

# Start the container
docker compose up -d
```

To view logs:
```bash
docker compose logs -f
```

### 3. Configure n8n to Connect to the MCP Server

1. Open n8n at http://<YOUR_N8N_IP>:<YOUR_N8N_PORT>
2. Create a new workflow or edit an existing one
3. Add an "MCP Client" node
4. Configure the MCP Client node with:
   - Connection Type: "Server-Sent Events (SSE)"
   - SSE URL: `http://<YOUR_HOST_IP>:<YOUR_SSE_PORT>/sse`
   - Messages Post Endpoint: `http://<YOUR_HOST_IP>:<YOUR_SSE_PORT>/message`
5. Save the configuration

## Using the MCP Server with n8n

Once configured, you can use the MCP Client node in n8n to:

1. Find all Reaper projects using the `find_reaper_projects` tool
2. Parse a specific Reaper project using the `parse_reaper_project` tool

Example workflow:
1. Trigger node (e.g., "Manual Trigger")
2. MCP Client node configured as above
3. Process the Reaper project data in subsequent nodes

## Modifying Environment Variables

If you need to change any environment variables:

1. Edit the `.env` file with your changes
2. Restart the container with:
   ```bash
   docker compose down
   docker compose up -d
   ```

This approach keeps your configuration separate from other files and makes it easy to update settings without modifying other components.

## Security Considerations

### API Keys and Secrets
- No API keys are required for this implementation
- If you add any authentication later, store credentials in the `.env` file which is not committed to version control

### Network Access Controls
- The SSE endpoint is exposed on the specified port
- Consider using a firewall to restrict access to only the n8n server IP
- Example iptables rule:
  ```
  iptables -A INPUT -p tcp -s <YOUR_N8N_IP> --dport <YOUR_SSE_PORT> -j ACCEPT
  iptables -A INPUT -p tcp --dport <YOUR_SSE_PORT> -j DROP
  ```

### Container Security
- The container runs with default user permissions
- Only necessary packages are installed to minimize attack surface
- Volumes are mounted read-only where possible
- For additional security, consider using Docker's security features like:
  - `--cap-drop ALL` to drop all capabilities
  - Setting memory and CPU limits

## Troubleshooting

### Common Issues

1. **Connection Refused**
   - Ensure the container is running: `docker compose ps`
   - Check if the port is accessible: `curl http://<YOUR_HOST_IP>:<YOUR_SSE_PORT>/health`
   - Verify network settings in the `.env` file

2. **MCP Server Errors**
   - Check logs: `docker compose logs -f`
   - Verify the Reaper projects directory is mounted correctly
   - Ensure the paths in the `.env` file are correct

3. **n8n Integration Issues**
   - Verify n8n has the environment variable `N8N_COMMUNITY_PACKAGES_ALLOW_TOOL_USAGE=true`
   - Check n8n logs for connection errors
   - Try using explicit IP addresses instead of hostnames