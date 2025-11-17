#!/bin/bash

# MCP Server Health Check Script
# This script checks the health of all configured MCP servers

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
CLAUDE_CONFIG="$HOME/.claude.json"
LOG_FILE="$HOME/.claude/mcp-health.log"
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

# Create log directory if it doesn't exist
mkdir -p "$HOME/.claude"

# Function to log messages
log_message() {
    echo "[$TIMESTAMP] $1" >> "$LOG_FILE"
}

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to check Python package
check_python_package() {
    python3 -c "import $1" 2>/dev/null
    return $?
}

# Function to check Node package
check_node_package() {
    npx -y "$1" --version >/dev/null 2>&1
    return $?
}

echo -e "${BLUE}=== MCP Server Health Check ===${NC}"
echo -e "Time: $TIMESTAMP\n"

log_message "Starting MCP health check"

# Array to store results
declare -A server_status

# Check each MCP server
echo -e "${YELLOW}Checking MCP Servers:${NC}\n"

# 1. DuckDuckGo Search
echo -n "  duckduckgo-search: "
if command_exists uvx; then
    if uvx --help >/dev/null 2>&1; then
        echo -e "${GREEN}✓ OK${NC}"
        server_status[duckduckgo-search]="OK"
        log_message "duckduckgo-search: OK"
    else
        echo -e "${RED}✗ FAILED${NC} (uvx not working)"
        server_status[duckduckgo-search]="FAILED"
        log_message "duckduckgo-search: FAILED - uvx not working"
    fi
else
    echo -e "${RED}✗ FAILED${NC} (uvx not found)"
    server_status[duckduckgo-search]="FAILED"
    log_message "duckduckgo-search: FAILED - uvx not found"
fi

# 2. Sequential Thinking
echo -n "  sequential-thinking: "
if command_exists npx; then
    echo -e "${GREEN}✓ OK${NC}"
    server_status[sequential-thinking]="OK"
    log_message "sequential-thinking: OK"
else
    echo -e "${RED}✗ FAILED${NC} (npx not found)"
    server_status[sequential-thinking]="FAILED"
    log_message "sequential-thinking: FAILED - npx not found"
fi

# 3. Playwright
echo -n "  playwright: "
if [ -f "/home/tayyabcheema777/.venv/bin/playwright-mcp" ]; then
    if [ -x "/home/tayyabcheema777/.venv/bin/playwright-mcp" ]; then
        echo -e "${GREEN}✓ OK${NC}"
        server_status[playwright]="OK"
        log_message "playwright: OK"
    else
        echo -e "${RED}✗ FAILED${NC} (not executable)"
        server_status[playwright]="FAILED"
        log_message "playwright: FAILED - not executable"
    fi
else
    echo -e "${RED}✗ FAILED${NC} (binary not found)"
    server_status[playwright]="FAILED"
    log_message "playwright: FAILED - binary not found"
fi

# 4. Memory
echo -n "  memory: "
if command_exists npx; then
    echo -e "${GREEN}✓ OK${NC}"
    server_status[memory]="OK"
    log_message "memory: OK"
else
    echo -e "${RED}✗ FAILED${NC} (npx not found)"
    server_status[memory]="FAILED"
    log_message "memory: FAILED - npx not found"
fi

# 5. Google Docs
echo -n "  google-docs: "
GDOCS_BIN="/home/tayyabcheema777/.venv-google-docs/bin/google-docs-mcp"
if [ -f "$GDOCS_BIN" ]; then
    if [ -x "$GDOCS_BIN" ]; then
        echo -e "${GREEN}✓ OK${NC}"
        server_status[google-docs]="OK"
        log_message "google-docs: OK"
    else
        echo -e "${RED}✗ FAILED${NC} (not executable)"
        server_status[google-docs]="FAILED"
        log_message "google-docs: FAILED - not executable"
    fi
else
    echo -e "${RED}✗ FAILED${NC} (binary not found)"
    server_status[google-docs]="FAILED"
    log_message "google-docs: FAILED - binary not found"
fi

# 6. Google Sheets
echo -n "  google-sheets: "
GSHEETS_SERVER="/home/tayyabcheema777/mcp-servers/google_sheets_server.py"
if [ -f "$GSHEETS_SERVER" ]; then
    if command_exists python3; then
        echo -e "${GREEN}✓ OK${NC}"
        server_status[google-sheets]="OK"
        log_message "google-sheets: OK"
    else
        echo -e "${RED}✗ FAILED${NC} (python3 not found)"
        server_status[google-sheets]="FAILED"
        log_message "google-sheets: FAILED - python3 not found"
    fi
else
    echo -e "${RED}✗ FAILED${NC} (server script not found)"
    server_status[google-sheets]="FAILED"
    log_message "google-sheets: FAILED - server script not found"
fi

# 7. Google Gmail
echo -n "  google-gmail: "
GGMAIL_SERVER="/home/tayyabcheema777/mcp-servers/google_gmail_server.py"
if [ -f "$GGMAIL_SERVER" ]; then
    if command_exists python3; then
        echo -e "${GREEN}✓ OK${NC}"
        server_status[google-gmail]="OK"
        log_message "google-gmail: OK"
    else
        echo -e "${RED}✗ FAILED${NC} (python3 not found)"
        server_status[google-gmail]="FAILED"
        log_message "google-gmail: FAILED - python3 not found"
    fi
else
    echo -e "${RED}✗ FAILED${NC} (server script not found)"
    server_status[google-gmail]="FAILED"
    log_message "google-gmail: FAILED - server script not found"
fi

# 8. Google Calendar
echo -n "  google-calendar: "
GCAL_SERVER="/home/tayyabcheema777/mcp-servers/google_calendar_server.py"
if [ -f "$GCAL_SERVER" ]; then
    if command_exists python3; then
        echo -e "${GREEN}✓ OK${NC}"
        server_status[google-calendar]="OK"
        log_message "google-calendar: OK"
    else
        echo -e "${RED}✗ FAILED${NC} (python3 not found)"
        server_status[google-calendar]="FAILED"
        log_message "google-calendar: FAILED - python3 not found"
    fi
else
    echo -e "${RED}✗ FAILED${NC} (server script not found)"
    server_status[google-calendar]="FAILED"
    log_message "google-calendar: FAILED - server script not found"
fi

# 9. Notion
echo -n "  notion: "
NOTION_SERVER="/home/tayyabcheema777/mcp-servers/notion-mcp-server/bin/cli.mjs"
if [ -f "$NOTION_SERVER" ]; then
    if command_exists node; then
        echo -e "${GREEN}✓ OK${NC}"
        server_status[notion]="OK"
        log_message "notion: OK"
    else
        echo -e "${RED}✗ FAILED${NC} (node not found)"
        server_status[notion]="FAILED"
        log_message "notion: FAILED - node not found"
    fi
else
    echo -e "${RED}✗ FAILED${NC} (server script not found)"
    server_status[notion]="FAILED"
    log_message "notion: FAILED - server script not found"
fi

# 10. ElevenLabs
echo -n "  11labs: "
ELEVENLABS_SERVER="/home/tayyabcheema777/.venv/lib/python3.12/site-packages/elevenlabs_mcp/server.py"
if [ -f "$ELEVENLABS_SERVER" ]; then
    if [ -n "$(/home/tayyabcheema777/.venv/bin/python3 -c 'import sys; print(sys.executable)' 2>/dev/null)" ]; then
        # Check if API key is set
        if grep -q "ELEVENLABS_API_KEY" "$CLAUDE_CONFIG" 2>/dev/null; then
            echo -e "${GREEN}✓ OK${NC} ${YELLOW}(check API key validity)${NC}"
            server_status[11labs]="OK"
            log_message "11labs: OK - but API key should be validated"
        else
            echo -e "${RED}✗ FAILED${NC} (API key not found)"
            server_status[11labs]="FAILED"
            log_message "11labs: FAILED - API key not found"
        fi
    else
        echo -e "${RED}✗ FAILED${NC} (python venv issue)"
        server_status[11labs]="FAILED"
        log_message "11labs: FAILED - python venv issue"
    fi
else
    echo -e "${RED}✗ FAILED${NC} (server script not found)"
    server_status[11labs]="FAILED"
    log_message "11labs: FAILED - server script not found"
fi

# 11. Windows MCP
echo -n "  windows-mcp: "
WINDOWS_MCP_PYTHON="/home/tayyabcheema777/ali/windows_mcp_venv/bin/python"
if [ -f "$WINDOWS_MCP_PYTHON" ]; then
    if [ -x "$WINDOWS_MCP_PYTHON" ]; then
        echo -e "${GREEN}✓ OK${NC}"
        server_status[windows-mcp]="OK"
        log_message "windows-mcp: OK"
    else
        echo -e "${RED}✗ FAILED${NC} (python not executable)"
        server_status[windows-mcp]="FAILED"
        log_message "windows-mcp: FAILED - python not executable"
    fi
else
    echo -e "${RED}✗ FAILED${NC} (python venv not found)"
    server_status[windows-mcp]="FAILED"
    log_message "windows-mcp: FAILED - python venv not found"
fi

# Summary
echo -e "\n${BLUE}=== Summary ===${NC}"
ok_count=0
failed_count=0

for server in "${!server_status[@]}"; do
    if [ "${server_status[$server]}" = "OK" ]; then
        ((ok_count++))
    else
        ((failed_count++))
    fi
done

total=$((ok_count + failed_count))
echo -e "Total servers: $total"
echo -e "${GREEN}Healthy: $ok_count${NC}"
echo -e "${RED}Failed: $failed_count${NC}"

log_message "Summary: $ok_count OK, $failed_count FAILED out of $total servers"

# Show failed servers
if [ $failed_count -gt 0 ]; then
    echo -e "\n${RED}Failed servers:${NC}"
    for server in "${!server_status[@]}"; do
        if [ "${server_status[$server]}" = "FAILED" ]; then
            echo "  - $server"
        fi
    done
fi

echo -e "\n${BLUE}Log file: $LOG_FILE${NC}"

# Exit with error code if any server failed
if [ $failed_count -gt 0 ]; then
    exit 1
else
    exit 0
fi
