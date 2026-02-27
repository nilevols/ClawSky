#!/bin/bash

# ClawSky Cloud-Ready Health Check Dashboard
# CEO nilevols' Visionary Pulse

echo "=========================================="
echo "   ClawSky Cloud-Ready Health Dashboard   "
echo "=========================================="
date
echo "=========================================="

# 1. Docker Status
echo "[DOCKER STATUS]"
if command -v docker >/dev/null 2>&1; then
    docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"
else
    echo "❌ Docker is not installed or not in PATH."
fi
echo ""

# 2. Caddy SSL Status (if running via docker or local)
echo "[CADDY SSL STATUS]"
if docker ps | grep -q caddy; then
    echo "✅ Caddy container is running."
    # Attempt to list managed certificates if caddy is accessible via API or logs
    # For now, we check if port 443 is listening
    if netstat -tuln | grep -q :443; then
        echo "✅ Port 443 (HTTPS) is listening."
    else
        echo "⚠️ Port 443 is NOT listening."
    fi
else
    echo "ℹ️ Caddy container not detected. Checking local caddy..."
    if command -v caddy >/dev/null 2>&1; then
        caddy list-certs 2>/dev/null || echo "ℹ️ Local caddy found, but couldn't list certs."
    else
        echo "❌ Caddy not found."
    fi
fi
echo ""

# 3. Memory Usage
echo "[MEMORY USAGE]"
free -h | awk '/^Mem:/ {print "Total: " $2 "\tUsed: " $3 "\tFree: " $4}'
echo ""

# 4. Disk Usage
echo "[DISK USAGE]"
df -h / | awk 'NR==2 {print "Total: " $2 "\tUsed: " $3 "\tAvailable: " $4 "\tUsage: " $5}'

echo "=========================================="
echo "Pulse Check Complete."
