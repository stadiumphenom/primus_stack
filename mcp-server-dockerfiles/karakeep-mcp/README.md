# Containerized Karakeep MCP Server with SSE Transport

This repository contains everything needed to run the Karakeep MCP Server in a Docker container with SSE transport for seamless integration with n8n.

## Overview

This solution:
1. Installs the @karakeep/mcp npm package in a Docker container
2. Uses the supergateway package to convert STDIO to SSE transport
3. Exposes an SSE endpoint accessible from n8n

## Prerequisites

- Docker installed on your host system
- Docker Compose installed on your host system
- A Karakeep API key
- n8n server running

## Getting Started

### Step 1: Create a new directory for your project

```bash
mkdir karakeep-mcp-container
cd karakeep-mcp-container
```

### Step 2: Create the necessary files

Copy the Dockerfile, start.sh, and docker-compose.yml files to this directory.

### Step 3: Configure environment variables

Edit the `docker-compose.yml` file and update the following environment variables:

```yaml
environment:
  - KARAKEEP_API_ADDR=<YOUR_KARAKEEP_API_URL>
  - KARAKEEP_API_KEY=<YOUR_KARAKEEP_API_KEY>
  - SSE_PORT=<YOUR_SSE_PORT>
  - SSE_HOST=0.0.0.0
```

Replace:
- `<YOUR_KARAKEEP_API_URL>` with your Karakeep API address
- `<YOUR_KARAKEEP_API_KEY>` with your Karakeep API key
- `<YOUR_SSE_PORT>` with your desired port for the SSE server

### Step 4: Build and start the container

```bash
docker compose build
docker compose up -d
```

### Step 5: Verify build logs

After building the container, check the build logs to confirm that everything started successfully:

```bash
docker compose logs karakeep-mcp
```

You should see output confirming:
- The Karakeep MCP server was initialized
- The SSE transport is running on your specified port

### Step 6: Configure n8n

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
  karakeep-mcp:
    # ...existing configuration...
    deploy:
      resources:
        limits:
          cpus: '0.5'
          memory: 512M
```

## Troubleshooting

### Container doesn't start

Check the logs:

```bash
docker compose logs karakeep-mcp
```

### n8n can't connect to the MCP server

1. Ensure the container is running:
```bash
docker compose ps
```

2. Check if the SSE endpoint is accessible from n8n:
```bash
curl http://<YOUR_HOST_IP>:<YOUR_SSE_PORT>/sse
```

3. Verify network connectivity between containers:
```bash
docker compose exec karakeep-mcp ping <YOUR_N8N_IP>
```

### Invalid API token or URL

If you see errors about invalid API tokens or URLs:

1. Verify your Karakeep API server is accessible
2. Check your API key
3. Update the `KARAKEEP_API_ADDR` and `KARAKEEP_API_KEY` in your `docker-compose.yml` file
4. Restart the container:
```bash
docker compose down
docker compose up -d
```

## Security Best Practices

### API Token Security

1. Never commit your API token to version control
2. Consider using Docker secrets or a .env file for sensitive information:

Create a `.env` file:
```
KARAKEEP_API_KEY=<YOUR_KARAKEEP_API_KEY>
```

Update your `docker-compose.yml`:
```yaml
services:
  karakeep-mcp:
    # ...existing configuration...
    env_file:
      - .env
```

Add `.env` to your `.gitignore` file.

### Network Security

1. Use internal Docker networks whenever possible
2. Restrict access to the SSE endpoint using network rules or reverse proxy
3. Consider adding basic authentication if the endpoint is exposed outside your network

### Container Security

1. Use the latest node image and keep it updated
2. Run regular security scans on your container
3. Set resource limits to prevent DoS attacks

## Using the MCP Server with n8n

The Karakeep MCP server provides tools for managing bookmarks, including searching, adding, removing, and organizing bookmarks with tags and lists. Here are some examples of what you can do with n8n:

1. Automate bookmark organization workflows
2. Create workflows that add bookmarks based on criteria
3. Search for bookmarks by keyword
4. Create bookmark organization and tagging workflows

## Maintenance

### Updating the MCP Server

To update to the latest version of the Karakeep MCP server:

1. Pull the latest changes
2. Rebuild the container:
```bash
docker compose build --no-cache
docker compose up -d
```

### Container Logs

View logs to monitor the container:

```bash
docker compose logs -f karakeep-mcp
```

## Support

For issues with:
- The Karakeep MCP server: Check Karakeep documentation
- n8n integration: [n8n documentation](https://docs.n8n.io)
- Container configuration: Run the included troubleshoot.sh script