# MCP Server Monitoring System

Complete monitoring and health check system for your Claude Code MCP servers.

## 📋 Overview

This monitoring system helps ensure your MCP servers remain connected and healthy. It includes:
- Automated health checks
- Daily summaries
- Troubleshooting tools
- Easy-to-use commands

## 🚀 Quick Start

### 1. Set Up Monitoring (One-time setup)

```bash
~/setup-mcp-monitoring.sh
```

This will:
- Add a cron job to check MCP servers every 5 minutes
- Create a daily summary report (runs at 11:59 PM)
- Add an `mcp-status` alias to your shell

### 2. Activate the Alias

```bash
source ~/.bashrc
```

## 📊 Available Commands

### Check Server Health
```bash
mcp-status
# or
~/mcp-health-check.sh
```

Shows the status of all 11 MCP servers:
- ✓ OK - Server is healthy
- ✗ FAILED - Server has issues

### View Daily Summary
```bash
~/mcp-daily-summary.sh
```

Shows:
- Total health checks for the day
- Success/failure counts
- List of failed servers

### Troubleshoot Issues
```bash
~/mcp-troubleshoot.sh
```

Diagnoses common issues:
- Missing dependencies
- Invalid API keys
- Network problems
- Python/Node.js environments

## 📁 File Locations

```
~/mcp-health-check.sh           # Main health check script
~/mcp-daily-summary.sh          # Daily summary generator
~/mcp-troubleshoot.sh           # Troubleshooting tool
~/setup-mcp-monitoring.sh       # Initial setup script
~/.claude/mcp-health.log        # Health check log file
~/.claude/mcp-cron.log          # Cron job output log
~/.claude/mcp-daily-summary-*.txt  # Daily summaries
```

## 🔧 Your MCP Servers

You have **11 MCP servers** configured:

1. **duckduckgo-search** - Web search capabilities
2. **sequential-thinking** - Advanced reasoning
3. **playwright** - Browser automation
4. **memory** - Persistent knowledge graph
5. **google-docs** - Google Docs integration
6. **google-sheets** - Google Sheets integration
7. **google-gmail** - Gmail integration
8. **google-calendar** - Google Calendar integration
9. **notion** - Notion workspace integration
10. **11labs** - ElevenLabs text-to-speech
11. **windows-mcp** - Windows automation

## 🔍 Monitoring Features

### Automatic Health Checks
- Runs every 5 minutes via cron
- Logs all results to `~/.claude/mcp-health.log`
- No manual intervention needed

### Daily Reports
- Generated automatically at 11:59 PM
- Summarizes the day's health checks
- Archives old logs to prevent bloat

### Real-time Status
- Run `mcp-status` anytime for instant health report
- Color-coded output (green = OK, red = failed)
- Detailed error messages for debugging

## 🐛 Troubleshooting

### If a Server Fails to Connect

1. **Run the health check:**
   ```bash
   mcp-status
   ```

2. **Run the troubleshooter:**
   ```bash
   ~/mcp-troubleshoot.sh
   ```

3. **Check the logs:**
   ```bash
   tail -f ~/.claude/mcp-health.log
   ```

### Common Issues & Fixes

#### ElevenLabs (11labs) Connection Issues
- **Check API key validity:** Visit https://elevenlabs.io/app/settings/api-keys
- **Verify Python environment:**
  ```bash
  /home/tayyabcheema777/.venv/bin/python3 --version
  ```
- **Test the server manually:**
  ```bash
  /home/tayyabcheema777/.venv/bin/python3 \
    /home/tayyabcheema777/.venv/lib/python3.12/site-packages/elevenlabs_mcp/server.py
  ```

#### Google Services Not Working
- **Re-authenticate:**
  ```bash
  rm ~/.local/state/google-docs-mcp/token.json
  # Restart Claude Code to trigger OAuth flow
  ```

#### Node.js Servers Failing
- **Check npx:**
  ```bash
  npx --version
  ```
- **Reinstall if needed:**
  ```bash
  sudo apt-get install npm
  ```

## 📈 Viewing Logs

### Real-time log monitoring:
```bash
tail -f ~/.claude/mcp-health.log
```

### Last 50 log entries:
```bash
tail -50 ~/.claude/mcp-health.log
```

### Search for specific server:
```bash
grep "11labs" ~/.claude/mcp-health.log
```

### View today's failures:
```bash
grep "FAILED" ~/.claude/mcp-health.log | grep "$(date +%Y-%m-%d)"
```

## ⚙️ Configuration

### Change Monitoring Frequency

Edit cron schedule:
```bash
crontab -e
```

Current: `*/5 * * * *` (every 5 minutes)
- Every 10 minutes: `*/10 * * * *`
- Every hour: `0 * * * *`
- Twice a day: `0 9,21 * * *`

### Disable Monitoring

Remove cron jobs:
```bash
crontab -l | grep -v "mcp-health-check\|mcp-daily-summary" | crontab -
```

### Re-enable Monitoring

Run setup again:
```bash
~/setup-mcp-monitoring.sh
```

## 🔐 Security Notes

- API keys are stored in `~/.claude.json` (restricted permissions)
- Logs may contain server paths but no sensitive data
- OAuth tokens stored separately in `.local/state/`

## 📚 Additional Resources

- Claude Code MCP Docs: https://docs.claude.com/en/docs/claude-code/mcp
- MCP Protocol: https://modelcontextprotocol.io/
- Your config: `~/.claude.json`

## 💡 Tips

1. **Run health check before starting important work:**
   ```bash
   mcp-status && claude
   ```

2. **Add to your shell startup:**
   ```bash
   echo "mcp-status" >> ~/.bashrc
   ```

3. **Get notified of failures:** Set up email alerts via cron
   ```bash
   # In crontab -e, change to:
   */5 * * * * ~/mcp-health-check.sh || echo "MCP servers down!" | mail -s "MCP Alert" your@email.com
   ```

4. **Monitor specific server:**
   ```bash
   mcp-status | grep "11labs"
   ```

## 🆘 Need Help?

If you continue experiencing connection issues:

1. Check this README
2. Run `~/mcp-troubleshoot.sh`
3. Review Claude Code docs
4. Check server-specific documentation

## 📝 Maintenance

The monitoring system is low-maintenance:
- Logs auto-rotate daily (keeps last 1000 entries)
- Daily summaries archived with date stamps
- No database or external dependencies

---

**Last Updated:** 2025-11-17
**Version:** 1.0
