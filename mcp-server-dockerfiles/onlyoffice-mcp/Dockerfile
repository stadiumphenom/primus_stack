FROM node:18-alpine

# Install dependencies
RUN apk add --no-cache git curl

# Set working directory
WORKDIR /app

# Install supergateway for STDIO to SSE conversion
RUN npm install -g supergateway

# Install OnlyOffice DocSpace MCP
RUN npm install @onlyoffice/docspace-mcp

# Copy start script
COPY start.sh .
RUN chmod +x start.sh

# Expose port
EXPOSE 3001

# Start the server
CMD ["./start.sh"]
