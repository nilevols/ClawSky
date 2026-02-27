#!/bin/bash
# ClawSky-Guardian: The Self-Healing Core
set -e

echo "[$(date)] 🛡️ Guardian active: Checking system health..."

# 1. Check if containers are running
if [[ $(docker ps -f name=clawsky-gateway -q) == "" ]]; then
  echo "⚠️  ClawSky-Gateway is down! Restarting..."
  docker-compose up -d openclaw
fi

# 2. Memory threshold check for browser
BROWSER_MEM=$(docker stats clawsky-browser --no-stream --format "{{.MemUsage}}" | cut -d' ' -f1 | sed 's/MiB//' | cut -d'.' -f1)
if [[ $BROWSER_MEM -gt 2000 ]]; then
  echo "🚨 Browser memory leak detected ($BROWSER_MEM MiB). Thermal reset initiated..."
  docker restart clawsky-browser
fi

# 3. Log rotation
find ./logs -name "*.log" -mtime +7 -exec rm -f {} \;
echo "✅ System stable. Pulse normal."
