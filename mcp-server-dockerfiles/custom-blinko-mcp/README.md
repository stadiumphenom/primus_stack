# Custom Blinko MCP Server

A minimal custom MCP (Model Context Protocol) server for Blinko with working search functionality.

## Overview

This custom MCP server interfaces directly with the Blinko API to provide reliable search functionality for Project NOVA's n8n workflows.

## Features

- **Working search functionality** - Direct API calls to Blinko for reliable search results
- **Note creation** - Create both flash notes and regular notes
- **Daily notes retrieval** - Get today's notes for review
- **Proper error handling** - Clear error messages and response formatting for n8n
- **SSL support** - Works with self-signed certificates via NODE_TLS_REJECT_UNAUTHORIZED=0

## Available Tools

### search_blinko_notes
- **Description**: Search for notes in Blinko
- **Parameters**:
  - `searchText` (string, required): Search keyword
  - `size` (number, optional): Number of results to return (default: 10)
  - `type` (number, optional): Note type (-1 for all, 0 for flash notes, 1 for normal notes, default: -1)
- **Returns**: Formatted list of matching notes with IDs and content

### upsert_blinko_flash_note
- **Description**: Write flash note (type 0) to Blinko
- **Parameters**:
  - `content` (string, required): Note content
- **Returns**: Success message with created note ID

### upsert_blinko_note
- **Description**: Write note (type 1) to Blinko
- **Parameters**:
  - `content` (string, required): Note content
- **Returns**: Success message with created note ID

### share_blinko_note
- **Description**: Share a note or cancel sharing
- **Parameters**:
  - `noteId` (number, required): ID of the note to share
  - `password` (string, optional): Six-digit password for sharing
  - `isCancel` (boolean, optional): Whether to cancel sharing (default: false)
- **Returns**: Share status, password (if set), and share link (if successful)

### review_blinko_daily_notes
- **Description**: Get today's notes for review
- **Parameters**: None
- **Returns**: Formatted list of today's notes with IDs and content

### clear_blinko_recycle_bin
- **Description**: Clear the recycle bin in Blinko
- **Parameters**: None
- **Returns**: Confirmation of the action

### Legacy Tools (For Compatibility)

### create_blinko_note
- **Description**: Create a new note in Blinko (legacy - use upsert_blinko_note instead)
- **Parameters**:
  - `content` (string, required): Note content
  - `type` (number, optional): 0 for flash note, 1 for regular note (default: 1)
- **Returns**: Success message with created note ID

### get_daily_notes
- **Description**: Get today's notes from Blinko (legacy - use review_blinko_daily_notes instead)
- **Parameters**: None
- **Returns**: Formatted list of today's notes with IDs and content

## Setup

1. **Environment Configuration**
   ```bash
   cp .env.example .env
   # Edit .env with your Blinko configuration
   ```

2. **Required Environment Variables**
   - `HOST_IP`: Your server IP address
   - `SSE_PORT`: Port for the MCP server (e.g., 8442)
   - `BLINKO_DOMAIN`: Blinko domain with port (e.g., 192.168.50.196:8443)
   - `BLINKO_API_KEY`: Valid Blinko API key with sufficient permissions

3. **Build and Start**
   ```bash
   docker compose up -d --build
   ```

4. **Verify Functionality**
   ```bash
   docker compose logs -f custom-blinko-mcp-server
   ```

## Integration with n8n

To use this custom MCP server in your n8n workflows:

1. Update the MCP client tool configuration to point to `YOUR_SERVER_IP:8442`
2. Update your n8n workflows to use the custom MCP tools
3. Use the working `search_blinko_notes` tool for all search operations

## Troubleshooting

### Connection Issues
- Verify Blinko is accessible at the configured domain
- Check that the API key is valid and has proper permissions
- Ensure SSL certificates are properly configured or NODE_TLS_REJECT_UNAUTHORIZED=0 is set

### Search Returns No Results
- Verify the search text exists in your Blinko notes
- Check the API key permissions
- Test direct API access: `curl -H "Authorization: Bearer $API_KEY" https://your-blinko-domain/api/v1/note/list`

### Docker Issues
- Ensure ports are not conflicting with other services
- Check container logs for detailed error messages
- Verify .env file is properly formatted

## API Endpoints Used

- `POST /api/v1/note/list` - For searching and retrieving notes
- `POST /api/v1/note/upsert` - For creating new notes

## Dependencies

- `node-fetch`: HTTP client for API calls
- `supergateway`: SSE transport conversion
- Node.js 18+ Alpine Linux base image

## Acknowledgments

This implementation is based on the original [mcp-server-blinko](https://github.com/BryceWG/mcp-server-blinko) project by BryceWG. We've reimplemented the core functionality to provide reliable search capabilities while maintaining API compatibility.