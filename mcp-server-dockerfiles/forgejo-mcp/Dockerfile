# Build stage
FROM golang:1.24-alpine AS builder

# Install git and make
RUN apk add --no-cache git make

# Clone the repository
WORKDIR /app
RUN git clone https://codeberg.org/goern/forgejo-mcp.git .

# Build the application
RUN make build

# Runtime stage
FROM alpine:latest

# Install ca-certificates for HTTPS
RUN apk add --no-cache ca-certificates

# Copy the built binary from the build stage
COPY --from=builder /app/forgejo-mcp /usr/local/bin/

# Create config directory
RUN mkdir -p /etc/forgejo-mcp

# Set the entrypoint
ENTRYPOINT ["forgejo-mcp"]

# Default command (can be overridden)
CMD ["-t", "sse", "--port", "8989"]
