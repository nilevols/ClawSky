#!/bin/bash
# ClawSky-HealthCheck: The Cloud Doctor
set -e

echo "🌌 ClawSky Health Report [$(date)]"
echo "--------------------------------------"

# 1. Disk Usage
DISK_FREE=$(df / | awk 'NR==2 {print $5}' | sed 's/%//')
if [ "$DISK_FREE" -gt 90 ]; then
  echo "🚨 CRITICAL: Disk usage is at ${DISK_FREE}%! Please clean up logs."
else
  echo "✅ Disk space: ${DISK_FREE}% used (Healthy)."
fi

# 2. Network Latency
echo -n "🌐 Network check: "
if ping -c 1 8.8.8.8 > /dev/null 2>&1; then
  LATENCY=$(ping -c 1 8.8.8.8 | awk -F'/' 'END{print $5}')
  echo "✅ Connected (Latency: ${LATENCY}ms)."
else
  echo "❌ Error: Public internet unreachable!"
fi

# 3. Docker Service
if systemctl is-active --quiet docker; then
  echo "✅ Docker service is running."
else
  echo "🚨 Error: Docker service is DOWN!"
fi

# 4. Memory Swap Check
SWAP_USED=$(free | awk '/Swap/ {print $3}')
if [ "$SWAP_USED" -gt 0 ]; then
  echo "⚠️  Warning: System is using Swap ($SWAP_USED KB). Memory might be tight."
fi

echo "✨ Diagnostics complete."
