#!/bin/bash
# ClawSky-Notify: The Real-time Alerting Bridge
set -e

# Load ENV
source "$(dirname "$0")/../deploy/.env" 2>/dev/null || true

MESSAGE=$1
if [ -z "$MESSAGE" ]; then
  echo "❌ Error: No message provided."
  exit 1
fi

echo "[$(date)] 📢 Notification: $MESSAGE"

if [ -n "$TELEGRAM_BOT_TOKEN" ] && [ -n "$TELEGRAM_CHAT_ID" ]; then
  curl -s -X POST "https://api.telegram.org/bot$TELEGRAM_BOT_TOKEN/sendMessage" \
    -d chat_id="$TELEGRAM_CHAT_ID" \
    -d text="🌌 *ClawSky Alert*:%0A$MESSAGE" \
    -d parse_mode="Markdown" > /dev/null
  echo "✅ Pushed to Telegram."
else
  echo "⚠️  Skip: Telegram credentials not set in .env"
fi
