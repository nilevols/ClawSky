#!/bin/bash
# ClawSky Cloud Dashboard - Fast Pulse Check
set -e

echo "🌌 ClawSky Dashboard [$(date)]"
echo "--------------------------------"

# 1. Container Status
echo "📦 Containers:"
docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"

# 2. SSL / Caddy Check
echo -e "\n🛡️  SSL (Caddy) Status:"
if docker exec clawsky-proxy caddy validate --config /etc/caddy/Caddyfile > /dev/null 2>&1; then
  echo "✅ Caddyfile is valid."
else
  echo "❌ Caddyfile error detected!"
fi

# 3. System Memory
echo -e "\n🧠 System Memory:"
free -h | awk '/^Mem:/ {print "Used: "$3" / Total: "$2}'

# 4. OpenClaw Logs (Tail 5)
echo -e "\n📝 Recent Logs (Gateway):"
docker logs --tail 5 clawsky-gateway
