FROM node:lts-alpine

# Install git for cloning the repository
RUN apk add --no-cache git

# Create app directory
WORKDIR /app

# Clone the repository
RUN git clone https://github.com/yellowgg2/mcp-bookstack.git .

# Install dependencies
RUN npm install --ignore-scripts

# Build the application
RUN npm run build

# Install supergateway globally
RUN npm install -g supergateway

# Copy the startup script
COPY start.sh /app/start.sh
RUN chmod +x /app/start.sh

# Expose the SSE port
EXPOSE ${PORT:-3003}

# Start the server using the startup script
CMD ["/app/start.sh"]
