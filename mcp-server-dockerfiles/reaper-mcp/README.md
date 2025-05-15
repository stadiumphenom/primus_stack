# Containerized Reaper MCP Server with SSE Transport for n8n

This repository contains a Docker container setup for running the Reaper MCP server with a Server-Sent Events (SSE) transport layer, making it compatible with n8n's MCP Client node.

## Overview

This solution containerizes the [Reaper MCP server](https://github.com/hamzabels85/reaper-mcp) and uses supergateway to convert its STDIO-based communication to Server-Sent Events (SSE) for integration with n8n.

## Prerequisites

- Docker and Docker Compose installed on your host system
- REAPER installed and accessible at the configured IP address
- REAPER must have OSC enabled and configured (see configuration section below)
- n8n instance running

## Files

- `Dockerfile`: Builds the container image with Python, Node.js, supergateway, and clones the MCP repository
- `docker-compose.yml`: Configures the container service with proper port mappings
- `start.sh`: Script that configures and runs the MCP server with supergateway
- `.env`: Environment variable configuration file

## REAPER OSC Configuration

Before using this container, configure REAPER to work with OSC:

1. In REAPER, go to Options → Preferences → Control/OSC/Web
2. Enable "Allow OSC"
3. Set the OSC TCP/UDP port to 8000 (or the port specified in your .env file)
4. Make sure OSC is configured to accept connections from the Docker host IP
5. Restart REAPER after applying these settings

## Setup Instructions

1. **Create a project directory**:

   ```bash
   mkdir -p reaper-mcp-container
   cd reaper-mcp-container
   ```

2. **Copy all files from this repository into the project directory**:
   - Dockerfile
   - docker-compose.yml
   - start.sh
   - .env

3. **Review and modify the `.env` file** as needed:

   ```
   # Host configuration
   HOST_IP=<YOUR_HOST_IP>

   # Server-Sent Events configuration
   SSE_PORT=<YOUR_SSE_PORT>

   # REAPER configuration
   REAPER_HOST=<YOUR_REAPER_IP>
   REAPER_SEND_PORT=<YOUR_REAPER_SEND_PORT>
   REAPER_RECEIVE_PORT=<YOUR_REAPER_RECEIVE_PORT>

   # Debug configuration
   # Options: true, false
   DEBUG_MODE=false
   ```

4. **Build and start the container**:

   ```bash
   docker compose build
   docker compose up -d
   ```

5. **Check the logs to verify the server started correctly**:

   ```bash
   docker compose logs -f
   ```

## Configuring n8n

To configure n8n to use your containerized Reaper MCP server:

1. Open your n8n instance at http://<YOUR_N8N_IP>:<YOUR_N8N_PORT>
2. Create a new workflow or open an existing one
3. Add an "MCP Client" node
4. Configure the MCP Client node with these settings:
   - Connection Type: "Server-Sent Events (SSE)"
   - SSE URL: `http://<YOUR_HOST_IP>:<YOUR_SSE_PORT>/sse`
   - Messages Post Endpoint: `http://<YOUR_HOST_IP>:<YOUR_SSE_PORT>/message`

## Available MCP Tools

The Reaper MCP server provides tools for controlling REAPER:

1. `create_project`: Creates a new REAPER project
2. `create_track`: Creates a new track in the current project
3. `list_tracks`: Lists all tracks in the current project
4. `add_midi_note`: Adds a MIDI note to a track
5. `get_project_info`: Gets information about the current project

## Troubleshooting

If you encounter issues:

1. **Check container logs**:
   ```bash
   docker compose logs -f
   ```

2. **Verify network connectivity**:
   - Ensure the REAPER host is reachable from the container
   - Check that your REAPER ports are open for OSC communication

3. **Enable debug mode**:
   - Set `DEBUG_MODE=true` in the .env file for more verbose logging
   - Rebuild and restart the container:
     ```bash
     docker compose down
     docker compose up -d
     ```

4. **Check REAPER OSC configuration**:
   - Verify OSC is enabled in REAPER
   - Ensure port numbers match your configuration

## Modifying Environment Variables

To modify environment variables:

1. Edit the `.env` file to change any configuration parameters
2. Restart the container for the changes to take effect:
   ```bash
   docker compose down
   docker compose up -d
   ```

## Security Considerations

- **Network Access**: The container exposes only the necessary ports for SSE and OSC
- **Container Security**: The container runs with minimal privileges and uses a lightweight Python image
- **OSC Security**: OSC has no built-in security, so ensure your network is properly secured

## Architecture

The solution uses several components:

1. **Reaper MCP Server**: Provides an MCP interface for controlling REAPER via OSC
2. **OSC Communication**: Used to send commands to and receive responses from REAPER
3. **supergateway**: Bridges the STDIO transport of the MCP server to SSE for n8n compatibility

The container automatically configures these components to work together seamlessly, patching necessary settings to ensure everything works in the containerized environment.