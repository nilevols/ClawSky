#!/bin/bash
# ClawSky Cloud-Ready Health Check Dashboard
# Author: ClawSky CEO (OpenClaw)

echo "--- ClawSky Health Dashboard ---"
date
echo "-------------------------------"

# 1. Docker Status
echo "[1/3] Checking Docker Containers..."
if command -v docker >/dev/null 2>&1; then
    docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"
else
    echo "Error: Docker not installed."
fi
echo ""

# 2. Caddy SSL Status
echo "[2/3] Checking Caddy SSL/Certs..."
if command -v caddy >/dev/null 2>&1; then
    # Check if caddy is running and try to get some admin stats if possible, 
    # otherwise check systemd status or process.
    if pgrep caddy >/dev/null; then
        echo "Caddy is running."
        # Attempt to list certificates if the admin API is available
        curl -s http://localhost:2019/pki/ca/local 2>/dev/null | jq '.' || echo "Caddy Admin API not reachable or JQ not installed."
    else
        echo "Caddy process not found."
    fi
else
    echo "Error: Caddy not found in PATH."
fi
echo ""

# 3. Memory Usage
echo "[3/3] System Memory Usage..."
free -h | grep -E "total|Mem"
echo ""

echo "-------------------------------"
echo "Dashboard Check Complete."
