#!/bin/bash
# ClawSky-ResourceLimiter: CPU & Memory Protection
set -e

echo "🌌 ClawSky: Applying resource limits..."

# 1. Limit Browser (Chromium) to prevent CPU hogging
# --cpu-shares 512 gives it half the default weight
docker update --cpu-shares 512 --memory 2g clawsky-browser

# 2. Ensure Gateway has enough overhead
docker update --cpu-shares 1024 --memory 1g clawsky-gateway

echo "✅ Resource quotas updated. System will remain responsive during heavy tasks."
