#!/bin/bash
# ClawSky-LogsMonitor: The Alerting Engine
set -e

LOG_FILE="./logs/gateway.log"
STATE_FILE="./logs/.monitor_state"

if [ ! -f "$LOG_FILE" ]; then
  echo "📝 No logs found yet. Waiting for system start..."
  exit 0
fi

LAST_LINE=$(cat "$STATE_FILE" 2>/dev/null || echo "0")
CURRENT_LINES=$(wc -l < "$LOG_FILE")

if [ "$CURRENT_LINES" -gt "$LAST_LINE" ]; then
  # Scan new lines for critical errors
  ERRORS=$(sed -n "$((LAST_LINE + 1)),${CURRENT_LINES}p" "$LOG_FILE" | grep -Ei "ERROR|CRASH|FATAL" || true)
  
  if [ -n "$ERRORS" ]; then
    echo "🚨 ALERT: Critical issues detected in logs!"
    echo "$ERRORS"
    # Placeholder for notification hook (Telegram/Discord)
  fi
  
  echo "$CURRENT_LINES" > "$STATE_FILE"
fi
