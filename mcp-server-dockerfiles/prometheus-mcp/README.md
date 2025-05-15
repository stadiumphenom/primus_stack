# Containerized Prometheus MCP Server with SSE Transport

This containerized solution provides the Prometheus MCP server with Server-Sent Events (SSE) transport for integration with n8n's MCP Client nodes.

## Overview

This solution containerizes the [Prometheus MCP Server](https://github.com/pab1it0/prometheus-mcp-server) and uses [supergateway](https://www.npmjs.com/package/supergateway) to convert the STDIO transport to SSE, making it compatible with n8n's MCP Client node.

## Configuration

### Environment Variables

All configuration is managed through the `.env` file. The following variables are available:

| Variable | Description | Default | Required |
|----------|-------------|---------|----------|
| `HOST_IP` | The IP address where the MCP server will run | <YOUR_HOST_IP> | Yes |
| `SSE_PORT` | The port on which the SSE endpoint will be exposed | <YOUR_SSE_PORT> | Yes |
| `PROMETHEUS_URL` | The URL of your Prometheus server | N/A | Yes |
| `PROMETHEUS_USERNAME` | Username for Prometheus basic auth | N/A | No |
| `PROMETHEUS_PASSWORD` | Password for Prometheus basic auth | N/A | No |
| `PROMETHEUS_TOKEN` | Bearer token for Prometheus authentication | N/A | No |
| `ORG_ID` | Organization ID for multi-tenant setups | N/A | No |

### Modifying Environment Variables

To modify the environment variables without affecting other configuration files:

1. Edit the `.env` file to update the values you need to change
2. Restart the container using `docker compose restart prometheus-mcp-server` or `docker compose down && docker compose up -d`

## Deployment Instructions

### Prerequisites

- Docker installed on your host system
- Access to a Prometheus server
- n8n instance

### Building and Starting the Container

1. Clone this repository to your local system

2. Update the `.env` file with your configuration:

```bash
# Edit the .env file with your Prometheus server details
nano .env
```

3. Build and start the container:

```bash
docker compose up -d
```

This will build the Docker image and start the container in detached mode.

4. Verify that the container is running:

```bash
docker compose ps
```

5. Check the logs to ensure everything is working:

```bash
docker compose logs
```

### Connecting n8n to the MCP Server

To configure n8n to connect to your containerized MCP server:

1. Open your n8n instance at http://<YOUR_N8N_IP>:<YOUR_N8N_PORT>
2. Create a new workflow or edit an existing one
3. Add an "MCP Client" node
4. Configure the MCP Client node with the following settings:
   - Connection Type: "Server-Sent Events (SSE)"
   - SSE URL: `http://<YOUR_HOST_IP>:<YOUR_SSE_PORT>/sse`
   - Messages Post Endpoint: `http://<YOUR_HOST_IP>:<YOUR_SSE_PORT>/message`
5. Save and test the workflow

## Troubleshooting

### Common Issues

1. **Connection refused errors**: Ensure that the container is running and that the port is correctly exposed.
2. **Authentication errors**: Check your Prometheus authentication credentials in the `.env` file.
3. **MCP server errors**: Check the container logs for any errors from the Prometheus MCP server.

### Viewing Logs

```bash
docker compose logs -f prometheus-mcp-server
```

### Restarting the Container

```bash
docker compose restart prometheus-mcp-server
```

### Rebuilding the Container

If you need to rebuild the container after making changes:

```bash
docker compose down
docker compose build --no-cache
docker compose up -d
```

## Security Considerations

### API Key Storage

- API keys and credentials are stored in the `.env` file, which should have restricted permissions
- Never commit `.env` files to version control
- Consider using Docker secrets for production deployments

### Network Access Controls

- The container exposes only the necessary port for SSE communication
- Consider using a reverse proxy for TLS termination in production
- Implement firewall rules to restrict access to the container

### Container Security

- The container runs with minimal dependencies
- No unnecessary ports are exposed
- Regular updates should be applied to the base images
