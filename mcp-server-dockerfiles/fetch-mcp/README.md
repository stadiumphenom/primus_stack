# Containerized Fetch MCP Server

This project containerizes the Fetch MCP Server and converts it from STDIO to Server-Sent Events (SSE) for use with n8n's MCP Client nodes.

## Components

- **Fetch MCP Server**: Provides functionality to fetch web content in various formats (HTML, JSON, plain text, Markdown)
- **Supergateway**: Bridges between the STDIO-based MCP server and SSE transport protocol
- **Docker**: Containerizes the entire solution

## File Structure

- `Dockerfile`: Builds the container image with Node.js, the Fetch MCP Server, and Supergateway
- `docker-compose.yml`: Configures the container service
- `start.sh`: Startup script that runs the MCP server via Supergateway
- `.env`: Environment variables for configuration

## Prerequisites

- Docker and Docker Compose installed on your host system
- Network connectivity between the host running the MCP server and your n8n instance

## Setup Instructions

### 1. Clone this Repository

### 2. Configure Environment Variables

Edit the `.env` file to set your configuration:

```bash
# Host IP address where the MCP server will run
HOST_IP=<YOUR_HOST_IP>

# Port for the SSE endpoint
SSE_PORT=<YOUR_SSE_PORT>
```

You can modify these values as needed for your environment.

### 3. Build and Start the Container

```bash
docker compose up -d --build
```

This will build the Docker image and start the container in detached mode.

### 4. Verify the Container is Running

```bash
docker compose ps
```

You should see the `fetch-mcp` container running.

### 5. View Logs

```bash
docker compose logs -f
```

This will show the logs from the container, including any errors that might occur.

## Configuring n8n to Connect to the MCP Server

1. Open your n8n instance at http://<YOUR_N8N_IP>:<YOUR_N8N_PORT>
2. Create a new workflow or open an existing one
3. Add a new "MCP Client" node
4. Configure the MCP Client node with the following settings:
   - Connection Type: "Server-Sent Events (SSE)"
   - SSE URL: `http://<YOUR_HOST_IP>:<YOUR_SSE_PORT>/sse`
   - Messages Post Endpoint: `http://<YOUR_HOST_IP>:<YOUR_SSE_PORT>/message`
5. Save the workflow

## Available MCP Tools

The Fetch MCP Server provides the following tools:

- **fetch_html**: Fetch a website and return the content as HTML
- **fetch_json**: Fetch a JSON file from a URL
- **fetch_txt**: Fetch a website and return the content as plain text (no HTML)
- **fetch_markdown**: Fetch a website and return the content as Markdown

Each tool accepts the following parameters:
- `url` (string, required): URL of the website to fetch
- `headers` (object, optional): Custom headers to include in the request
- `max_length` (number, optional): Maximum number of characters to return (default: 5000)
- `start_index` (number, optional): Start content from this character index (default: 0)

## Modifying Environment Variables

To modify environment variables without affecting other configuration files:

1. Edit the `.env` file to change the desired variables
2. Restart the container to apply the changes:
   ```bash
   docker compose down
   docker compose up -d
   ```

## Security Considerations

### API Keys and Sensitive Data

- Store any API keys or sensitive data in the `.env` file, which is not committed to version control
- If you need to pass API keys to web requests, use the `headers` parameter in your tool calls
- Consider using Docker secrets for production environments

### Network Access Controls

- The container exposes only the necessary port for the SSE endpoint
- Use Docker networks to isolate the container and only allow necessary communication
- Consider implementing IP-based restrictions if the service should only be accessible from specific hosts

### Container Security

- The container runs as a non-root user (`mcpuser`) to minimize potential security risks
- The base image is kept minimal (node:20-slim) to reduce attack surface
- Dependencies are installed during the build process to ensure consistent and secure deployments

## Troubleshooting

### Common Issues

1. **Connection refused errors**:
   - Verify that the host IP and port are correctly configured in the `.env` file
   - Check that the container is running (`docker compose ps`)
   - Ensure there are no firewall rules blocking the connection

2. **Supergateway errors**:
   - Check the container logs (`docker compose logs -f`)
   - Verify that the MCP server is properly installed and built

3. **n8n connection issues**:
   - Ensure n8n is configured with the environment variable `N8N_COMMUNITY_PACKAGES_ALLOW_TOOL_USAGE=true`
   - Verify the SSE URL and Messages Post Endpoint are correctly entered in the MCP Client node

## Maintenance

- To update the Fetch MCP Server to the latest version, rebuild the container:
  ```bash
  docker compose down
  docker compose up -d --build
  ```

- To check for resource usage:
  ```bash
  docker stats fetch-mcp
  ```
