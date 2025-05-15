# Everything Search MCP Server Docker

A Docker containerized version of the [Everything Search MCP Server](https://github.com/mamertofabian/mcp-everything-search), providing fast file searching capabilities to Large Language Models (LLMs) through the [Model Context Protocol](https://modelcontextprotocol.io/).

## What is this?

This project containerizes the Everything Search MCP Server, making it easier to:

- Deploy file searching capabilities in Docker environments
- Run the server as a persistent service
- Connect LLMs to local file systems with powerful search functionality

The Everything Search MCP Server allows AI assistants to search for files and folders across your system using various search criteria, helping them locate and work with files more efficiently.

## Quick Start

### Prerequisites

- Docker and Docker Compose installed
- For Linux container deployment: A directory with files to search (will be mounted to the container)

### Setup

1. Clone this repository

2. Review and update the `.env` file with your specific settings:
   ```bash
   nano .env
   ```

3. Modify the volume mount in `docker-compose.yml` to point to your data directory:
   ```yaml
   volumes:
     - /path/to/your/files:/app/search_data
   ```

4. Start the container:
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

## Available Tools

The containerized version exposes the same tools as the original Everything Search MCP Server:

### search

Search for files and folders across your mounted volumes. Parameters:

- `query` (required): Search query string
- `max_results` (optional): Maximum number of results to return (default: 100, max: 1000)
- `match_path` (optional): Match against full path instead of filename only (default: false)
- `match_case` (optional): Enable case-sensitive search (default: false)
- `match_whole_word` (optional): Match whole words only (default: false)
- `match_regex` (optional): Enable regex search (default: false)
- `sort_by` (optional): Sort order for results (default: 1)

Example usage:
```json
{
  "query": "*.py",
  "max_results": 50,
  "sort_by": 6
}
```

Response includes:
- File/folder path
- File size in bytes
- Last modified date

## Using with LLMs

### Claude Desktop Configuration

Add the following to your Claude Desktop configuration:

```json
{
  "mcpServers": {
    "everything-search": {
      "command": "docker",
      "args": [
        "run",
        "-i",
        "--rm",
        "-v",
        "/path/to/your/files:/app/search_data",
        "everything-mcp-server"
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
      "everything-search": {
        "command": "docker",
        "args": [
          "run",
          "-i",
          "--rm",
          "-v",
          "/path/to/your/files:/app/search_data",
          "everything-mcp-server"
        ]
      }
    }
  }
}
```

## Linux Implementation Notes

The Docker container uses the Linux version of the Everything Search MCP Server, which utilizes `locate`/`plocate` for file searching. This means:

1. The container automatically initializes the locate database at startup for the mounted volumes
2. Search capabilities follow Linux `plocate` syntax (not the full Windows Everything syntax)
3. For optimal results, mount volumes containing the files you want to search

## Building the Image

To build the Docker image manually:

```bash
docker build -t everything-mcp-server .
```

## License

This project is distributed under the MIT License, the same as the original [Everything Search MCP Server](https://github.com/mamertofabian/mcp-everything-search).

## Disclaimer

This project is not affiliated with, endorsed by, or sponsored by voidtools (the creators of Everything search utility) or the original Everything Search MCP Server. This is an independent project that containerizes the MCP server for easier deployment.
