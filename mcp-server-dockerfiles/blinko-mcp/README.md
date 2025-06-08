# Containerized Blinko MCP Server
This repository contains Docker configuration to run a containerized Blinko MCP server with Server-Sent Events (SSE) transport for use with n8n's MCP Client nodes.
## Quick Start
1. Clone this repository
2. Edit the `.env` file with your configuration
3. Build and start the container:
   ```bash
   docker compose up -d
   ```
4. Configure n8n to connect to the MCP server (see below)
## Configuration
### Environment Variables
All configuration is stored in the `.env` file:
```
HOST_IP=<YOUR_HOST_IP>
SSE_PORT=<YOUR_SSE_PORT>
BLINKO_DOMAIN=<YOUR_BLINKO_DOMAIN>
BLINKO_API_KEY=<YOUR_BLINKO_API_KEY>
```
- `HOST_IP`: The IP address of the host where the MCP server will run
- `SSE_PORT`: The port on which the SSE endpoint will be exposed
- `BLINKO_DOMAIN`: Your Blinko service domain with port (e.g., `192.168.1.100:8443`)
- `BLINKO_API_KEY`: Your Blinko API key (must be a full-permission/superadmin key)
### Modifying Environment Variables
To modify any environment variables:
1. Edit the `.env` file with your changes
2. Restart the container for changes to take effect:
   ```bash
   docker compose down
   docker compose up -d
   ```
## Building and Running
### Build and Start the Container
```bash
docker compose up -d
```
### View Logs
```bash
docker compose logs -f
```
### Stop the Container
```bash
docker compose down
```
## n8n Configuration
To configure n8n to connect to the containerized MCP server:
1. Access your n8n instance at http://<YOUR_N8N_IP>:<YOUR_N8N_PORT>
2. Create a new workflow or edit an existing one
3. Add an "MCP Client" node
4. Configure the MCP Client node with:
   - Connection Type: "Server-Sent Events (SSE)"
   - SSE URL: `http://<YOUR_HOST_IP>:<YOUR_SSE_PORT>/sse`
   - Messages Post Endpoint: `http://<YOUR_HOST_IP>:<YOUR_SSE_PORT>/message`
## Available Tools
The Blinko MCP server provides the following tools:
1. `upsert_blinko_flash_note`: Write flash note (type 0) to Blinko
2. `upsert_blinko_note`: Write note (type 1) to Blinko
3. `share_blinko_note`: Share a note or cancel sharing
4. `search_blinko_notes`: Search notes in Blinko with various filters
5. `review_blinko_daily_notes`: Get today's notes for review
6. `clear_blinko_recycle_bin`: Clear the recycle bin in Blinko
## Security Considerations
### API Key Storage
- The Blinko API key is stored in the `.env` file and is loaded as an environment variable in the container
- For production use, consider using Docker secrets or a secure vault service
- The API key is not logged or displayed in the container logs
### Network Access Controls
- The container exposes only the necessary port (<YOUR_SSE_PORT>)
- For additional security, consider restricting access to this port using a firewall
- Use the `HOST_IP` variable to bind the service to a specific network interface
### Container Security
- The container runs with minimal dependencies
- No unnecessary services are installed or running
- The container uses a non-root user for running the application
- The logs directory is mounted as a volume for persistence and external access
## Important: HTTPS/SSL Requirements

**⚠️ CRITICAL: The MCP server requires HTTPS to connect to Blinko.**

The underlying `mcp-server-blinko` package hardcodes HTTPS in its API calls. This means:

- **Blinko MUST be accessible via HTTPS** for the MCP server to work
- **HTTP-only Blinko instances will fail** with `fetch failed` errors
- **Self-signed certificates are supported** - the docker-compose.yml includes `NODE_TLS_REJECT_UNAUTHORIZED=0` to bypass certificate verification

### Setting Up HTTPS for Blinko

If your Blinko instance only supports HTTP, you have several options:

1. **Use a reverse proxy** (recommended):
   - Set up Traefik, Nginx, or Caddy with SSL termination
   - Point `BLINKO_DOMAIN` to the HTTPS proxy (e.g., `192.168.1.100:8443`)

2. **Use self-signed certificates**:
   - Generate self-signed certs for your Blinko instance
   - The MCP server will accept them due to `NODE_TLS_REJECT_UNAUTHORIZED=0`

3. **Use a proper SSL certificate**:
   - Set up Let's Encrypt or use a commercial certificate
   - Point `BLINKO_DOMAIN` to your HTTPS endpoint

### API Key Requirements

- Use a **full-permission API key** (superadmin role)
- **Low-permission tokens will NOT work** - they only allow note creation, not searching/reading
- Generate the API key from Blinko Settings → API Keys

## Troubleshooting
### Common Issues
1. **`fetch failed` errors**:
   - **Most common cause**: Blinko is not accessible via HTTPS
   - Ensure your `BLINKO_DOMAIN` points to an HTTPS endpoint
   - Verify SSL is working: `curl -k https://YOUR_BLINKO_DOMAIN/api/v1/note/list`
   
2. **Connection Refused**:
   - Verify that the container is running: `docker compose ps`
   - Check that port <YOUR_SSE_PORT> is exposed: `docker compose logs -f`
   
3. **Authorization Failed**:
   - Verify your Blinko API key in the `.env` file
   - Ensure you're using a full-permission (superadmin) API key, not a low-permission token
   - Restart the container after updating the `.env` file
   
4. **MCP Server Errors**:
   - Check the container logs: `docker compose logs -f`
   - Verify that the `BLINKO_DOMAIN` is correct and accessible via HTTPS
### Additional Help
For more information about:
- Blinko MCP Server: [GitHub Repository](https://github.com/BryceWG/mcp-server-blinko)
- n8n MCP Client: [n8n Documentation](https://docs.n8n.io/)