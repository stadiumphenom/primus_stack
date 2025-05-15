# Containerized Paperless-NGX MCP Server with SSE Transport

This repository contains everything needed to run the Paperless-NGX MCP Server in a Docker container with SSE transport for seamless integration with n8n.

## Overview

This solution:
1. Installs the @nloui/paperless-mcp npm package in a Docker container
2. Uses the supergateway package to convert STDIO to SSE transport
3. Exposes an SSE endpoint accessible from n8n

## Prerequisites

- Docker installed on your host system
- Docker Compose installed on your host system
- A running Paperless-NGX instance
- A Paperless-NGX API token
- n8n server running at 192.168.50.248:5678

## Getting Started

### Step 1: Create a new directory for your project

```bash
mkdir paperless-mcp-container
cd paperless-mcp-container
```

### Step 2: Create the necessary files

Copy the Dockerfile, start.sh, and docker-compose.yml files to this directory.

### Step 3: Configure environment variables

Edit the `docker-compose.yml` file and update the following environment variables:

```yaml
environment:
  - PAPERLESS_URL=http://your-paperless-instance:8000
  - PAPERLESS_TOKEN=your-api-token
  - SSE_PORT=3001
  - SSE_HOST=0.0.0.0
```

Replace:
- `your-paperless-instance:8000` with the URL of your Paperless-NGX instance
- `your-api-token` with your Paperless-NGX API token

### Step 3: Build and start the container

```bash
docker compose build
docker compose up -d
```

### Step 4: Verify build logs

After building the container, check the build logs to confirm that the repository was cloned successfully:

```bash
docker compose logs paperless-mcp
```

You should see output confirming:
- The repository was cloned from GitHub
- The Paperless-NGX MCP server was initialized 
- The SSE transport is running on port 3001

### Step 5: Configure n8n

1. Open your n8n instance at http://192.168.50.248:5678
2. Create a new workflow or edit an existing one
3. Add an MCP Client node
4. Configure the MCP Client node with:
   - Connection Type: "Server-Sent Events (SSE)"
   - SSE URL: `http://192.168.50.248:3001/sse` (or use your container's IP if different)
   - Messages Post Endpoint: `http://192.168.50.248:3001/message` (or use your container's IP if different)
5. Save the workflow

## Configuration Options

### Container Ports

The default port for the SSE server is 3001. If you need to change this, update:
1. The `SSE_PORT` environment variable
2. The port mapping in `docker-compose.yml` 
3. The URLs in your n8n MCP Client configuration

### Network Configuration

By default, the container connects to the `demo` external network. If you need to use a different network:

1. Edit the `docker-compose.yml` file:

```yaml
networks:
  demo:
    external: true
    # Change to your network name
```

### Container Resource Limits

Add resource limits to the container in `docker-compose.yml` if needed:

```yaml
services:
  paperless-mcp:
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
docker compose logs paperless-mcp
```

### n8n can't connect to the MCP server

1. Ensure the container is running:
```bash
docker compose ps
```

2. Check if the SSE endpoint is accessible from n8n:
```bash
curl http://192.168.50.248:3001/sse
```

3. Verify network connectivity between containers:
```bash
docker compose exec paperless-mcp ping 192.168.50.248
```

### Invalid API token or URL

If you see errors about invalid API tokens or URLs:

1. Verify your Paperless-NGX instance is accessible
2. Generate a new API token in Paperless-NGX:
   1. Log into your Paperless-NGX instance
   2. Click your username in the top right
   3. Select "My Profile"
   4. Click the circular arrow button to generate a new token
3. Update the `PAPERLESS_TOKEN` in your `docker-compose.yml` file
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
PAPERLESS_TOKEN=your-api-token
```

Update your `docker-compose.yml`:
```yaml
services:
  paperless-mcp:
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

The Paperless-NGX MCP server provides tools for managing documents, tags, correspondents, and document types. Here are some examples of what you can do with n8n:

1. Automate document uploads to Paperless-NGX
2. Create workflows that tag or categorize documents based on content
3. Search for documents by keyword
4. Create document organization workflows

Refer to the [Paperless-NGX MCP Server documentation](https://github.com/nloui/paperless-mcp) for details on available tools and parameters.

## Maintenance

### Updating the MCP Server

To update to the latest version of the Paperless-NGX MCP server:

1. Pull the latest changes
2. Rebuild the container:
```bash
docker compose build --no-cache
docker compose up -d
```

### Container Logs

View logs to monitor the container:

```bash
docker compose logs -f paperless-mcp
```

## Support

For issues with:
- The Paperless-NGX MCP server: [GitHub repository](https://github.com/nloui/paperless-mcp)
- n8n integration: [n8n documentation](https://docs.n8n.io)
- Container configuration: Create an issue in this repository
