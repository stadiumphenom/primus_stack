# Puppeteer MCP Server Docker
A Docker containerized version of the [Model Context Protocol Puppeteer Server](https://github.com/modelcontextprotocol/server-puppeteer), providing browser automation capabilities to Large Language Models (LLMs) through the [Model Context Protocol](https://modelcontextprotocol.io/).
## What is this?
This project containerizes the Puppeteer MCP Server, making it easier to:
- Deploy browser automation capabilities in Docker environments
- Run the server as a persistent service
- Connect LLMs to a headless Chrome browser with minimal configuration
The Puppeteer MCP Server allows AI assistants to interact with web pages, take screenshots, fill forms, and execute JavaScript in a real browser environment.
## Quick Start
### Prerequisites
- Docker and Docker Compose installed
### Setup
1. Clone this repository

2. Review and update the `.env` file with your specific settings:
   ```bash
   nano .env
   ```
3. Start the container:
   ```bash
   docker-compose up -d
   ```
The service will be available at `http://localhost:<YOUR_SSE_PORT>`.
## Configuration
The following environment variables can be configured:
| Name | Default | Description |
|------|---------|-------------|
| `SSE_HOST` | `0.0.0.0` | Host to bind the SSE server |
| `SSE_PORT` | `<YOUR_SSE_PORT>` | Port to run the SSE server on |
| `DOCKER_CONTAINER` | `true` | Flag to indicate running in Docker |
| `PUPPETEER_LAUNCH_OPTIONS` | `{"headless": true}` | JSON string of Puppeteer launch options |
| `ALLOW_DANGEROUS` | `false` | Allow dangerous Puppeteer launch options |
## Available Tools
The containerized version exposes the same tools as the original Puppeteer MCP Server:
### Browser Automation
- **puppeteer_navigate**: Navigate to any URL in the browser
- **puppeteer_screenshot**: Capture screenshots of the entire page or specific elements
- **puppeteer_click**: Click elements on the page
- **puppeteer_hover**: Hover over elements on the page
- **puppeteer_fill**: Fill out input fields
- **puppeteer_select**: Select an option from a dropdown menu
- **puppeteer_evaluate**: Execute JavaScript in the browser console
### Available Resources
The server provides access to:
- **Console Logs** (`console://logs`): Browser console output in text format
- **Screenshots** (`screenshot://<name>`): PNG images of captured screenshots
## Using with LLMs
### Claude Desktop Configuration
Add the following to your Claude Desktop configuration:
```json
{
  "mcpServers": {
    "puppeteer": {
      "command": "docker",
      "args": [
        "run",
        "-i",
        "--rm",
        "--init",
        "-e",
        "DOCKER_CONTAINER=true",
        "mcp/puppeteer"
      ]
    }
  }
}
```
### VS Code Configuration
Add to your VS Code User Settings (JSON) or `.vscode/mcp.json` file:
```json
{
  "mcp": {
    "servers": {
      "puppeteer": {
        "command": "docker",
        "args": [
          "run",
          "-i",
          "--rm",
          "--init",
          "-e",
          "DOCKER_CONTAINER=true",
          "mcp/puppeteer"
        ]
      }
    }
  }
}
```
## Building the Image
To build the Docker image manually:
```bash
docker build -t mcp/puppeteer .
```
## Persistent Data
The container uses a Docker volume (`mcp_puppeteer_data`) to persist browser data between container restarts.
## Key Differences from NPX Version
- This Docker implementation uses headless Chrome by default, while the NPX version opens a browser window
- Designed for server deployments rather than desktop use
- All browser interactions happen in a containerized environment
## License
This project is distributed under the MIT License, the same as the original [Puppeteer MCP Server](https://github.com/modelcontextprotocol/server-puppeteer).
