# Containerized CLI MCP Server for n8n

This project containerizes the [CLI MCP Server](https://github.com/MladenSU/cli-mcp-server) and converts it to use the Server-Sent Events (SSE) transport so it can be used with n8n's MCP Client nodes.

## Features

- 🐳 Containerized CLI MCP Server using Docker
- 🔄 STDIO to SSE transport conversion using supergateway
- 🔒 Configurable security settings via environment variables
- 📁 Volume mounting for command execution in host directories
- 🚀 Ready for integration with n8n

## Prerequisites

- Docker installed on your host system
- Docker Compose installed on your host system
- n8n server running and accessible

## Quick Start

1. **Create a directory for this project:**

```bash
mkdir cli-mcp-server-container && cd cli-mcp-server-container
```

2. **Create all the necessary files with the following structure:**

```
cli-mcp-server-container/
├── Dockerfile
├── start.sh
├── docker-compose.yml
├── .env
├── data/
```

3. **Create the data directory**:

```bash
mkdir -p data
```

4. **Start the container**:

```bash
docker compose up -d
```

5. **Check the logs to ensure the server started correctly**:

```bash
docker compose logs -f
```

## Configuration

All configuration is done through the `.env` file. Modify this file to change the server's behavior.

### Required Configuration

- `HOST_IP`: The IP address where the MCP server will run (default: <YOUR_HOST_IP>)
- `SSE_PORT`: The port on which the SSE endpoint will be exposed (default: <YOUR_SSE_PORT>)
- `HOST_DATA_DIR`: Directory on the host to mount for command execution (default: ./data)
- `ALLOWED_DIR`: Directory inside the container where commands will be executed (default: /data)

### Security Configuration

- `ALLOWED_COMMANDS`: Comma-separated list of allowed commands or 'all' (default: all)
- `ALLOWED_FLAGS`: Comma-separated list of allowed flags or 'all' (default: all)
- `MAX_COMMAND_LENGTH`: Maximum command string length (default: 4096)
- `COMMAND_TIMEOUT`: Command execution timeout in seconds (default: 60)
- `ALLOW_SHELL_OPERATORS`: Allow shell operators like &&, ||, |, >, etc. (default: true)

## Configuring n8n

To use this MCP server with n8n, follow these steps:

1. **Ensure n8n has the MCP Client node installed and the following environment variable set**:
   ```
   N8N_COMMUNITY_PACKAGES_ALLOW_TOOL_USAGE=true
   ```

2. **Add an MCP Client node to your workflow**:
   - Connection Type: "Server-Sent Events (SSE)"
   - SSE URL: `http://<YOUR_HOST_IP>:<YOUR_SSE_PORT>/sse`
   - Messages Post Endpoint: `http://<YOUR_HOST_IP>:<YOUR_SSE_PORT>/message`

3. **Save and execute the workflow**:
   - The MCP Client node will connect to your CLI MCP Server
   - You can now use the `run_command` tool to execute CLI commands in your workflow

### Example n8n MCP Client Configuration

```
{
  "nodeType": "n8n-nodes-base.mcpClient",
  "typeVersion": 1,
  "position": [
    820,
    300
  ],
  "parameters": {
    "connectionType": "sse",
    "sseUrl": "http://<YOUR_HOST_IP>:<YOUR_SSE_PORT>/sse",
    "messagesPostEndpoint": "http://<YOUR_HOST_IP>:<YOUR_SSE_PORT>/message"
  }
}
```

## Security Considerations

### API Keys and Sensitive Data

- Do not include sensitive API keys or credentials in command arguments
- If needed, store sensitive data in environment variables in the `.env` file

### Network Access Controls

- The container exposes only the necessary port (default: <YOUR_SSE_PORT>)
- Consider using a reverse proxy with TLS for production environments
- Restrict network access using firewall rules if needed

### Container Security

- Run the container with non-root users when possible
- Limit the commands allowed based on your specific needs
- Set appropriate volume permissions to prevent unauthorized access

## Modifying Environment Variables

To modify environment variables without affecting other configuration files:

1. Edit the `.env` file to change the desired variables
2. Restart the container:
   ```bash
   docker compose down
   docker compose up -d
   ```

## Troubleshooting

### Container won't start

Check the logs for errors:
```bash
docker compose logs -f
```

### n8n can't connect to the MCP server

- Ensure the `HOST_IP` is correctly set to an IP address that n8n can reach
- Verify the port is open and not blocked by a firewall
- Check that the container is running: `docker compose ps`

### Commands fail to execute

- Ensure the directory mounted at `/data` has the necessary permissions
- Check if the command is allowed in your security configuration
- Review the logs for specific error messages

## Advanced Usage

### Running Multiple Instances

To run multiple CLI MCP Server instances on different ports:

1. Create a copy of the project directory
2. Modify the `.env` file in the new directory to use a different port
3. Start the new container

### Custom Command Restrictions

For stricter security, you can limit the allowed commands and flags:

```
ALLOWED_COMMANDS=ls,cat,pwd,echo,grep
ALLOWED_FLAGS=-l,-a,--help,--version,-r,-i
```

## License

This containerization project is licensed under the MIT License. The underlying CLI MCP Server is also under the MIT License.