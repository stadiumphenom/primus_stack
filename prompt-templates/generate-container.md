# Containerizing a STDIO-based Model Context Protocol (MCP) Server for n8n

I need help containerizing a STDIO-based Model Context Protocol (MCP) server and converting it to use the Server-Sent Events (SSE) transport so it can be used with n8n's MCP Client nodes.

> **Important**: Before generating the solution, please ask me for:
> 1. The host IP address where the MCP server will run
> 2. The port on which the SSE endpoint should be exposed
> 3. If you need to see any specific files from the MCP server repository to understand how it works
> 4. Any other information you need to create a working containerized solution
>
> **CRITICAL**: This task is to containerize the EXACT MCP server I provide. Do NOT create alternative implementations or substitutes under any circumstances. If you encounter difficulties, ask for more information rather than inventing alternatives.

## Background Information

### What is MCP?
The Model Context Protocol (MCP) is a standardized interface for AI models to interact with external tools and services. It provides a consistent way for AI assistants to discover and use tools.

### What is n8n?
n8n is a workflow automation platform that now supports MCP through its "MCP Client" node. The n8n MCP Client node can connect to MCP servers to access tools and execute them.

### The Challenge
Most MCP servers use the STDIO transport protocol, where they communicate via stdin/stdout. While n8n's MCP Client node does support STDIO transport, this approach often requires software dependencies that don't exist in n8n's container, making it impractical for my workflow.

For better integration with my homelab setup, I need to use the Server-Sent Events (SSE) transport protocol, which allows remote connections without dependency issues.

I need to create a containerized solution that:
1. Runs the MCP server (which uses STDIO)
2. Uses a bridge like "supergateway" to convert STDIO to SSE
3. Exposes the SSE endpoints for n8n to connect to

### Supergateway Information
The correct npm package for supergateway is simply `supergateway` (not `@modelcontextprotocol/supergateway`). To install:
```
npm install -g supergateway
```

The correct command syntax to run supergateway is:
```
supergateway --stdio "YOUR_MCP_SERVER_COMMAND_HERE" --port <YOUR_SSE_PORT>
```

Note the specific format:
- The flag is `--stdio` (not `stdio`)
- The MCP server command must be enclosed in quotes as a single argument
- Example: `supergateway --stdio "npm start" --port <YOUR_SSE_PORT>` or `supergateway --stdio "python -m my_server" --port <YOUR_SSE_PORT>`
- Incorrect: `supergateway stdio --command "your-mcp-server-command" --port <YOUR_SSE_PORT>`

Please use this exact command format in the solution to avoid "Error: You must specify one of --stdio or --sse" errors.

IMPORTANT: The actual MCP server command will vary depending on the specific MCP server being containerized. Do NOT assume the entry point is "index.js" or any other specific file. Instead, examine the repository documentation to determine the correct start command for that specific MCP server.

## My Homelab Environment

- n8n server IP address and port: <YOUR_N8N_IP>:<YOUR_N8N_PORT>
- n8n is running in a Docker container with the environment variable `N8N_COMMUNITY_PACKAGES_ALLOW_TOOL_USAGE=true`
- Host system: Linux-based (Ubuntu)
- Default port for MCP SSE servers: <YOUR_SSE_PORT> (but can be changed if needed)
- DNS resolution: Using IP addresses is preferred over hostnames
- Container storage: Persistent data should be mounted to host volumes

## MCP Server Details

I will attach the README.md file and/or link to the repository of the MCP server I want to containerize. This will contain the necessary information about installation commands, execution methods, required dependencies, and environment variables.

### Important Tool Information

- For JavaScript/Node.js MCP servers:
  - Use `npm`/`npx` for package management and execution
  - DO NOT use `uvx` (it is not an npm package)
  - IMPORTANT: If the MCP server documentation mentions an npx command (e.g., `npx mcp-server-name`), ALWAYS use that exact command instead of cloning the repository
  - Using the published npm package with npx is the most reliable approach when available

- For Python MCP servers:
  - Use `pip` for package management
  - `uv` is a Python package manager, not an npm package

When building the container, only install tools that are actually needed for the specific MCP server being containerized. The container should include only the necessary runtimes (Node.js OR Python) based on the MCP server's requirements.

## My Preferences

- Please use `docker compose` (not `docker-compose`) in all commands and documentation
- Do NOT include a "version" field at the beginning of Docker Compose files
- Place each code file in a separate artifact (Dockerfile, start.sh, docker-compose.yml, etc.)
- Create a README.md artifact with detailed instructions
- Keep responses clear and concise
- Ensure solutions can be deployed on my homelab without needing public internet access for the containers
- If the MCP server documentation mentions an npx command, use that instead of cloning the repository
- Store all environment variables in .env files that are separate from other configuration files
- Ensure the docker-compose.yml references variables from .env files rather than hardcoding them
- Document how to modify environment variables without affecting other configuration files
- IMPORTANT: Always provide complete artifacts, even when making corrections
- When updating code files, always provide the full file content rather than just the changed portions
- If an issue is found, recreate the entire artifact with corrections instead of describing the changes
- ABSOLUTELY NO ALTERNATIVE IMPLEMENTATIONS OR REPLACEMENTS will be accepted
- I want to containerize THIS SPECIFIC MCP server as is - no substitutions, alternatives, or "similar" implementations
- If you encounter issues, ask for more information rather than suggesting a different implementation
- Your task is to containerize the existing MCP server exactly as provided, not to rewrite, replace, or suggest alternatives
- When using Python base images, ALWAYS use python:3.12-slim or newer (e.g., python:3.12-slim) unless the project specifically requires an older version
- Use a fully declarative approach - do NOT use patching or modifications to the original code
- All configuration should be done through environment variables, volumes, or build arguments
- Never suggest manual edits to files after they are built - everything must be configured at build time or runtime via environment variables

## What I Need

Please help me create:

1. A Dockerfile that:
   - Uses a suitable Node.js base image
   - Clones and installs the MCP server during build
   - Installs supergateway for STDIO to SSE conversion
   - Sets up the startup script

2. A start.sh script that:
   - Logs configuration for debugging
   - Starts supergateway with the MCP server as STDIO input
   - Exposes SSE endpoints

3. A docker-compose.yml file that:
   - Configures the container using environment variables from .env files
   - Exposes the necessary ports
   - Sets up any required volumes
   - Configures restart policies
   - Does NOT include a "version" field

4. A .env file template with:
   - All necessary environment variables
   - Clear documentation for each variable
   - Default values where appropriate

5. Instructions in a README.md artifact for:
   - Building and starting the container
   - Configuring n8n to connect to the containerized MCP server
   - Include specific n8n configuration using my n8n IP
   - How to modify environment variables without affecting other configuration files

## Notes on n8n MCP Client Configuration

In n8n, I'll need to create an MCP Client node with:
- Connection Type: "Server-Sent Events (SSE)"
- SSE URL: The URL of the SSE endpoint (e.g., http://<YOUR_HOST_IP>:<YOUR_SSE_PORT>/sse)
- Messages Post Endpoint: The URL for posting messages (e.g., http://<YOUR_HOST_IP>:<YOUR_SSE_PORT>/message)
- n8n is accessible at: http://<YOUR_N8N_IP>:<YOUR_N8N_PORT>

## Security Considerations

Please include any security best practices for:
- Storing API keys securely
- Network access controls
- Container security
