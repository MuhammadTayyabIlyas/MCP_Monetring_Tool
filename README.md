<div align="center">

# 🔍 MCP Server Monitoring System

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Bash](https://img.shields.io/badge/Bash-5.0+-brightgreen.svg)](https://www.gnu.org/software/bash/)
[![Platform](https://img.shields.io/badge/Platform-Linux%20%7C%20macOS%20%7C%20WSL-blue.svg)](https://github.com/MuhammadTayyabIlyas/MCP_Monetring_Tool)

**Complete monitoring and health check system for MCP servers**

[Features](#-features) • [Quick Start](#-quick-start) • [Installation](#-installation) • [Usage](#-usage) • [Documentation](#-documentation)

</div>

---

## 📋 Overview

A comprehensive monitoring solution that ensures your **Model Context Protocol (MCP) servers** remain healthy and connected. Built for developers using MCP integrations.

### 🎯 What This Does

- ✅ **Automated Health Checks** - Monitor all MCP servers every 5 minutes
- 📊 **Daily Reports** - Automated summaries of server health
- 🔧 **Troubleshooting Tools** - Built-in diagnostics for common issues
- 🎨 **Color-Coded Output** - Easy-to-read status indicators
- 📝 **Comprehensive Logging** - Track issues over time
- ⚡ **Zero Configuration** - Works out of the box

---

## 🚀 Quick Start

### Installation (One Command)

```bash
git clone https://github.com/MuhammadTayyabIlyas/MCP_Monetring_Tool.git
cd MCP_Monetring_Tool
./setup-mcp-monitoring.sh
source ~/.bashrc
```

### Check Server Status

```bash
mcp-status
```

**That's it!** 🎉 Your MCP servers are now monitored automatically.

---

## ✨ Features

<table>
<tr>
<td width="50%">

### 🔄 Automated Monitoring
- Cron-based health checks every 5 minutes
- Silent background operation
- Automatic log rotation
- No manual intervention required

</td>
<td width="50%">

### 📈 Detailed Reporting
- Real-time status dashboard
- Daily summary reports (11:59 PM)
- Historical trend analysis
- Failed server notifications

</td>
</tr>
<tr>
<td width="50%">

### 🛠️ Troubleshooting
- Dependency validation
- API key verification
- Network connectivity checks
- Python/Node.js environment checks

</td>
<td width="50%">

### 🎨 User-Friendly
- Color-coded status output
- Easy-to-read summaries
- Quick access aliases
- Comprehensive documentation

</td>
</tr>
</table>

---

## 📦 What's Included

```
MCP_Monetring_Tool/
├── mcp-health-check.sh      # Main health monitoring script
├── mcp-troubleshoot.sh       # Diagnostic and troubleshooting tool
├── setup-mcp-monitoring.sh   # Automated installation & setup
├── README.md                 # This file
└── .gitignore                # Git ignore patterns
```

---

## 🔧 Supported MCP Servers

This tool monitors the following MCP server types:

| Server | Purpose | Status Check |
|--------|---------|--------------|
| 🦆 **DuckDuckGo Search** | Web search capabilities | `uvx` availability |
| 🧠 **Sequential Thinking** | Advanced reasoning | `npx` availability |
| 🎭 **Playwright** | Browser automation | Binary existence |
| 💾 **Memory** | Knowledge graph persistence | `npx` availability |
| 📄 **Google Docs** | Document integration | Binary + OAuth |
| 📊 **Google Sheets** | Spreadsheet integration | Python + OAuth |
| 📧 **Google Gmail** | Email integration | Python + OAuth |
| 📅 **Google Calendar** | Calendar integration | Python + OAuth |
| 📝 **Notion** | Workspace integration | Node.js + Token |
| 🎙️ **ElevenLabs** | Text-to-speech | Python + API key |
| 🪟 **Windows MCP** | Windows automation | Python venv |

---

## 📊 Usage

### Basic Commands

#### Check Server Health
```bash
mcp-status
```

**Example Output:**
```
=== MCP Server Health Check ===
Time: 2025-11-17 21:32:25

Checking MCP Servers:

  duckduckgo-search: ✓ OK
  sequential-thinking: ✓ OK
  playwright: ✓ OK
  memory: ✓ OK
  google-docs: ✓ OK
  ...

=== Summary ===
Total servers: 11
Healthy: 11
Failed: 0
```

#### View Daily Summary
```bash
~/mcp-daily-summary.sh
```

#### Troubleshoot Issues
```bash
~/mcp-troubleshoot.sh
```

### Advanced Usage

#### Monitor Specific Server
```bash
mcp-status | grep "google-docs"
```

#### Real-time Log Monitoring
```bash
tail -f ~/.claude/mcp-health.log
```

#### View Today's Failures
```bash
grep "FAILED" ~/.claude/mcp-health.log | grep "$(date +%Y-%m-%d)"
```

#### Run Before Important Work
```bash
mcp-status && your-command
```

---

## ⚙️ Configuration

### File Locations

| File | Purpose | Location |
|------|---------|----------|
| Health Check Script | Main monitoring script | `~/mcp-health-check.sh` |
| Setup Script | Installation automation | `~/setup-mcp-monitoring.sh` |
| Troubleshoot Script | Diagnostic tool | `~/mcp-troubleshoot.sh` |
| Health Log | Monitoring logs | `~/.claude/mcp-health.log` |
| Cron Log | Cron job output | `~/.claude/mcp-cron.log` |
| Daily Summaries | Daily reports | `~/.claude/mcp-daily-summary-*.txt` |

### Customize Monitoring Frequency

Edit your crontab:
```bash
crontab -e
```

**Frequency Options:**
- Every 5 minutes (default): `*/5 * * * *`
- Every 10 minutes: `*/10 * * * *`
- Every hour: `0 * * * *`
- Twice daily (9 AM & 9 PM): `0 9,21 * * *`

### Disable/Enable Monitoring

**Disable:**
```bash
crontab -l | grep -v "mcp-health-check\|mcp-daily-summary" | crontab -
```

**Re-enable:**
```bash
./setup-mcp-monitoring.sh
```

---

## 🐛 Troubleshooting

<details>
<summary><b>Server Shows as FAILED</b></summary>

1. Run the troubleshooter:
   ```bash
   ~/mcp-troubleshoot.sh
   ```

2. Check the specific error:
   ```bash
   mcp-status
   ```

3. Review logs:
   ```bash
   tail -50 ~/.claude/mcp-health.log
   ```
</details>

<details>
<summary><b>ElevenLabs Connection Issues</b></summary>

- Verify API key: https://elevenlabs.io/app/settings/api-keys
- Test Python environment:
  ```bash
  ~/.venv/bin/python3 --version
  ```
- Check server manually:
  ```bash
  ~/.venv/bin/python3 ~/.venv/lib/python3.12/site-packages/elevenlabs_mcp/server.py
  ```
</details>

<details>
<summary><b>Google Services Not Working</b></summary>

Re-authenticate:
```bash
rm ~/.local/state/google-docs-mcp/token.json
# Restart Claude Code to trigger OAuth flow
```
</details>

<details>
<summary><b>Node.js Servers Failing</b></summary>

Check npx and reinstall if needed:
```bash
npx --version
sudo apt-get install npm  # if needed
```
</details>

---

## 📚 Documentation

### How It Works

1. **Cron Job** runs `mcp-health-check.sh` every 5 minutes
2. **Script checks** each MCP server's availability and dependencies
3. **Results logged** to `~/.claude/mcp-health.log`
4. **Daily summary** generated at 11:59 PM with statistics
5. **Logs auto-rotate** to prevent disk bloat

### Architecture

```
┌─────────────────┐
│  Cron Scheduler │
└────────┬────────┘
         │ (every 5 min)
         ▼
┌─────────────────────┐
│ mcp-health-check.sh │
└────────┬────────────┘
         │
         ├──► Check Dependencies (Python, Node, uvx)
         ├──► Verify Binaries (Playwright, Google Docs)
         ├──► Validate API Keys (ElevenLabs, Notion)
         ├──► Test OAuth Tokens (Google Services)
         │
         ▼
┌─────────────────┐
│  Log Results    │
└────────┬────────┘
         │
         ▼
┌─────────────────┐      ┌──────────────────┐
│ Real-time View  │      │  Daily Summary   │
│  (mcp-status)   │      │   (11:59 PM)     │
└─────────────────┘      └──────────────────┘
```

---

## 💡 Pro Tips

### 1. Add to Shell Startup
```bash
echo "mcp-status" >> ~/.bashrc
```
Now you'll see server status every time you open a terminal!

### 2. Email Alerts on Failure
```bash
# In crontab -e, modify the cron job:
*/5 * * * * ~/mcp-health-check.sh || echo "MCP servers down!" | mail -s "MCP Alert" your@email.com
```

### 3. Quick Server Check
```bash
# Add to your .bashrc for instant checking
alias mcp='~/mcp-health-check.sh'
```

### 4. Monitor Before Coding
```bash
mcp-status && code .
# or
mcp-status && claude
```

---

## 🔐 Security & Privacy

- ✅ API keys stored in `~/.claude.json` with restricted permissions
- ✅ No sensitive data in logs (only paths and status)
- ✅ OAuth tokens stored separately in `.local/state/`
- ✅ All scripts run locally (no external calls)
- ✅ Open source - audit the code yourself

---

## 🤝 Contributing

Contributions are welcome! Here's how you can help:

1. 🐛 **Report Bugs** - Open an issue
2. 💡 **Suggest Features** - Share your ideas
3. 🔧 **Submit PRs** - Improve the code
4. 📖 **Improve Docs** - Help others understand

---

## 📝 License

This project is licensed under the MIT License - see below for details:

```
MIT License

Copyright (c) 2025 Muhammad Tayyab Ilyas

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

---

## 🌟 Support

If you find this tool helpful:

- ⭐ Star this repository
- 🐛 Report issues
- 📢 Share with others
- 💬 Provide feedback

---

## 📞 Contact

**Muhammad Tayyab Ilyas**
- GitHub: [@MuhammadTayyabIlyas](https://github.com/MuhammadTayyabIlyas)
- Email: tayyabcheema777@gmail.com

---

## 🙏 Acknowledgments

- PAKEDX Team for MCP monitoring development
- Model Context Protocol contributors
- Open source community

---

<div align="center">

**Made with ❤️ by PAKEDX**

[⬆ Back to Top](#-mcp-server-monitoring-system)

</div>
