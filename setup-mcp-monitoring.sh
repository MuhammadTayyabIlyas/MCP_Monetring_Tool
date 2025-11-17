#!/bin/bash

# Setup MCP Monitoring
# This script sets up automatic health checks for MCP servers

echo "Setting up MCP Server Monitoring..."

# 1. Create cron job for health checks (every 5 minutes)
CRON_JOB="*/5 * * * * /home/tayyabcheema777/mcp-health-check.sh >> /home/tayyabcheema777/.claude/mcp-cron.log 2>&1"

# Check if cron job already exists
if crontab -l 2>/dev/null | grep -q "mcp-health-check.sh"; then
    echo "Cron job already exists. Skipping..."
else
    # Add cron job
    (crontab -l 2>/dev/null; echo "$CRON_JOB") | crontab -
    echo "✓ Cron job added (runs every 5 minutes)"
fi

# 2. Create daily summary script
cat > /home/tayyabcheema777/mcp-daily-summary.sh << 'EOF'
#!/bin/bash

LOG_FILE="$HOME/.claude/mcp-health.log"
SUMMARY_FILE="$HOME/.claude/mcp-daily-summary-$(date +%Y-%m-%d).txt"

echo "MCP Server Health Summary - $(date)" > "$SUMMARY_FILE"
echo "======================================" >> "$SUMMARY_FILE"
echo "" >> "$SUMMARY_FILE"

# Count OK and FAILED entries
ok_count=$(grep -c "OK" "$LOG_FILE" 2>/dev/null || echo "0")
failed_count=$(grep -c "FAILED" "$LOG_FILE" 2>/dev/null || echo "0")

echo "Total health checks today:" >> "$SUMMARY_FILE"
echo "  OK: $ok_count" >> "$SUMMARY_FILE"
echo "  FAILED: $failed_count" >> "$SUMMARY_FILE"
echo "" >> "$SUMMARY_FILE"

# Show which servers failed
echo "Failed servers:" >> "$SUMMARY_FILE"
grep "FAILED" "$LOG_FILE" 2>/dev/null | tail -20 >> "$SUMMARY_FILE"

# Show summary
cat "$SUMMARY_FILE"

# Optional: Clear old log (keep last 1000 lines)
tail -1000 "$LOG_FILE" > "$LOG_FILE.tmp" && mv "$LOG_FILE.tmp" "$LOG_FILE"
EOF

chmod +x /home/tayyabcheema777/mcp-daily-summary.sh

# 3. Add daily summary cron job (runs at 11:59 PM)
DAILY_CRON="59 23 * * * /home/tayyabcheema777/mcp-daily-summary.sh"
if crontab -l 2>/dev/null | grep -q "mcp-daily-summary.sh"; then
    echo "Daily summary cron job already exists. Skipping..."
else
    (crontab -l 2>/dev/null; echo "$DAILY_CRON") | crontab -
    echo "✓ Daily summary cron job added (runs at 11:59 PM)"
fi

# 4. Create a quick check alias
ALIAS_LINE="alias mcp-status='/home/tayyabcheema777/mcp-health-check.sh'"

# Add to .bashrc if not already there
if ! grep -q "mcp-status" ~/.bashrc 2>/dev/null; then
    echo "" >> ~/.bashrc
    echo "# MCP Health Check Alias" >> ~/.bashrc
    echo "$ALIAS_LINE" >> ~/.bashrc
    echo "✓ Added 'mcp-status' alias to .bashrc"
    echo "  Run 'source ~/.bashrc' to activate it"
else
    echo "'mcp-status' alias already exists in .bashrc"
fi

echo ""
echo "=== Setup Complete ==="
echo ""
echo "Available commands:"
echo "  mcp-status                 - Run health check manually"
echo "  ~/mcp-health-check.sh      - Run health check (full path)"
echo "  ~/mcp-daily-summary.sh     - View daily summary"
echo ""
echo "Monitoring features:"
echo "  • Health checks run every 5 minutes (via cron)"
echo "  • Daily summary generated at 11:59 PM"
echo "  • Logs stored in ~/.claude/mcp-health.log"
echo ""
echo "To view logs:"
echo "  tail -f ~/.claude/mcp-health.log"
echo ""
