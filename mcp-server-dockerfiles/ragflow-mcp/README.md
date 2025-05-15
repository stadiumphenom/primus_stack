# Containerized RAGflow MCP Server

This repository contains a containerized version of the RAGflow MCP server that converts the STDIO-based MCP server to Server-Sent Events (SSE) transport for integration with n8n's MCP Client nodes.

## Overview

The setup consists of:
1. A Python-based MCP server for RAGflow (cloned from the original repository)
2. Supergateway for converting STDIO communication to SSE
3. Docker Compose configuration for easy deployment

## Requirements

- Docker
- Docker Compose
- Available ports (default: <YOUR_SSE_PORT>)

## Quick Start

1. Create a new directory for the containerization files:
   ```bash
   mkdir ragflow_mcp_container
   cd ragflow_mcp_container
   ```

2. Create all the necessary files as described in this README (Dockerfile, docker-compose.yml, .env, start.sh)

3. Review and update the `.env` file with your specific settings

4. Build and start the container:
   ```bash
   docker compose up -d
   ```

5. Verify the service is running:
   ```bash
   docker compose logs
   ```

6. The MCP SSE endpoints will be available at:
   - SSE URL: `http://<YOUR_HOST_IP>:<YOUR_SSE_PORT>/sse`
   - Messages Post Endpoint: `http://<YOUR_HOST_IP>:<YOUR_SSE_PORT>/message`

## Configuration

### Environment Variables

All configuration is managed through the `.env` file. You can modify these variables without affecting other configuration files:

| Variable | Description | Default |
|----------|-------------|---------|
| RAGFLOW_URL | URL of the RAGflow service | <YOUR_RAGFLOW_URL> |
| RAGFLOW_API_KEY | API key for RAGflow authentication | <YOUR_RAGFLOW_API_KEY> |
| RAGFLOW_DATASET_ID | Dataset ID for retrievals | <YOUR_RAGFLOW_DATASET_ID> |
| RAGFLOW_SIMILARITY_THRESHOLD | Minimum similarity threshold | 0.3 |
| RAGFLOW_VECTOR_SIMILARITY_WEIGHT | Weight for vector similarity in scoring | 0.5 |
| RAGFLOW_LIMIT | Maximum number of results to return | 5 |
| MCP_SSE_PORT | Port for the SSE server | <YOUR_SSE_PORT> |

### Updating Environment Variables

To update configuration:
1. Edit the `.env` file with your new values
2. Restart the container:
   ```bash
   docker compose down
   docker compose up -d
   ```

## n8n Integration

### Configuring n8n MCP Client Node

1. In your n8n instance (http://<YOUR_N8N_IP>:<YOUR_N8N_PORT>), create a new workflow
2. Add an "MCP Client" node
3. Configure the node with:
   - Connection Type: "Server-Sent Events (SSE)"
   - SSE URL: `http://<YOUR_HOST_IP>:<YOUR_SSE_PORT>/sse`
   - Messages Post Endpoint: `http://<YOUR_HOST_IP>:<YOUR_SSE_PORT>/message`

4. The MCP server provides the following tool:
   - `retrieve_knowledge`: Retrieves knowledge related to a query from RAGflow

### Example n8n Workflow

Here's a simple workflow to test the MCP server:

1. Create a new workflow
2. Add a "Manual trigger" node
3. Add an "MCP Client" node configured as described above
4. Connect the nodes
5. Save and execute the workflow
6. Use the MCP Client node to call the `retrieve_knowledge` tool with a query parameter

## Files Structure

### Required Files for Containerization

1. **Dockerfile**: Sets up the Python environment and installs dependencies
2. **docker-compose.yml**: Configures the container and its environment
3. **.env**: Contains environment variables for configuration
4. **start.sh**: Startup script that runs the MCP server via supergateway

### File Contents

#### start.sh
```bash
#!/bin/bash

# Log configuration for debugging
echo "=== ragflow_mcp_server Configuration ==="
echo "RAGFLOW_URL: ${RAGFLOW_URL}"
echo "RAGFLOW_DATASET_ID: ${RAGFLOW_DATASET_ID}"
echo "RAGFLOW_SIMILARITY_THRESHOLD: ${RAGFLOW_SIMILARITY_THRESHOLD}"
echo "RAGFLOW_VECTOR_SIMILARITY_WEIGHT: ${RAGFLOW_VECTOR_SIMILARITY_WEIGHT}"
echo "RAGFLOW_LIMIT: ${RAGFLOW_LIMIT}"
echo "MCP_SSE_PORT: ${MCP_SSE_PORT}"
echo "======================================="

# Start supergateway with the MCP server as STDIO input
# Using python to run main.py which starts the MCP server with STDIO transport
supergateway --stdio "python main.py" --port ${MCP_SSE_PORT}
```

## Security Considerations

### API Key Protection

- The RAGflow API key is stored in the `.env` file, which should be kept secure
- Consider using Docker secrets or a more secure secrets management solution for production

### Network Access Controls

- The container exposes only the necessary port
- Consider using an internal network or firewall rules to limit access to the MCP server
- In a production environment, consider adding authentication to the SSE endpoint

### Container Security

- The Docker image uses the official Python slim image as a base
- Minimal packages are installed to reduce attack surface

## Troubleshooting

### Logs

View container logs:
```bash
docker compose logs -f ragflow-mcp-server
```

### Networking Issues

If n8n cannot connect to the MCP server:
1. Verify the MCP server is running:
   ```bash
   curl http://<YOUR_HOST_IP>:<YOUR_SSE_PORT>/
   ```
2. Check Docker container status:
   ```bash
   docker compose ps
   ```
3. Verify that ports are correctly mapped:
   ```bash
   docker compose port ragflow-mcp-server <YOUR_SSE_PORT>
   ```

### Common Errors

- `Error: You must specify one of --stdio or --sse`: This indicates an issue with the supergateway command. Check the start.sh file.
- `Connection refused`: The MCP server is not running or the port is not accessible.
- `Cannot connect to the Docker daemon`: Docker is not running; restart the Docker service.

## Advanced Configuration

### Using a Different Port

To change the port:
1. Update the `MCP_SSE_PORT` value in the `.env` file
2. Restart the container:
   ```bash
   docker compose down
   docker compose up -d
   ```

### Persistent Logs

Logs are stored in the `logs` directory, which is mounted as a volume.