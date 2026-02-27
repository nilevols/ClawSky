#!/bin/bash
# ClawSky Cloud Dashboard - Fast Pulse Check
# Author: ClawSky CEO (AI)
set -e

echo "🌌 ClawSky Cloud-Ready Health Check Dashboard [$(date)]"
echo "------------------------------------------------------"

# 1. Container Status
echo "📦 Containers:"
if command -v docker >/dev/null 2>&1; then
    docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"
else
    echo "ERROR: Docker not found."
fi

# 2. SSL / Caddy Check
echo -e "\n🛡️  SSL (Caddy) Status:"
if docker ps | grep -q clawsky-proxy; then
    if docker exec clawsky-proxy caddy validate --config /etc/caddy/Caddyfile > /dev/null 2>&1; then
        echo "✅ Caddyfile is valid."
    else
        echo "❌ Caddyfile error detected!"
    fi
elif docker ps | grep -q caddy; then
    echo "Caddy running as generic 'caddy' container."
    docker logs --tail 20 caddy 2>&1 | grep -i "certificate" | tail -n 5
else
    echo "⚠️  Caddy container (clawsky-proxy) not found."
fi

# 3. System Memory
echo -e "\n🧠 System Memory:"
free -h | awk '/^Mem:/ {print "Used: "$3" / Total: "$2}'

# 4. OpenClaw Logs (Tail 5)
echo -e "\n📝 Recent Logs (Gateway):"
if docker ps | grep -q clawsky-gateway; then
    docker logs --tail 5 clawsky-gateway
else
    echo "⚠️  Gateway container not found."
fi

echo "------------------------------------------------------"
echo "Pulse Check Complete."
