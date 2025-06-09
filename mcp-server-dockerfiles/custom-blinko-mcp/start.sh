#!/bin/bash

# Custom Blinko MCP Server Start Script
# This script builds and starts the custom MCP server for Blinko

set -e

echo "🚀 Starting Custom Blinko MCP Server..."

# Check if .env file exists
if [ ! -f .env ]; then
    echo "❌ Error: .env file not found!"
    echo "Please copy .env.example to .env and configure your settings."
    exit 1
fi

# Load environment variables
source .env

# Validate required environment variables
if [ -z "$BLINKO_DOMAIN" ]; then
    echo "❌ Error: BLINKO_DOMAIN not set in .env file"
    exit 1
fi

if [ -z "$BLINKO_API_KEY" ]; then
    echo "❌ Error: BLINKO_API_KEY not set in .env file"
    exit 1
fi

if [ -z "$SSE_PORT" ]; then
    echo "❌ Error: SSE_PORT not set in .env file"
    exit 1
fi

echo "✅ Environment variables validated"
echo "📡 Blinko Domain: $BLINKO_DOMAIN"
echo "🔌 SSE Port: $SSE_PORT"

# Build and start the container
echo "🔨 Building custom MCP server..."
docker compose build

echo "🎯 Starting custom MCP server..."
docker compose up -d

echo "📋 Checking container status..."
sleep 2
docker compose ps

echo "📄 Container logs (last 10 lines):"
docker compose logs --tail=10 custom-blinko-mcp-server

echo ""
echo "✨ Custom Blinko MCP Server is now running!"
echo "🔍 View logs: docker compose logs -f custom-blinko-mcp-server"
echo "⏹️  Stop server: docker compose down"
echo "🔄 Restart server: docker compose restart"