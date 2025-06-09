FROM node:18-alpine

WORKDIR /app

# Copy package files
COPY package*.json ./

# Install dependencies
RUN npm install

# Install supergateway globally
RUN npm install -g supergateway

# Copy server code
COPY simple-server.js ./

# Make server executable
RUN chmod +x simple-server.js

# Create logs directory
RUN mkdir -p logs

# Run as non-root user
USER node

CMD ["npm", "start"]