#!/bin/bash
# ClawSky-EnvCheck: Pre-flight Safety Inspection
set -e

echo "🌌 ClawSky: Running pre-flight environment checks..."
echo "--------------------------------------------------"

# 1. Kernel User Namespace (for Sandbox)
if [ -f /proc/sys/kernel/unprivileged_userns_clone ]; then
  VAL=$(cat /proc/sys/kernel/unprivileged_userns_clone)
  if [ "$VAL" -eq 1 ]; then
    echo "✅ Kernel: User namespaces enabled (Safe for Browser)."
  else
    echo "⚠️  Kernel: User namespaces disabled. Browser sandbox may fail."
  fi
fi

# 2. Docker Storage Driver
DRIVER=$(docker info 2>/dev/null | grep "Storage Driver" | cut -d: -f2 | xargs)
if [ "$DRIVER" == "overlay2" ]; then
  echo "✅ Docker: Using overlay2 (Recommended)."
else
  echo "⚠️  Docker: Using $DRIVER. Performance may be degraded."
fi

# 3. Port Availability
for PORT in 80 443 18800; do
  if ss -tuln | grep -q ":$PORT "; then
    echo "🚨 Error: Port $PORT is already in use!"
  fi
done

echo "✨ Pre-flight check complete."
