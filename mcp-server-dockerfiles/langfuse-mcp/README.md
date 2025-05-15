# Containerized Langfuse MCP Server for n8n

This repository contains everything needed to run a containerized Langfuse Prompt Management MCP Server with Server-Sent Events (SSE) transport for use with n8n's MCP Client nodes.

## Quick Start

1. Clone this repository
2. Update the `.env` file with your Langfuse API credentials
3. Build and start the container with `docker compose up -d`
4. Configure n8n to connect to the MCP server (see instructions below)

## Files Included

- `Dockerfile`: Builds the container with Node.js, the Langfuse MCP server, and supergateway
- `start.sh`: Script that runs when the container starts, launching the MCP server with SSE transport
- `docker-compose.yml`: Configuration for container deployment
- `.env`: Environment variables for customization

## Setup Instructions

### 1. Update Environment Variables

Edit the `.env` file to set your specific configuration:

```properties
# Host IP address where the MCP server will run
HOST_IP=<YOUR_HOST_IP>

# Port on which the SSE endpoint should be exposed
SSE_PORT=<YOUR_SSE_PORT>

# Langfuse API credentials
LANGFUSE_PUBLIC_KEY=<YOUR_LANGFUSE_PUBLIC_KEY>
LANGFUSE_SECRET_KEY=<YOUR_LANGFUSE_SECRET_KEY>

# Langfuse base URL (default is cloud.langfuse.com)
LANGFUSE_BASEURL=https://cloud.langfuse.com
```

Replace the placeholders with your actual Langfuse API credentials and network settings.

### 2. Build and Start the Container

```bash
docker compose up -d
```

This will:
- Build the container image using the Dockerfile
- Start the container with the environment variables from `.env`
- Expose the SSE endpoint on the specified port

### 3. Configure n8n to Connect to the MCP Server

1. Open your n8n instance at http://<YOUR_N8N_IP>:<YOUR_N8N_PORT>
2. Create a new workflow or open an existing one
3. Add an "MCP Client" node
4. Configure the MCP Client node with:
   - Connection Type: "Server-Sent Events (SSE)"
   - SSE URL: `http://<YOUR_HOST_IP>:<YOUR_SSE_PORT>/sse`
   - Messages Post Endpoint: `http://<YOUR_HOST_IP>:<YOUR_SSE_PORT>/message`

## Modifying Environment Variables

To modify environment variables without affecting other configuration files:

1. Stop the container:
   ```bash
   docker compose down
   ```

2. Edit the `.env` file with your changes

3. Restart the container:
   ```bash
   docker compose up -d
   ```

## Using the Langfuse MCP Server in n8n

The Langfuse MCP Server provides access to your Langfuse prompts. In n8n, you can:

1. Use the "MCP Client" node to connect to the server
2. List available prompts with the `get-prompts` tool or the `prompts/list` method
3. Retrieve and compile specific prompts with the `get-prompt` tool or the `prompts/get` method

Example workflow:
1. Add an "MCP Client" node 
2. Configure it with the SSE connection details above
3. Set the tool to `get-prompts` to retrieve a list of available prompts
4. Use another "MCP Client" node with the `get-prompt` tool to retrieve a specific prompt

## Security Considerations

### API Key Security
- API keys are stored in the `.env` file which is excluded from version control
- For production use, consider using Docker secrets or a secure vault solution

### Network Access Controls
- The container exposes only the necessary port
- Use a firewall to restrict access to the SSE endpoint to only necessary IP addresses
- Consider placing the MCP server behind a reverse proxy with TLS for production use

### Container Security
- The container runs as a non-root user (mcpuser)
- Only necessary dependencies are installed
- The base image is regularly updated

## Troubleshooting

### Connection Issues
- Verify that the host IP and port are correct in the `.env` file
- Ensure that the container is running: `docker compose ps`
- Check the container logs: `docker compose logs`

### Authentication Issues
- Verify your Langfuse API credentials in the `.env` file
- Check that you have access to the prompts in your Langfuse account

### n8n Integration
- Ensure that n8n is configured with `N8N_COMMUNITY_PACKAGES_ALLOW_TOOL_USAGE=true`
- Verify the SSE URL and Messages Post Endpoint in the MCP Client node