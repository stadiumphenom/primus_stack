# Build stage
FROM golang:1.24-bullseye AS builder

# Set the working directory
WORKDIR /app

# Clone the repository
RUN apt-get update && apt-get install -y git
RUN git clone https://gitea.com/gitea/gitea-mcp.git .

# Download dependencies
RUN go mod download

# Build the binary
RUN CGO_ENABLED=0 go build -ldflags="-s -w -X main.Version=0.1.9" -o gitea-mcp

# Final stage
FROM debian:bullseye-slim

# Install ca-certificates for HTTPS requests
RUN apt-get update && \
    apt-get install -y ca-certificates && \
    rm -rf /var/lib/apt/lists/*

# Create a non-root user
RUN useradd -r -u 1000 -m gitea-mcp

# Create directory for logs
RUN mkdir -p /home/gitea-mcp/.gitea-mcp && \
    chown -R gitea-mcp:gitea-mcp /home/gitea-mcp

# Set the working directory
WORKDIR /app

# Copy the binary from builder
COPY --from=builder --chown=gitea-mcp:gitea-mcp /app/gitea-mcp .

# Copy the startup script
COPY --chown=gitea-mcp:gitea-mcp start.sh .
RUN chmod +x /app/start.sh

# Expose the port for SSE
EXPOSE 3008

# Use the non-root user
USER gitea-mcp

# Run the startup script
CMD ["/app/start.sh"]
