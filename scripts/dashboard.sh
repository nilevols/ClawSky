#!/bin/bash

# ClawSky Cloud-Ready Health Check Dashboard
# CEO Vision: Real-time observability for the decentralized sky.

echo "=========================================="
echo "   ☁️  CLAWSKY HEALTH CHECK DASHBOARD  ☁️   "
echo "=========================================="
echo "Timestamp: $(date)"
echo "------------------------------------------"

# 1. Docker Status
echo "🐳 [DOCKER STATUS]"
if command -v docker >/dev/null 2>&1; then
    docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"
else
    echo "❌ Docker is not installed or not in PATH."
fi
echo "------------------------------------------"

# 2. Caddy SSL Status (Checks for Caddy process and listening ports)
echo "🔒 [CADDY / SSL STATUS]"
if pgrep -x "caddy" >/dev/null; then
    echo "✅ Caddy process is running."
    # Check if ports 80/443 are listening
    if netstat -tuln | grep -E ':80|:443' >/dev/null; then
        echo "✅ Ports 80/443 are active (SSL/HTTP ready)."
    else
        echo "⚠️ Caddy is running but ports 80/443 are not listening."
    fi
else
    echo "❌ Caddy process not found."
fi
echo "------------------------------------------"

# 3. Memory Usage
echo "🧠 [MEMORY USAGE]"
free -h | awk '/^Mem:/ {print "Total: " $2 " | Used: " $3 " | Free: " $4}'
echo "------------------------------------------"

echo "✨ System check complete. Keep climbing. ✨"
echo "=========================================="
