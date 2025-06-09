# Project NOVA: Networked Orchestration of Virtual Agents

Project NOVA (Networked Orchestration of Virtual Agents) is a comprehensive, self-hosted AI assistant ecosystem that leverages n8n workflows, LLMs, and 25+ specialized Model Context Protocol (MCP) servers to create a powerful, extensible agent system capable of controlling both digital environments and physical devices in your home.

## 🌟 Features

- **Centralized AI Assistant Hub**: Route requests to 25+ specialized agents through an intelligent router
- **Conversation-Aware Intelligence**: Maintains context across interactions with advanced conversation history processing
- **OpenWebUI Integration**: Modern chat interface with conversation persistence and enhanced user experience
- **Domain-Specific Capabilities**: Knowledge management, development tools, media production, home automation, and more
- **Self-Hosted & Privacy-Focused**: Run everything locally with open-source components
- **Containerized Architecture**: Easy deployment with Docker, Dockerfiles, and docker-compose.yml files
- **SSE Transport Integration**: Enhanced MCP server communication using supergateway
- **Extensible Framework**: Add new specialized agents with provided templates and comprehensive documentation

## 🏗️ Architecture Overview

Project NOVA uses a sophisticated hub-and-spoke architecture with conversation intelligence:

![Architecture Diagram](https://github.com/dujonwalker/project-nova/blob/main/screenshots/architecture.png)

### Current Architecture Components:
- **OpenWebUI Frontend**: Modern chat interface with conversation history and session management
- **n8n Workflow Engine**: Processes requests and orchestrates agent communication
- **Intelligent Router Agent**: Analyzes requests and conversation context to route to appropriate specialized agents
- **25+ Specialized Agents**: Domain-specific MCP-powered agents for various tasks
- **MCP Server Ecosystem**: Containerized services providing tool capabilities to agents

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
- Blinko Agent - Manages notes in the Blinko note-taking service (uses custom MCP implementation)
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

## 🔍 Use Cases

- **Home Automation**: "Turn off the living room lights and start playing my evening playlist"
- **Knowledge Management**: "Find my notes about the project meeting from last Tuesday"
- **Creative Production**: "Help me set up a new Ableton Live project with a drum rack"
- **Development Assistance**: "Check my Gitea repositories for any open pull requests"
- **System Management**: "Monitor the CPU usage on my server for the last 24 hours"
- **Content Analysis**: "Get the transcript from this YouTube video and summarize the key points"

## 🚀 Getting Started

### Prerequisites

Before setting up Project NOVA, ensure you have:

#### Option A: OpenWebUI + n8n Setup (Recommended)
- **OpenWebUI Instance**: For the modern chat interface with conversation management
  - **Note**: For text-to-speech features (voice input), OpenWebUI requires SSL/HTTPS (even a self-signed certificate works)
- **n8n Instance**: A running n8n installation (v1.88.0 or later)
  - **Critical**: Version 1.88.0+ is required as it introduced the MCP Client Tool node
- **Community Nodes**:
  - [nerding-io/n8n-nodes-mcp-client](https://github.com/nerding-io/n8n-nodes-mcp-client) - Required for some agents

#### Option B: n8n Only Setup (Basic)
- **n8n Instance**: A running n8n installation (v1.88.0 or later) with chat trigger capabilities
- **Community Nodes**: Same as above

#### Common Requirements
- **Docker Host**: Environment for running containerized MCP servers
- **LLM Access**: Either:
  - Cloud API access (OpenAI, Claude, Gemini, etc.)
  - Local Ollama instance with models that support tool use/function calling
- **Applications to Control**:
  - The actual applications you want NOVA to control (most agents are designed for self-hosted applications)
  - Examples: Home Assistant, Gitea, Reaper, OBS Studio, TriliumNext, etc.
  - Each agent requires its corresponding application to be accessible

### Setup Instructions

#### 1. Clone the Repository
```bash
git clone https://github.com/dujonwalker/project-nova.git
cd project-nova
```

#### 2. Choose Your Deployment Option

**Option A: OpenWebUI + n8n (Recommended)**

This setup provides the best user experience with conversation history, session management, and a modern interface.

1. **Set up OpenWebUI inlet filter**:
   - In your OpenWebUI instance, navigate to **Workspace** → **Functions**
   - Click **"Create New Function"**
   - Copy and paste the code from `openwebui-function/n8n_inlet_filter.py` into the function editor
   - **Important**: Update the `n8n_url` configuration variable at the top of the filter with your complete n8n webhook URL (including server IP/hostname and webhook UUID)
   - Save the filter

2. **Create a new model using the filter**:
   - Navigate to **Workspace** → **Models**
   - Click **"Create New Model"**
   - Configure your base model (e.g., your preferred LLM)
   - In the **Filters** section, select the n8n inlet filter you just created
   - Save the model
   - The filter will now automatically forward messages to n8n and manage conversation history

3. **Configure n8n workflows**:
   - Import the router agent workflow (`n8n-workflows/router_agent.json`)
   - Set up a webhook trigger in the router agent (configure URL in OpenWebUI filter)
   - Import specialized agent workflows as needed

**Option B: n8n Only Setup**

1. **Import workflows in your n8n instance**:
   - **Bulk import via n8n CLI** (easiest):
     ```bash
     # Navigate to your n8n installation directory
     n8n import:workflow --input=path/to/project-nova/n8n-workflows/*
     ```
   - **Import via n8n Web Interface**:
     - Navigate to your n8n dashboard
     - Click on "Workflows" in the sidebar
     - Use the "Import from file" option for each workflow
     - Start with the router agent first, then specialized agents

2. **Configure after import**:
   - **Update OpenWebUI filter**: Copy the webhook URL from your imported router agent and paste it into the OpenWebUI inlet filter configuration
   - **Configure API keys**: Add your actual API keys for the services you want to use (Blinko, Home Assistant, etc.)
   - **Update server IPs**: Replace `YOUR_SERVER_IP` placeholders with your actual server addresses

#### 3. Set up MCP Servers
- Use the Dockerfiles and docker-compose.yml files provided in `mcp-server-dockerfiles` to build and run your servers
- Or use the instructions to set up MCP servers directly on your host
- Configure each MCP server for the agents you plan to use

#### 4. Configure Your API Keys and Credentials
- **LLM Provider**: Update credentials in each workflow for your LLM provider (OpenAI, Claude, Gemini, etc.)
- **Application APIs**: Give NOVA the keys to your apps (Paperless-NGX API key, Gitea API key, Home Assistant token, etc.)
- **MCP Server Connections**: Configure SSE endpoints or server connections in each workflow

#### 5. Start Using NOVA

**With OpenWebUI Setup:**
- Navigate to your OpenWebUI instance
- Start a conversation - messages are automatically processed through n8n
- The inlet filter handles conversation history and routing automatically

**With n8n Only Setup:**
- Navigate to the router agent workflow in n8n
- Disconnect the webhook trigger node and connect the chat trigger node instead (the chat trigger is already present but disconnected by default)
- Use the chat trigger node to start a conversation with NOVA
- The router will analyze your requests and direct them to appropriate specialized agents

## 🔧 Advanced Configuration

### OpenWebUI Integration Details

The OpenWebUI integration uses an inlet filter (`openwebui-function/n8n_inlet_filter.py`) that:

- **Processes all incoming messages** through n8n before they reach the LLM
- **Manages conversation history** by extracting and forwarding previous messages
- **Prevents duplicate calls** with intelligent deduplication (30-second window)
- **Handles session management** with unique chat IDs
- **Returns n8n responses** directly to the user through system message injection

Key configuration options in the filter:
- `n8n_url`: Your n8n webhook endpoint URL
- `n8n_bearer_token`: Authentication token for n8n
- `timeout`: Request timeout for n8n calls (default: 15 seconds)
- `enabled`: Toggle to enable/disable n8n processing

### Conversation History Processing

Project NOVA now includes sophisticated conversation context handling:

**Router Agent Features:**
- Processes conversation history to understand context
- Provides intelligent follow-up routing (e.g., "any repos with X in the name?" continues with the same repository agent)
- Maintains session continuity across interactions

**Sub-Agent Features:**
- All specialized agents receive conversation history when available
- Agents can reference previous interactions for better context
- Consistent conversation experience across agent handoffs

### Adding a New Specialized Agent

1. Use the `prompt-templates/generate-agent.md` template to create a new agent system prompt
2. Create a Dockerfile using `prompt-templates/generate-container.md` as a guide
3. Add n8n workflow configuration using existing workflows as templates
4. Update the router agent to include your new specialized agent
5. Add documentation to the reference guide

## 📁 Repository Structure

```
project-nova/
├── README.md                      # This comprehensive README file
├── agents/                        # System prompts for all agents (reference)
├── mcp-server-dockerfiles/        # Dockerfiles and docker-compose.yml files for MCP servers
│   ├── [server-name]-mcp/         # Each MCP server has its own directory
│   │   ├── Dockerfile             # Container definition
│   │   ├── docker-compose.yml     # Deployment configuration
│   │   ├── README.md              # Server-specific setup instructions
│   │   └── start.sh               # Entry point script (when applicable)
├── n8n-workflows/                 # n8n workflow export files (.json) - THE ACTUAL WORKING SYSTEM
├── openwebui-function/            # OpenWebUI integration components
│   └── n8n_inlet_filter.py       # OpenWebUI inlet filter for n8n integration
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

## 📊 Performance Considerations

- **Recommended minimum specs for basic setup**: 4GB RAM, 2 CPU cores
- **For OpenWebUI + full agent ecosystem**: 16GB RAM, 8 CPU cores recommended
- **Consider using local LLM inference** (Ollama) for reduced API costs and latency
- **MCP server resource usage** varies by agent - monitor container usage and scale as needed

## 🔮 Future Development

- [ ] Enhanced OpenWebUI integration features:
  - File upload support through agents
- [ ] Additional specialized agents for more domains

## 🙏 Acknowledgments

- [n8n](https://n8n.io/) for the incredible workflow automation platform
- [OpenWebUI](https://openwebui.com/) for the excellent frontend interface with conversation management
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
