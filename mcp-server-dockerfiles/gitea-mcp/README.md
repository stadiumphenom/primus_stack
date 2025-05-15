# Containerized Gitea MCP Server for n8n

This repository contains a containerized version of the Gitea MCP Server that uses the native Server-Sent Events (SSE) transport mode, making it compatible with n8n's MCP Client nodes. This implementation builds the gitea-mcp server from source and runs it directly in SSE mode.

## Prerequisites

- Docker and Docker Compose installed on your host system
- A Gitea instance with a personal access token
- n8n instance running

## Configuration

All configuration is done through environment variables in the `.env` file:

### .env File Configuration

```bash
# Gitea instance configuration
GITEA_HOST=<YOUR_GITEA_URL>
GITEA_ACCESS_TOKEN=<YOUR_GITEA_ACCESS_TOKEN>
# Set to true if your Gitea instance uses a self-signed certificate
GITEA_INSECURE=true

# SSE server configuration
# Use 0.0.0.0 to listen on all interfaces
SSE_HOST=0.0.0.0
SSE_PORT=<YOUR_SSE_PORT>

# Set to true to enable debug mode
DEBUG_MODE=false
```

### Important Configuration Notes:

1. **GITEA_ACCESS_TOKEN**: Replace `<YOUR_GITEA_ACCESS_TOKEN>` with your actual Gitea personal access token. You can create one in your Gitea instance under Settings > Applications > Generate New Token.

2. **GITEA_INSECURE**: Set to `true` if your Gitea instance uses a self-signed certificate. This disables TLS certificate verification.

3. **SSE_HOST**: The address the SSE server will listen on. Use `0.0.0.0` to listen on all interfaces.

4. **SSE_PORT**: The port the SSE server will listen on. This must match the port you expose in docker-compose.yml.

5. **DEBUG_MODE**: Set to `true` to enable debug logging.

## Building and Running

1. Clone this repository to your host system:

```bash
mkdir -p ~/docker/gitea-mcp-server
cd ~/docker/gitea-mcp-server
# Copy all files (Dockerfile, docker-compose.yml, start.sh, .env) to this directory
```

2. Edit the `.env` file to configure your settings:

```bash
nano .env
```

3. Build and start the container:

```bash
docker compose up -d
```

4. Check the logs to ensure everything is working:

```bash
docker compose logs -f
```

## Configuring n8n to Connect to the MCP Server

1. In your n8n instance (http://<YOUR_N8N_IP>:<YOUR_N8N_PORT>), create a new workflow or edit an existing one.

2. Add an "MCP Client" node from the node selection menu.

3. Configure the MCP Client node with the following settings:
   - Connection Type: "Server-Sent Events (SSE)"
   - SSE URL: `http://<YOUR_HOST_IP>:<YOUR_SSE_PORT>/sse`
   - Messages Post Endpoint: `http://<YOUR_HOST_IP>:<YOUR_SSE_PORT>/message`

4. Save the configuration.

5. You should now be able to use all the Gitea MCP tools in your n8n workflows.

## Available Tools

The Gitea MCP Server provides a range of tools for managing your Gitea repositories. Some of the available tools include:

- User management: `get_my_user_info`, `get_user_orgs`
- Repository management: `create_repo`, `fork_repo`, `list_my_repos`
- Branch operations: `create_branch`, `delete_branch`, `list_branches`
- Release management: `create_release`, `delete_release`, `get_release`, `list_releases`
- Tag operations: `create_tag`, `delete_tag`, `get_tag`, `list_tags`
- File operations: `get_file_content`, `create_file`, `update_file`, `delete_file`
- Issue tracking: `get_issue_by_index`, `list_repo_issues`, `create_issue`
- Pull request management: `get_pull_request_by_index`, `list_repo_pull_requests`, `create_pull_request`
- Search functionality: `search_users`, `search_org_teams`, `search_repos`

For a full list of available tools, refer to the [Gitea MCP Server documentation](https://gitea.com/gitea/gitea-mcp).

## Updating Environment Variables

To update environment variables without affecting other configuration files:

1. Edit the `.env` file:

```bash
nano .env
```

2. Make your changes and save the file.

3. Restart the container to apply the changes:

```bash
docker compose down
docker compose up -d
```

## Troubleshooting

### Logs

Container logs can be viewed with:

```bash
docker compose logs -f
```

The Gitea MCP Server logs are stored in the container at `/home/gitea-mcp/.gitea-mcp/gitea-mcp.log` and are also persisted to the host via a Docker volume. You can access them with:

```bash
docker exec -it gitea-mcp-server cat /home/gitea-mcp/.gitea-mcp/gitea-mcp.log
```

### Common Issues

1. **Connection Refused**: Ensure that your Gitea instance is accessible from the container at the specified host and port.

2. **Authentication Failed**: Verify that your Gitea personal access token is correct and has the necessary permissions.

3. **Certificate Verification Failed**: If your Gitea instance uses a self-signed certificate, make sure `GITEA_INSECURE` is set to `true`.

4. **Port Conflict**: If the SSE port is already in use on your host, change the `SSE_PORT` in the `.env` file.

## Security Considerations

1. **API Key Security**: Your Gitea access token is stored in the `.env` file. Make sure this file has restricted permissions and is not committed to version control.

2. **Network Security**: The container exposes the SSE endpoint on the specified port. Make sure your network security allows connections only from trusted sources.

3. **TLS/SSL**: Consider setting up a reverse proxy with TLS/SSL for secure connections to the SSE endpoint if accessing it over an untrusted network.

4. **Container Security**: The container runs with a non-root user for improved security.

## License

This containerized version of the Gitea MCP Server is provided under the same license as the original Gitea MCP Server (MIT License).