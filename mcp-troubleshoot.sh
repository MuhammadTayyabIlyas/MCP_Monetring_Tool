#!/bin/bash

# MCP Server Troubleshooting Script
# Automatically diagnose and suggest fixes for MCP server issues

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}=== MCP Server Troubleshooter ===${NC}\n"

# Function to check and suggest fix
suggest_fix() {
    local server_name=$1
    local issue=$2
    local fix=$3

    echo -e "${RED}Issue with $server_name:${NC} $issue"
    echo -e "${GREEN}Suggested fix:${NC} $fix"
    echo ""
}

# Check each server type

# Check Python-based servers
echo -e "${YELLOW}Checking Python-based servers...${NC}"
if ! command -v python3 &> /dev/null; then
    suggest_fix "Python servers" "python3 not found" "Install Python: sudo apt-get install python3"
else
    echo -e "${GREEN}✓${NC} Python3 is installed: $(python3 --version)"
fi

# Check Node.js-based servers
echo -e "\n${YELLOW}Checking Node.js-based servers...${NC}"
if ! command -v node &> /dev/null; then
    suggest_fix "Node.js servers" "node not found" "Install Node.js: curl -fsSL https://deb.nodesource.com/setup_lts.sh | sudo -E bash - && sudo apt-get install -y nodejs"
else
    echo -e "${GREEN}✓${NC} Node.js is installed: $(node --version)"
fi

if ! command -v npx &> /dev/null; then
    suggest_fix "NPX" "npx not found" "Install npm: sudo apt-get install npm"
else
    echo -e "${GREEN}✓${NC} NPX is available"
fi

# Check uvx for DuckDuckGo
echo -e "\n${YELLOW}Checking uvx (for DuckDuckGo search)...${NC}"
if ! command -v uvx &> /dev/null; then
    suggest_fix "DuckDuckGo" "uvx not found" "Install uv: curl -LsSf https://astral.sh/uv/install.sh | sh"
else
    echo -e "${GREEN}✓${NC} uvx is installed"
fi

# Check virtual environments
echo -e "\n${YELLOW}Checking Python virtual environments...${NC}"
for venv in "/home/tayyabcheema777/.venv" "/home/tayyabcheema777/.venv-google-docs" "/home/tayyabcheema777/ali/windows_mcp_venv"; do
    venv_name=$(basename $venv)
    if [ -d "$venv" ]; then
        if [ -f "$venv/bin/python" ] || [ -f "$venv/bin/python3" ]; then
            echo -e "${GREEN}✓${NC} $venv_name exists and has Python"
        else
            suggest_fix "$venv_name" "Python binary missing in venv" "Recreate venv: python3 -m venv $venv"
        fi
    else
        echo -e "${RED}✗${NC} $venv_name not found at $venv"
    fi
done

# Check API keys/credentials
echo -e "\n${YELLOW}Checking API credentials...${NC}"

# ElevenLabs API key
if grep -q "ELEVENLABS_API_KEY" ~/.claude.json 2>/dev/null; then
    echo -e "${GREEN}✓${NC} ElevenLabs API key is configured"
    echo -e "${YELLOW}Note:${NC} Verify key is valid at https://elevenlabs.io/app/settings/api-keys"
else
    suggest_fix "ElevenLabs" "API key not configured" "Add API key to ~/.claude.json"
fi

# Notion token
if grep -q "NOTION_TOKEN" ~/.claude.json 2>/dev/null; then
    echo -e "${GREEN}✓${NC} Notion token is configured"
else
    suggest_fix "Notion" "Token not configured" "Add NOTION_TOKEN to ~/.claude.json"
fi

# Google credentials
if [ -f "/home/tayyabcheema777/.local/state/google-docs-mcp/token.json" ]; then
    echo -e "${GREEN}✓${NC} Google OAuth token exists"
else
    echo -e "${YELLOW}!${NC} Google OAuth token not found - you may need to authenticate"
fi

# Check for common issues
echo -e "\n${YELLOW}Checking for common issues...${NC}"

# Check if cron is running
if systemctl is-active --quiet cron 2>/dev/null || service cron status >/dev/null 2>&1; then
    echo -e "${GREEN}✓${NC} Cron service is running"
else
    suggest_fix "Cron" "Cron service not running" "Start cron: sudo service cron start"
fi

# Check disk space
DISK_USAGE=$(df -h ~ | awk 'NR==2 {print $5}' | sed 's/%//')
if [ "$DISK_USAGE" -gt 90 ]; then
    suggest_fix "Disk space" "Disk usage is ${DISK_USAGE}%" "Free up disk space"
else
    echo -e "${GREEN}✓${NC} Disk space is healthy (${DISK_USAGE}% used)"
fi

# Check network connectivity
echo -e "\n${YELLOW}Checking network connectivity...${NC}"
if ping -c 1 8.8.8.8 >/dev/null 2>&1; then
    echo -e "${GREEN}✓${NC} Internet connection is working"
else
    suggest_fix "Network" "No internet connection" "Check your network connection"
fi

# Check Claude Code logs for errors
echo -e "\n${YELLOW}Recent MCP errors from logs:${NC}"
if [ -f "/home/tayyabcheema777/.claude/mcp-health.log" ]; then
    recent_errors=$(grep "FAILED" /home/tayyabcheema777/.claude/mcp-health.log | tail -5)
    if [ -n "$recent_errors" ]; then
        echo "$recent_errors"
    else
        echo -e "${GREEN}✓${NC} No recent errors found"
    fi
else
    echo "No log file found yet"
fi

echo -e "\n${BLUE}=== Quick Fixes ===${NC}"
echo "1. Restart all MCP servers: Restart Claude Code"
echo "2. Clear MCP cache: rm -rf ~/.claude/mcp-cache/"
echo "3. Reinstall problematic server:"
echo "   - Python: pip install --force-reinstall <package>"
echo "   - Node: npm install -g <package>"
echo "4. Check Claude Code docs: https://docs.claude.com/en/docs/claude-code/mcp"
echo ""
