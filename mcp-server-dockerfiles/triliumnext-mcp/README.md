# Containerized TriliumNext MCP Server with SSE Transport

This repository contains the necessary files to containerize the TriliumNext Notes' MCP Server and expose it using Server-Sent Events (SSE) transport for integration with n8n.

## Prerequisites

- Docker and Docker Compose installed on your host system
- A running TriliumNext Notes instance with API access
- Your TriliumNext API token (from TriliumNext Notes settings)

## Setup Instructions

### 1. Clone this repository

### 2. Configure the environment variables

Update the following variables in the `.env` file:

- `HOST_IP`: The IP address of your host
- `SSE_PORT`: The port for the SSE endpoint
- `TRILIUM_API_URL`: The URL to your TriliumNext Notes ETAPI (update if your Trilium instance is not running on localhost)
- `TRILIUM_API_TOKEN`: Your TriliumNext API token (required)

### 3. Build and start the container

```bash
docker compose build
docker compose up -d
```

To view the logs:

```bash
docker compose logs -f
```

### 4. Configure n8n to connect to the MCP server

1. Open your n8n instance at http://<YOUR_N8N_IP>:<YOUR_N8N_PORT>
2. Create a new workflow
3. Add an MCP Client node
4. Configure the MCP Client node with the following settings:
   - Connection Type: "Server-Sent Events (SSE)"
   - SSE URL: `http://<YOUR_HOST_IP>:<YOUR_SSE_PORT>/sse`
   - Messages Post Endpoint: `http://<YOUR_HOST_IP>:<YOUR_SSE_PORT>/message`

### 5. Test the connection

In n8n, you should be able to see the available TriliumNext tools in the MCP Client node:
- `search_notes`
- `get_note`
- `create_note`
- `update_note`
- `delete_note`

## Modifying Environment Variables

If you need to modify any environment variables:

1. Stop the container:
   ```bash
   docker compose down
   ```

2. Edit the `.env` file:
   ```bash
   nano .env
   ```

3. Restart the container:
   ```bash
   docker compose up -d
   ```

This approach ensures your changes are properly applied without affecting other configuration files.

## Security Considerations

### API Token Security

- The TriliumNext API token provides full access to your notes. Keep it secure.
- The token is stored in the `.env` file, which should have restricted permissions.
- Never commit the `.env` file with your actual token to version control.

### Network Security

- Consider using Docker networks to isolate the container.
- If possible, use a reverse proxy with SSL termination for secure connections.
- Restrict access to the SSE endpoint to only the necessary IP addresses.

### Container Security

- The container runs with the default Node.js user, which has limited privileges.
- Mount volumes with appropriate permissions.
- Regularly update the container to get security patches.

## Troubleshooting

### Connection Issues

If n8n cannot connect to the MCP server:
- Verify that the container is running: `docker compose ps`
- Check the container logs: `docker compose logs`
- Ensure the `HOST_IP` and `SSE_PORT` are correct in the `.env` file
- Make sure the port is exposed on your host system
- Test connectivity with: `curl http://<YOUR_HOST_IP>:<YOUR_SSE_PORT>/sse`

### TriliumNext API Issues

If the MCP server cannot connect to TriliumNext:
- Verify your TriliumNext API URL and token
- Ensure TriliumNext is running and accessible from the container
- Check if ETAPI is enabled in your TriliumNext Notes settings

## Available Tools

The TriliumNext MCP server provides the following tools:

1. `search_notes`: Search through your notes
   - Parameters: search query, fastSearch (optional), includeArchivedNotes (optional)

2. `get_note`: Retrieve a note's content by ID
   - Parameters: note ID

3. `create_note`: Create a new note
   - Parameters: parent note ID, title, type, content, MIME type (optional)

4. `update_note`: Update an existing note
   - Parameters: note ID, new title (optional), new content (optional)

5. `delete_note`: Delete a note
   - Parameters: note ID
