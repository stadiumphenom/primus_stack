FROM ubuntu:24.04

# Set noninteractive installation to avoid prompts
ENV DEBIAN_FRONTEND=noninteractive

# Install system dependencies
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    python3-venv \
    python3-full \
    curl \
    git \
    openssh-client \
    nodejs \
    npm \
    wget \
    nano \
    vim \
    rsync \
    ffmpeg \
    imagemagick \
    zip \
    unzip \
    jq \
    net-tools \
    iputils-ping \
    traceroute \
    nmap \
    apt-transport-https \
    ca-certificates \
    gnupg \
    lsb-release \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Install Docker CLI
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg \
    && echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" \
    > /etc/apt/sources.list.d/docker.list \
    && apt-get update \
    && apt-get install -y docker-ce docker-ce-cli containerd.io \
    && rm -rf /var/lib/apt/lists/*

# Create app directory
WORKDIR /app

# Install supergateway for STDIO to SSE conversion
RUN npm install -g supergateway

# Clone the CLI MCP Server repository
RUN git clone https://github.com/MladenSU/cli-mcp-server.git /app/cli-mcp-server

# Create and activate a virtual environment
RUN python3 -m venv /app/venv
ENV PATH="/app/venv/bin:$PATH"
ENV VIRTUAL_ENV="/app/venv"

# Install CLI MCP Server in the virtual environment
RUN cd /app/cli-mcp-server && pip install -e .

# Add startup script
COPY start.sh /app/start.sh
RUN chmod +x /app/start.sh

# Create a directory for command execution
RUN mkdir -p /data

# Set the command execution directory to /data by default
ENV ALLOWED_DIR=/data

# Set default security settings
ENV ALLOWED_COMMANDS=all
ENV ALLOWED_FLAGS=all
ENV MAX_COMMAND_LENGTH=4096
ENV COMMAND_TIMEOUT=60
ENV ALLOW_SHELL_OPERATORS=true

# Expose the SSE port
EXPOSE 3009

# Start the server
CMD ["/app/start.sh"]
