#!/bin/bash

# Log configuration for debugging
echo "=== ragflow_mcp_server Configuration ==="
echo "RAGFLOW_URL: ${RAGFLOW_URL}"
echo "RAGFLOW_DATASET_ID: ${RAGFLOW_DATASET_ID}"
echo "RAGFLOW_SIMILARITY_THRESHOLD: ${RAGFLOW_SIMILARITY_THRESHOLD}"
echo "RAGFLOW_VECTOR_SIMILARITY_WEIGHT: ${RAGFLOW_VECTOR_SIMILARITY_WEIGHT}"
echo "RAGFLOW_LIMIT: ${RAGFLOW_LIMIT}"
echo "MCP_SSE_PORT: ${MCP_SSE_PORT}"
echo "======================================="

# Start supergateway with the MCP server as STDIO input
# Using python to run main.py which starts the MCP server with STDIO transport
cd /app
supergateway --stdio "python main.py" --port ${MCP_SSE_PORT}
