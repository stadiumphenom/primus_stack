# Containerized YouTube MCP Server

This repository contains a containerized version of the YouTube MCP Server that allows you to download subtitles from YouTube videos and connect them to a Large Language Model (LLM) via n8n's MCP Client node.

## Features

- Runs the YouTube MCP server in a Docker container
- Converts STDIO transport to Server-Sent Events (SSE) for n8n compatibility
- Configurable through environment variables
- Includes all necessary dependencies
- Automatically clones the original repository during build

## Prerequisites

- Docker and Docker Compose installed on your host system
- n8n instance running

## Files Overview

- `Dockerfile`: Builds the container image with all required dependencies
- `docker-compose.yml`: Configures the container and its networking
- `start.sh`: Startup script that runs supergateway with the MCP server
- `.env`: Environment variables configuration

## Setup Instructions

### 1. Prepare the Environment

1. Create a new directory for this project:

```bash
mkdir -p youtube-mcp-container
cd youtube-mcp-container
```

2. Create the Dockerfile, docker-compose.yml, start.sh, and .env files as provided

3. Configure the environment variables in the `.env` file if needed:

```properties
# Default configuration
HOST_IP=0.0.0.0       # Binds to all network interfaces
SSE_PORT=<YOUR_SSE_PORT>         # Port for SSE endpoint
```

### 2. Build and Start the Container

```bash
# Build the container
docker compose build

# Start the container
docker compose up -d
```

### 3. Verify the Container is Running

```bash
# Check container status
docker compose ps

# View container logs
docker compose logs
```

You should see output indicating that the MCP server is running and supergateway is listening on your configured port.

## n8n Configuration

To connect n8n to your containerized MCP server:

1. Go to your n8n instance (http://<YOUR_N8N_IP>:<YOUR_N8N_PORT>)
2. Create a new workflow or edit an existing one
3. Add an "MCP Client" node
4. Configure the MCP Client node with the following settings:
   - Connection Type: "Server-Sent Events (SSE)"
   - SSE URL: `http://<YOUR_HOST_IP>:<YOUR_SSE_PORT>/sse`
   - Messages Post Endpoint: `http://<YOUR_HOST_IP>:<YOUR_SSE_PORT>/message`

5. Save and activate the workflow

## Using the YouTube MCP Server

The YouTube MCP server provides the following functionality through n8n:

- `get_transcript`: Retrieves the transcript of a YouTube video
  - Parameters:
    - `video_id`: YouTube video ID or full URL
    - `with_timestamps`: Boolean to include timestamps (default: false)
    - `language`: Language code for the transcript (default: "en")

## Modifying Environment Variables

To modify the environment variables without affecting other configuration files:

1. Edit the `.env` file to change the values
2. Restart the container:

```bash
docker compose down
docker compose up -d
```

## Security Considerations

1. **API Key Storage**: This MCP server doesn't require API keys, but if you add functionality that does, store them in the `.env` file which is not committed to version control.

2. **Network Access Controls**: The container exposes only the necessary port. If deploying in a production environment, consider using a reverse proxy with TLS termination.

3. **Container Security**:
   - The container runs as the default user (not root)
   - Only necessary packages are installed
   - Use Docker's built-in security features (e.g., read-only file systems) for additional security

## Troubleshooting

### Common Issues

1. **Container fails to start**:
   - Check logs: `docker compose logs`
   - Ensure the `.env` file has correct values
   - Verify that your configured port is not used by another application

2. **n8n cannot connect to the MCP server**:
   - Verify that the container is running: `docker compose ps`
   - Check that the SSE URL is correct
   - Ensure that network connectivity exists between n8n and the MCP server

3. **SSE connection issues**:
   - Verify that the HOST_IP is set correctly
   - Check for any firewalls blocking connections

### Logs

To view detailed logs:

```bash
docker compose logs -f
```

## Updating the Container

To update the container when there are changes to the original repository:

```bash
# Pull latest changes
docker compose down
docker compose build --no-cache
docker compose up -d
```

This will force Docker to clone the latest version of the repository during the build process.