# Forgejo MCP Docker
This repository provides Docker configurations for easily deploying the Forgejo Model Context Protocol (MCP) server in a containerized environment. The Forgejo MCP server facilitates integration between Forgejo (a Gitea fork) and MCP-compatible systems, allowing for repository management through chat interfaces.
## Contents
- `Dockerfile`: Multi-stage build configuration to build and run the Forgejo MCP server
- `docker-compose.yml`: Compose configuration for easy deployment
## Prerequisites
- Docker and Docker Compose installed on your system
- A Forgejo/Gitea access token for authentication
## Quick Start
1. Clone this repository

2. Create a `.env` file in the same directory with your configuration:
   ```
   GITEA_HOST=<YOUR_FORGEJO_URL>
   GITEA_ACCESS_TOKEN=<YOUR_ACCESS_TOKEN>
   ```
3. Launch the application:
   ```bash
   docker compose up -d
   ```
4. The MCP server will be available at:
   ```
   http://<YOUR_HOST_IP>:<YOUR_PORT>/sse
   ```
## Configuration
### Environment Variables
| Variable | Description | Default |
|----------|-------------|---------|
| `GITEA_HOST` | Your Forgejo/Gitea server URL | https://forgejo.org |
| `GITEA_ACCESS_TOKEN` | Your personal access token | - |
### Ports
The server runs on port 8989 by default. You can modify this in the `docker-compose.yml` file if needed.
## Integrating with MCP Clients
Configure your MCP client (like Cursor or VSCode plugins) to connect to the server:
```json
{
  "mcpServers": {
    "forgejo": {
      "url": "http://<YOUR_HOST_IP>:<YOUR_PORT>/sse"
    }
  }
}
```
## Debugging
To enable debug mode, modify the command in the `docker-compose.yml` file:
```yaml
command: ["-t", "sse", "--port", "<YOUR_PORT>", "--host", "${GITEA_HOST:-https://forgejo.org}", "-d"]
```
## Available Tools
Once connected, you can use chat commands to interact with your Forgejo repositories. Examples:
- `list all my repositories`
- `create a new repository`
- `list branches in repository-name`
For a complete list of available tools, see the [Forgejo MCP documentation](https://codeberg.org/goern/forgejo-mcp).
## Credits
This Docker configuration wraps the [Forgejo MCP](https://codeberg.org/goern/forgejo-mcp) project, which provides the server implementation.
## License
This Docker configuration is provided under the MIT License, matching the license of the underlying Forgejo MCP project.
