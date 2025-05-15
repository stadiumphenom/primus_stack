# Containerized SiYuan Note MCP Server with SSE Transport

This repository contains everything needed to run the SiYuan Note MCP Server in a Docker container with SSE transport for seamless integration with n8n.

## Overview

This solution:
1. Installs the @onigeya/siyuan-mcp-server npm package in a Docker container
2. Uses the supergateway package to convert STDIO to SSE transport
3. Exposes an SSE endpoint accessible from n8n

## Prerequisites

- Docker installed on your host system
- Docker Compose installed on your host system
- A running SiYuan Note instance
- A SiYuan Note API token
- n8n server running

## Getting Started

### Step 1: Create a new directory for your project

```bash
mkdir siyuan-mcp-container
cd siyuan-mcp-container
```

### Step 2: Create the necessary files

Copy the Dockerfile, start.sh, and docker-compose.yml files to this directory.

### Step 3: Configure environment variables

Edit the `docker-compose.yml` file and update the following environment variables:

```yaml
environment:
  - SIYUAN_TOKEN=<YOUR_SIYUAN_TOKEN>
  - SIYUAN_SERVER=<YOUR_SIYUAN_SERVER_URL>
  - SSE_PORT=<YOUR_SSE_PORT>
  - SSE_HOST=0.0.0.0
```

Replace:
- `<YOUR_SIYUAN_TOKEN>` with your SiYuan Note API token (found in SiYuan Note Settings - About)
- `<YOUR_SIYUAN_SERVER_URL>` with your SiYuan server URL (e.g., http://host.docker.internal:6806)

Note: The default configuration can use `host.docker.internal` to connect to a SiYuan Note instance running on your host machine. This works on Docker Desktop for Windows and Mac. For Linux hosts, you might need to use your host's actual IP address instead.

### Step 4: Build and start the container

```bash
docker compose build
docker compose up -d
```

### Step 5: Configure n8n

1. Open your n8n instance at http://<YOUR_N8N_IP>:<YOUR_N8N_PORT>
2. Create a new workflow or edit an existing one
3. Add an MCP Client node
4. Configure the MCP Client node with:
   - Connection Type: "Server-Sent Events (SSE)"
   - SSE URL: `http://<YOUR_HOST_IP>:<YOUR_SSE_PORT>/sse`
   - Messages Post Endpoint: `http://<YOUR_HOST_IP>:<YOUR_SSE_PORT>/message`
5. Save the workflow

## Configuration Options

### Container Ports

The default port for the SSE server can be configured. If you need to change this, update:
1. The `SSE_PORT` environment variable
2. The port mapping in `docker-compose.yml` 
3. The URLs in your n8n MCP Client configuration

### Container Resource Limits

Add resource limits to the container in `docker-compose.yml` if needed:

```yaml
services:
  siyuan-mcp:
    # ...existing configuration...
    deploy:
      resources:
        limits:
          cpus: '0.5'
          memory: 512M
```

## Using the MCP Server with n8n

The SiYuan Note MCP server provides a wide range of tools for managing notes, including:

* Notebook Management
* Document Operations
* Block Control
* File and Asset Management
* SQL Query Support
* Attribute Management
* Export and Conversion
* System Functions

Here are some examples of what you can do with n8n:

1. Automate note organization workflows
2. Create workflows that add content to your notes based on criteria
3. Search for notes by keyword
4. Create note organization and tagging workflows
5. Export and convert notes programmatically

## Security Best Practices

### API Token Security

1. Never commit your API token to version control
2. Consider using Docker secrets or a .env file for sensitive information:

Create a `.env` file:
```
SIYUAN_TOKEN=<YOUR_SIYUAN_TOKEN>
SIYUAN_SERVER=<YOUR_SIYUAN_SERVER_URL>
```

Update your `docker-compose.yml`:
```yaml
services:
  siyuan-mcp:
    # ...existing configuration...
    env_file:
      - .env
```

Add `.env` to your `.gitignore` file.

### Network Security

1. Use internal Docker networks whenever possible
2. Restrict access to the SSE endpoint using network rules or reverse proxy
3. Consider adding basic authentication if the endpoint is exposed outside your network

## Maintenance

### Updating the MCP Server

To update to the latest version of the SiYuan Note MCP server:

1. Pull the latest changes
2. Rebuild the container:
```bash
docker compose build --no-cache
docker compose up -d
```

### Container Logs

View logs to monitor the container:

```bash
docker compose logs -f siyuan-mcp
```

## Additional Resources

- [SiYuan Note](https://github.com/siyuan-note/siyuan)
- [SiYuan Note API Documentation](https://github.com/siyuan-note/siyuan/blob/master/API.md)
- [SiYuan Note MCP Server](https://github.com/onigeya/siyuan-mcp-server)
- [Model Context Protocol](https://modelcontextprotocol.io/)