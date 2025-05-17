# Project NOVA: Networked Orchestration of Virtual Agents

Project NOVA (Networked Orchestration of Virtual Agents) is a comprehensive, self-hosted AI assistant ecosystem that leverages n8n workflows, LLMs, and 25+ specialized Model Context Protocol (MCP) servers to create a powerful, extensible agent system capable of controlling both digital environments and physical devices in your home.

## 🌟 Features

- **Centralized AI Assistant Hub**: Route requests to 25+ specialized agents through an intelligent router
- **Domain-Specific Capabilities**: Knowledge management, development tools, media production, home automation, and more
- **Self-Hosted & Privacy-Focused**: Run everything locally with open-source components
- **Containerized Architecture**: Easy deployment with Docker, Dockerfiles, and docker-compose.yml files
- **SSE Transport Integration**: Enhanced MCP server communication using supergateway
- **Extensible Framework**: Add new specialized agents with provided templates

## 🏗️ Architecture Overview

Project NOVA uses a hub-and-spoke architecture where the main router agent analyzes user requests and delegates to specialized agents:

![Architecture Diagram](https://github.com/dujonwalker/project-nova/blob/main/screenshots/architecture.png)

## 📚 Reference Guide

Project NOVA includes a comprehensive reference guide to help you understand and use all available agents effectively:

- **[Agent Index](reference-guide/agents-index.md)**: Complete overview of all agents with capabilities and links
- **[Router Agent Quick Reference](reference-guide/router-agent-quick-reference.md)**: How the routing system works and best practices
- **Sub-Agents by Category**:
  - [Knowledge Management Agents](reference-guide/sub-agents-by-category/knowledge-agents.md): Documentation, notes, and information management tools
  - [Development & Repository Agents](reference-guide/sub-agents-by-category/devops-agents.md): Code, repository, and system management tools
  - [Media & Creative Agents](reference-guide/sub-agents-by-category/media-agents.md): Audio, video, and creative production tools
  - [AI & Automation Agents](reference-guide/sub-agents-by-category/automation-agents.md): Workflow, browser automation, and AI extension tools

The reference guide provides detailed information about each agent's capabilities, tools, example queries, and troubleshooting tips.

## 📋 Specialized Agents

Project NOVA includes over 25 specialized agents across multiple domains:

### Knowledge Management & Note-Taking
- [TriliumNext Notes Agent](https://github.com/tan-yong-sheng/triliumnext-mcp) - Controls TriliumNext Notes knowledge base application
- [Blinko Agent](https://github.com/BryceWG/mcp-server-blinko) - Manages notes in the Blinko note-taking service
- [BookStack Agent](https://github.com/yellowgg2/mcp-bookstack) - Interfaces with BookStack documentation and wiki platform
- [Memos Agent](https://github.com/LeslieLeung/mcp-server-memos) - Works with lightweight Memos note-taking application
- [Outline Agent](https://github.com/mmmeff/outline-mcp-server) - Manages Outline knowledge base for team documentation
- [SiYuan Agent](https://github.com/onigeya/siyuan-mcp-server) - Controls SiYuan Note personal knowledge management system
- [Karakeep Agent](https://docs.karakeep.app/mcp/) - Organizes digital content collections and bookmarks
- [Paperless Agent](https://github.com/nloui/paperless-mcp) - Manages Paperless-NGX document management system
- [OnlyOffice Agent](https://github.com/ONLYOFFICE/docspace-mcp) - Manages ONLYOFFICE DocSpace for document collaboration

### Development & Repository Management
- [CLI Server Agent](https://github.com/MladenSU/cli-mcp-server) - Provides secure command-line execution capabilities
- [Forgejo Agent](https://github.com/goern/forgejo-mcp) - Manages Forgejo Git repositories and issues
- [Gitea Agent](https://gitea.com/gitea/gitea-mcp) - Controls Gitea Git service for repository management
- [System Search Agent](https://github.com/mamertofabian/mcp-everything-search) - Finds files and folders across file systems

### Media & Creative Tools
- [Ableton Copilot](https://github.com/xiaolaa2/ableton-copilot-mcp) - Assists with music production in Ableton Live
- [OBS Agent](https://github.com/royshil/obs-mcp) - Controls OBS Studio for streaming and recording
- [Reaper Agent](https://github.com/hamzabels85/reaper-mcp) - Controls REAPER digital audio workstation
- [Reaper QA Agent](https://github.com/dschuler36/reaper-mcp-server) - Analyzes and answers questions about REAPER projects
- [YouTube Agent](https://github.com/adhikasp/mcp-youtube) - Transcribes YouTube videos for summarization and content analysis

### AI & Automation
- [Flowise Agent](https://github.com/matthewhand/mcp-flowise) - Connects to Flowise chatflows and AI assistants
- [Langfuse Agent](https://github.com/langfuse/mcp-server-langfuse) - Accesses managed prompts from Langfuse
- [Puppeteer Agent](https://github.com/modelcontextprotocol/servers/tree/main/src/puppeteer) - Provides browser automation for web scraping and testing
- [RAGFlow Agent](https://github.com/xiangmy21/ragflow_mcp_server) - Retrieval-augmented generation with source citations
- [Fetch Agent](https://github.com/zcaceres/fetch-mcp) - Retrieves web content from URLs with advanced options

### Monitoring & Home Automation
- [Home Assistant Agent](https://github.com/voska/hass-mcp) - Controls smart home devices through Home Assistant
- [Prometheus Agent](https://github.com/pab1it0/prometheus-mcp-server) - Queries and analyzes metrics from Prometheus monitoring

## 🚀 Getting Started

### Prerequisites

Before setting up Project NOVA, ensure you have:

- **n8n Instance**: A running n8n installation (v1.88.0 or later)
  - **Critical**: Version 1.88.0+ (released April 10, 2025) is required as it introduced the MCP Client Tool node
  - This node is essential for connecting to MCP-enabled services
- **Community Nodes**:
  - [nerding-io/n8n-nodes-mcp-client](https://github.com/nerding-io/n8n-nodes-mcp-client) - Required as some agents use this community implementation
  - Project NOVA currently uses a mix of official and community MCP nodes
- **Docker Host**: Environment for running containerized MCP servers
- **LLM Access**: Either:
  - Cloud API access (OpenAI, Claude, Gemini, etc.)
  - Local Ollama instance with models that support tool use/function calling
- **Applications to Control**:
  - The actual applications you want NOVA to control (most agents are designed for self-hosted applications)
  - Examples: Home Assistant, Gitea, Reaper, OBS Studio, TriliumNext, etc.
  - Each agent requires its corresponding application to be accessible

This repository contains all the tools and instructions needed to build your own AI assistant ecosystem using n8n as the workflow automation platform.

1. Clone the repository:
   ```bash
   git clone https://github.com/dujonwalker/project-nova.git
   cd project-nova
   ```

2. Import workflows in your n8n instance:
   - **Bulk import via n8n CLI** (easiest):
     ```bash
     # Navigate to your n8n installation directory
     n8n import:workflow --input=path/to/project-nova/n8n-workflows/*
     ```
   - **Import via n8n Web Interface**:
     - Navigate to your n8n dashboard
     - Click on "Workflows" in the sidebar
     - Use the "Import from file" option for each workflow
     - Start with core workflows first, then specialized agents

3. Set up MCP servers:
   - Use the Dockerfiles and docker-compose.yml files provided in `mcp-server-dockerfiles` to build and run your servers
   - Or use the instructions to set up MCP servers directly on your host

4. Configure your API keys:
   - Update credentials in each workflow for your LLM provider
   - Set up your preferred LLM API (OpenAI, Claude, Gemini, etc.)
   - For local deployment, configure Ollama with any models that support tool use/function calling (examples include qwen3, llama3.1, mistral, and others)
   - Give NOVA the keys to your apps (i.e., Paperless-NGX API key, Gitea API key, Home Assistant token, etc.)

5. Start with the router agent:
   - Once your workflows and agents are set up, navigate to the router agent workflow in n8n
   - Use the chat trigger node to start a conversation with NOVA
   - The router will analyze your requests and direct them to the appropriate specialized agents

> **Note:** The repository is structured to make replication as straightforward as possible. You can choose to implement all agents or just the ones you need.

<p align="center">
  <img src="https://github.com/dujonwalker/project-nova/blob/main/screenshots/chat-interface.png?raw=true" alt="Chat Interface" width="50%">
</p>

## 📁 Repository Structure

```
project-nova/
├── README.md                      # This README file
├── agents/                        # System prompts for all agents
├── mcp-server-dockerfiles/        # Dockerfiles and docker-compose.yml files for MCP servers
│   ├── [server-name]-mcp/         # Each MCP server has its own directory
│   │   ├── Dockerfile             # Container definition
│   │   ├── docker-compose.yml     # Deployment configuration
│   │   ├── README.md              # Server-specific setup instructions
│   │   └── start.sh               # Entry point script (when applicable)
├── n8n-workflows/                 # n8n workflow export files (.json)
├── prompt-templates/              # Templates for creating new components
│   ├── agent-input-examples/      # Example inputs for each agent (.json)
│   ├── generate-agent.md          # Template for creating new agents
│   ├── generate-container.md      # Guide for containerizing MCP servers
│   └── generate-routing-agent.md  # Router agent generation template
└── reference-guide/               # Comprehensive documentation
    ├── agents-index.md            # Complete list of all agents
    ├── router-agent-quick-reference.md  # Router usage guide
    └── sub-agents-by-category/    # Detailed agent documentation by domain
        ├── knowledge-agents.md
        ├── devops-agents.md
        ├── media-agents.md
        └── automation-agents.md
```

## 🔧 Advanced Configuration

### Adding a New Specialized Agent

1. Use the `generate-agent.md` template to create a new agent system prompt
2. Create a Dockerfile using `generate-container.md` as a guide
3. Add n8n workflow configuration
4. Update the router agent to include your new specialized agent

## 🔍 Use Cases

- **Home Automation**: "Turn off the living room lights and start playing my evening playlist"
- **Knowledge Management**: "Find my notes about the project meeting from last Tuesday"
- **Creative Production**: "Help me set up a new Ableton Live project with a drum rack"
- **Development Assistance**: "Check my Gitea repositories for any open pull requests"
- **System Management**: "Monitor the CPU usage on my server for the last 24 hours"

## 🛠️ Troubleshooting

- **Agent Not Responding**: Check Docker container logs for the specific MCP server
- **Router Misidentifying Agent**: Review the router-agent.md system prompt for accurate routing logic
- **API Connectivity Issues**: Verify API keys in your .env file and container environment
- **Prompt Configuration**: Make sure all sub-agents have the prompt (user message) set to `{{ $json.input }}` in their n8n workflow configuration

## 📊 Performance Considerations

- Recommended minimum specs: 4GB RAM, 2 CPU cores for basic setup
- For running all agents simultaneously: 16GB RAM, 8 CPU cores recommended
- Consider using local LLM inference options for reduced API costs and latency

## 🔮 Future Development

- [ ] Integration with OpenWebUI to provide:
  - Voice interface integration
  - Sending and receiving files
- [ ] More specialized agents for additional domains

## 🙏 Acknowledgments

- [n8n](https://n8n.io/) for the incredible workflow automation platform
- [Model Context Protocol](https://modelcontextprotocol.io/) for standardizing AI tool interaction
- [Supergateway](https://github.com/supercorp-ai/supergateway) for enabling conversion from STDIO to SSE transport
- [nerding-io](https://github.com/nerding-io/n8n-nodes-mcp) for their pioneering work on n8n-nodes-mcp that inspired this project
- All the open-source projects that make the specialized agents possible

## 📚 Additional Resources

- [Project NOVA: Detailed Write-up](https://dev.dujon.ca/project-nova/) - Comprehensive blog post with additional insights and implementation details
- For questions or support, please open an issue in this repository

## 🔍 MCP Resources

If you're looking to expand your Project NOVA with additional agents, here are some valuable resources for finding MCP servers:

### Verified Working MCP Servers
- [**My Curated List of Working MCP Servers**](https://github.com/stars/dujonwalker/lists/fire-fire-mcp-servers-fire) - A regularly updated collection of GitHub-hosted MCP servers I've personally tested and verified working with Project NOVA. Note that some servers hosted on other platforms (like gitea-mcp) won't appear in this GitHub-specific list.

### Additional MCP Directories
- [MCP.so](https://mcp.so/) - A comprehensive directory of MCP libraries
- [MCPServers.org](https://mcpservers.org/) - Collection of available MCP servers
- [MCP Servers GitHub](https://github.com/modelcontextprotocol/servers) - Official MCP servers repository
- [MCP Directory](https://mcpdirectory.ai/) - Searchable directory of MCP servers
- [Smithery AI](https://smithery.ai/) - MCP server development platform
- [Glama.ai MCP Servers](https://glama.ai/mcp/servers) - Curated list of MCP servers
- [MCPHub.ai](https://www.mcphub.ai/servers) - Hub for MCP server discovery
- [Awesome MCP Servers](https://github.com/punkpeye/awesome-mcp-servers) - Curated list of awesome MCP servers

These resources can help you discover new MCP servers to integrate into your own Project NOVA implementation.
