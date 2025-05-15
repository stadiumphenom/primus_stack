#!/bin/bash

# Print server configuration for debugging
echo "Starting CLI MCP Server with the following configuration:"
echo "------------------------------------------------------"
echo "Host IP: ${HOST_IP:-192.168.50.167}"
echo "SSE Port: ${SSE_PORT:-3009}"
echo "Allowed Directory: ${ALLOWED_DIR:-/data}"
echo "Allowed Commands: ${ALLOWED_COMMANDS:-all}"
echo "Allowed Flags: ${ALLOWED_FLAGS:-all}"
echo "Max Command Length: ${MAX_COMMAND_LENGTH:-4096}"
echo "Command Timeout: ${COMMAND_TIMEOUT:-60}"
echo "Allow Shell Operators: ${ALLOW_SHELL_OPERATORS:-true}"
echo "------------------------------------------------------"

# Create a wrapper Python script to run the server
cat > /app/run_server.py << 'EOL'
import asyncio
import sys
import importlib
import os
import traceback

try:
    print("Importing cli_mcp_server...")
    from cli_mcp_server import server
    
    print("Import successful!")
    print("Server module attributes:")
    for attr in dir(server):
        if not attr.startswith("__"):
            print(f" - {attr}")
    
    # Check if there's a main function
    if hasattr(server, "main"):
        print("Running server.main()...")
        asyncio.run(server.main())
    else:
        # Look for other possible entry points
        print("No main() function. Looking for alternatives...")
        
        # Try to find likely entry points
        candidates = []
        for attr in dir(server):
            if attr.lower() in ['main', 'run', 'start', 'serve', 'server', 'app']:
                candidates.append(attr)
                
        if candidates:
            print(f"Found possible entry points: {candidates}")
            # Try to run the first candidate
            entry_func = getattr(server, candidates[0])
            if callable(entry_func):
                print(f"Running server.{candidates[0]}()...")
                if asyncio.iscoroutinefunction(entry_func):
                    asyncio.run(entry_func())
                else:
                    entry_func()
            else:
                print(f"Error: {candidates[0]} is not callable")
        else:
            print("No suitable entry point found. Manual inspection needed.")
            
except Exception as e:
    print(f"Error: {e}")
    print("Traceback:")
    traceback.print_exc()
    
    print("\nDetailed module information:")
    try:
        import subprocess
        res = subprocess.run(["pip", "show", "cli-mcp-server"], capture_output=True, text=True)
        print(res.stdout)
        
        print("\nSearching for server.py files:")
        res = subprocess.run(["find", "/app", "-name", "server.py"], capture_output=True, text=True)
        print(res.stdout)
    except Exception as e2:
        print(f"Error during debugging: {e2}")
EOL

# Start supergateway with the Python wrapper
supergateway --stdio "python /app/run_server.py" --port ${SSE_PORT:-3009} --host ${HOST_IP:-0.0.0.0}
