# DocSpace MCP Bridge Docker

A Docker containerized version of [ONLYOFFICE DocSpace MCP Server](https://github.com/onlyoffice/docspace-mcp), providing a bridge between Large Language Models (LLMs) and ONLYOFFICE DocSpace through the [Model Context Protocol](https://modelcontextprotocol.io/).

## What is this?

This project containerizes the OnlyOffice DocSpace MCP Server to make it easier to:

- Deploy in Docker environments
- Run as a standalone service
- Connect LLMs to your DocSpace instance with minimal configuration

The DocSpace MCP Bridge exposes the OnlyOffice DocSpace API through the standardized Model Context Protocol, allowing AI assistants to interact with your document management system.

## Quick Start

### Prerequisites

- Docker and Docker Compose installed
- An ONLYOFFICE DocSpace instance
- API key or credentials for your DocSpace instance

### Setup

1. Clone this repository

2. Edit the `.env` file with your DocSpace credentials:
   ```
   DOCSPACE_API_KEY=your_api_key_here
   # Or alternatively:
   # DOCSPACE_AUTH_TOKEN=your_auth_token_here
   # Or:
   # DOCSPACE_USERNAME=your_username_here
   # DOCSPACE_PASSWORD=your_password_here
   
   # Optional:
   DOCSPACE_USER_AGENT=your_user_agent
   ```

3. Start the container:
   ```bash
   docker-compose up -d
   ```

The service will be available at `http://localhost:3001`.

## Configuration

The following environment variables can be configured:

| Name | Required | Description |
|------|----------|-------------|
| `DOCSPACE_BASE_URL` | Yes | The base URL of your DocSpace instance |
| `DOCSPACE_API_KEY` | One of these is required | API key for authenticating with DocSpace |
| `DOCSPACE_AUTH_TOKEN` | One of these is required | Authentication token for DocSpace |
| `DOCSPACE_USERNAME` & `DOCSPACE_PASSWORD` | One of these is required | Username and password for basic authentication |
| `DOCSPACE_ORIGIN` | No | Origin header for API requests (defaults to DOCSPACE_BASE_URL) |
| `DOCSPACE_USER_AGENT` | No | User-Agent header for API requests |

## Usage with LLMs

This containerized version can be used with any LLM that supports the Model Context Protocol. The bridge exposes the same tools as the original OnlyOffice DocSpace MCP Server.

For a full list of available tools and more detailed information about the DocSpace MCP Server functionality, refer to the [original repository](https://github.com/onlyoffice/docspace-mcp).

## Building the Image

To build the Docker image manually:

```bash
docker build -t docspace-mcp-bridge .
```

## License

This project is distributed under the Apache-2.0 license, the same as the original [ONLYOFFICE DocSpace MCP Server](https://github.com/onlyoffice/docspace-mcp).
