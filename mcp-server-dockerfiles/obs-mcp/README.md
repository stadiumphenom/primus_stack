# Containerized OBS MCP Server with SSE Transport
This solution containerizes the OBS MCP Server and exposes it via Server-Sent Events (SSE) transport for n8n integration.
## Overview
This solution includes:
- Dockerfile for building the OBS MCP Server container
- docker-compose.yml for easy deployment
- start.sh script that runs the server with supergateway for SSE transport
- .env file for configuration
## Prerequisites
- Docker installed on your host system
- OBS Studio running with WebSocket server enabled
- n8n running on your network
## Getting Started
### 1. Set up your environment
Edit the `.env` file to configure your environment:
```bash
# Use nano, vim, or any text editor
nano .env
```
The default configuration uses:
- SSE Port: <YOUR_SSE_PORT>
- Host IP: 0.0.0.0 (listens on all interfaces)
- OBS WebSocket URL: ws://host.docker.internal:4455 (connects to OBS on your host machine)
**Important OBS Configuration Notes:**
- If OBS is running on the same machine as Docker, the default configuration should work
- If OBS is running on a different machine, update `OBS_WEBSOCKET_URL` to point to that machine's IP
- Make sure to set the `OBS_WEBSOCKET_PASSWORD` if you've configured a password in OBS
### 2. Build and start the container
```bash
# Build and start the container
docker compose up -d
# View logs
docker compose logs -f
```
### 3. Configure n8n
1. Access your n8n instance at http://<YOUR_N8N_IP>:<YOUR_N8N_PORT>
2. Create a new workflow or edit an existing one
3. Add an "MCP Client" node
4. Configure the MCP Client node with:
   - Connection Type: "Server-Sent Events (SSE)"
   - SSE URL: `http://<YOUR_HOST_IP>:<YOUR_SSE_PORT>/sse`
   - Messages Post Endpoint: `http://<YOUR_HOST_IP>:<YOUR_SSE_PORT>/message`
## Modifying Configuration
### Changing Environment Variables
You can modify any environment variable in the `.env` file without affecting other configuration files. After making changes, restart the container:
```bash
docker compose down
docker compose up -d
```
### Exposed Ports
The container exposes the SSE endpoint on the port specified in your `.env` file. To change this port:
1. Update the `SSE_PORT` in the `.env` file
2. Restart the container with `docker compose down && docker compose up -d`
3. Update your n8n configuration to use the new port
### Container Security
- The container runs without root privileges
- Only the necessary port is exposed
- OBS WebSocket password is stored as an environment variable
- For additional security, consider:
  - Using a firewall to restrict access to the exposed port
  - Setting up a reverse proxy with HTTPS for encrypted communication
## Troubleshooting
### OBS Connection Issues
If the MCP server cannot connect to OBS:
1. Verify OBS is running and WebSocket server is enabled
2. Check the WebSocket URL and password in the `.env` file
3. Ensure your network allows connections to the OBS WebSocket port (default: 4455)
4. Check container logs: `docker compose logs -f`
### n8n Connection Issues
If n8n cannot connect to the MCP server:
1. Verify the container is running: `docker compose ps`
2. Check the container logs: `docker compose logs -f`
3. Ensure the `HOST_IP` and `SSE_PORT` are correctly set
4. Verify network connectivity between n8n and the MCP server
### General Debugging
```bash
# View container logs
docker compose logs -f
# Inspect container status
docker compose ps
# Access container shell
docker compose exec obs-mcp /bin/bash
```
## Additional Information
For more information about the OBS MCP server, visit the [GitHub repository](https://github.com/royshil/obs-mcp).