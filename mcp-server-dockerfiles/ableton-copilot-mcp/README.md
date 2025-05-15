# Containerized Ableton Copilot MCP Server

This project containerizes the Ableton Copilot MCP server to work with n8n via Server-Sent Events (SSE) transport protocol.

## Overview

This containerized solution:

1. Runs the Ableton Copilot MCP server which is normally used via STDIO
2. Uses supergateway to convert STDIO to SSE
3. Exposes the SSE endpoint for n8n to connect to
4. Communicates with Ableton Live running on a separate machine

## Prerequisites

- Docker and Docker Compose installed on the host system
- Ableton Live running on a machine
- Ableton Live must have the AbletonJS Control Surface enabled (see Setup section)

## Setup Ableton Live

Before using this containerized MCP server, you need to set up Ableton Live:

1. **Launch Ableton Live** on the machine
2. **Install AbletonJS MIDI Remote Scripts**:
   - Create a folder named "Remote Scripts" in your Ableton User Library:
     - Windows: `C:\Users\[username]\Documents\Ableton\User Library\Remote Scripts`
     - Mac: `/Users/[username]/Music/Ableton/User Library\Remote Scripts`
   - Download MIDI Remote Scripts from the [ableton-js](https://github.com/leolabs/ableton-js) project
   - Copy the downloaded `midi-script` folder to the location above
   - Rename it to `AbletonJS`
3. **Enable AbletonJS Control Surface**:
   - Open Ableton Live Preferences: `Preferences` → `Link/MIDI`
   - In the `MIDI` tab, locate the `Control Surface` section
   - Select `AbletonJS` from the dropdown menu

## Building and Running the Container

1. Clone this repository to your host machine
2. Create the required files:
   - Dockerfile
   - start.sh
   - docker-compose.yml
   - .env

3. Build and start the container:

```bash
# Make sure you're in the project directory
docker compose up -d
```

4. Check the logs to ensure everything is running correctly:

```bash
docker compose logs -f
```

## Configuration

All configuration is stored in the `.env` file. Here's what each variable means:

- `SSE_PORT`: The port on which the SSE endpoint is exposed (default: <YOUR_SSE_PORT>)
- `HOST_IP`: The IP address of the host running the container (<YOUR_HOST_IP>)
- `ABLETON_IP`: The IP address of the machine running Ableton Live (<YOUR_ABLETON_IP>)
- `BASE_PATH`: The path where persistent data is stored (default: <YOUR_DATA_PATH>)

## Configuring n8n to Connect to the MCP Server

1. Log into your n8n instance at http://<YOUR_N8N_IP>:<YOUR_N8N_PORT>
2. Create a new workflow or open an existing one
3. Add an MCP Client node
4. Configure the MCP Client node with:
   - Connection Type: "Server-Sent Events (SSE)"
   - SSE URL: `http://<YOUR_HOST_IP>:<YOUR_SSE_PORT>/sse`
   - Messages Post Endpoint: `http://<YOUR_HOST_IP>:<YOUR_SSE_PORT>/message`
5. Save the configuration

## Modifying Environment Variables

To change configuration without affecting other files:

1. Edit the `.env` file with your desired values
2. Restart the container:

```bash
docker compose down
docker compose up -d
```

## Security Considerations

- This setup uses internal IP addresses and is intended for homelab use. Do not expose these ports to the public internet.
- The container is configured to only communicate on your local network.
- If your Ableton Live instance contains sensitive project files, ensure proper network segmentation.
- For added security, consider implementing firewall rules to only allow connections between the specified IPs.

## Troubleshooting

If you encounter any issues:

1. **Check container logs**:
   ```bash
   docker compose logs -f
   ```

2. **Verify Ableton Live is running** with the AbletonJS Control Surface enabled

3. **Test network connectivity** between the MCP server and Ableton Live:
   ```bash
   ping <YOUR_ABLETON_IP>
   ```

4. **Verify the SSE endpoint is accessible** from n8n:
   ```bash
   curl http://<YOUR_HOST_IP>:<YOUR_SSE_PORT>/sse
   ```

5. If Ableton Live is not connecting properly, try restarting the Ableton Live application.

## Additional Information

- The container stores persistent data in the `./data` directory on the host. This includes logs, operation history, and state snapshots.
- The container is configured to restart automatically unless explicitly stopped.
