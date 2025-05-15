# Build stage
FROM node:18-alpine

# Install git and other dependencies
RUN apk add --no-cache git

# Set working directory
WORKDIR /app

# Clone the repository
RUN git clone https://github.com/mmmeff/outline-mcp.git .

# Print package.json content to examine scripts and entry points
RUN echo "===== PACKAGE.JSON CONTENT =====" && cat package.json

# Install dependencies
RUN npm install

# List all files in the repository root
RUN echo "===== ROOT DIRECTORY CONTENTS =====" && ls -la

# List all JavaScript files that might be entry points
RUN echo "===== POTENTIAL ENTRY POINTS =====" && \
    find . -name "*.js" -not -path "*/node_modules/*" -not -path "*/\.*" | sort

# Check package.json for "bin" entries that would act as CLI entrypoints
RUN echo "===== BIN ENTRIES FROM PACKAGE.JSON =====" && \
    grep -A 10 '"bin"' package.json || echo "No bin entries found"

# Check package.json for "main" entry
RUN echo "===== MAIN ENTRY FROM PACKAGE.JSON =====" && \
    grep -A 2 '"main"' package.json || echo "No main entry found"

# List npm scripts that might be used to start the server
RUN echo "===== NPM SCRIPTS =====" && \
    grep -A 15 '"scripts"' package.json || echo "No scripts found"

# Expose the default port
EXPOSE 6060

# Set environment variables
ENV OUTLINE_API_KEY=""
ENV OUTLINE_API_URL=""

# Use the npm start command if available, as it's a common way to start Node.js applications
CMD ["npm", "start"]
