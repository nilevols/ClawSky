#!/bin/bash
# ClawSky-Cleanup: Reclaiming Disk Space
set -e

echo "🌌 ClawSky: Initiating system cleanup..."
echo "--------------------------------------"

# 1. Remove dangling Docker images
echo "🧹 Removing unused Docker images..."
docker image prune -f

# 2. Cleanup Docker volumes (unused only)
echo "🧹 Removing unused Docker volumes..."
docker volume prune -f

# 3. Clear temporary system cache
echo "🧹 Clearing temporary system files..."
rm -rf /tmp/clawsky_* 2>/dev/null || true

echo "✨ Cleanup complete. Disk space reclaimed."
