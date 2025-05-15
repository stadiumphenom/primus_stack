# Outline MCP Server Docker

This repository contains Docker configuration files for running the [Outline MCP Server](https://github.com/mmmeff/outline-mcp) in a containerized environment. The Outline MCP Server provides tools for interacting with [Outline](https://www.getoutline.com/)'s API, enabling AI agents to manage documents, collections, and other entities programmatically through the Outline knowledge base platform.

## What's Included

- `Dockerfile`: Multi-stage build to clone and set up the Outline MCP Server
- `docker-compose.yml`: Configuration for running the container with proper environment variables and port mapping
- `.env.example`: Template for setting up your environment variables

## Prerequisites

- Docker and Docker Compose installed on your system
- An Outline account with API access
- Outline API key with appropriate permissions

## Setup Instructions

1. Clone this repository

2. Edit the `.env` file to add your Outline API credentials:
   ```
   OUTLINE_API_KEY=your_outline_api_key_here
   OUTLINE_API_URL=https://your-outline-instance.com/api
   ```

3. Build and start the container:
   ```bash
   docker compose up -d
   ```

4. The MCP server will be available at http://localhost:7070/sse

## Configuration

### Port Configuration

The default configuration exposes the server on port 7070. If you need to use a different port, modify the `ports` section in the `docker-compose.yml` file:

```yaml
ports:
  - "YOUR_PORT:6060"
```

### Environment Variables

- `OUTLINE_API_KEY` (required): Your API key for Outline
- `OUTLINE_API_URL` (optional): Alternative URL for your Outline API (if using an alt domain/self-hosting)

## Usage with MCP Clients

Once the server is running, you can configure MCP clients like Claude to use it. Add the server URL to your MCP client configuration:

### Claude Desktop

Add the following to your Claude Desktop configuration file (typically located at `~/Library/Application Support/Claude/claude_desktop_config.json` on macOS or `%APPDATA%/Claude/claude_desktop_config.json` on Windows):

```json
{
  "mcpServers": {
    "outline": {
      "url": "http://localhost:7070/sse"
    }
  }
}
```

### Other MCP Clients

For other MCP clients, refer to their documentation on how to add SSE-based MCP servers.

## Example Queries

Once connected, you can ask your AI assistant to:

- "List all the documents in my Outline workspace"
- "Create a new document in the 'Product' collection"
- "Find all documents related to a specific topic"
- "Update the content of a document"
- "Add a comment to a document"

## Troubleshooting

If you encounter issues:

1. Check the server logs:
   ```bash
   docker logs outline-mcp
   ```

2. Ensure your API key has the necessary permissions in Outline

3. Verify that the container is running:
   ```bash
   docker ps | grep outline-mcp
   ```

## License

This Docker configuration is provided under the MIT License. The Outline MCP Server itself retains its original license.
