#!/bin/bash
# ClawSky-SelfUpdate: The Evolution Protocol
set -e

echo "[$(date)] 🔄 Checking for ClawSky infrastructure updates..."

cd "$(dirname "$0")/.."

# Fetch latest changes
git fetch origin main

LOCAL=$(git rev-parse HEAD)
REMOTE=$(git rev-parse origin/main)

if [ "$LOCAL" != "$REMOTE" ]; then
  echo "🚀 New version detected! Pulling updates..."
  git pull origin main
  
  # Check if docker-compose changed
  if git diff --name-only "$LOCAL" "$REMOTE" | grep -q "docker-compose.yml"; then
    echo "📦 docker-compose changed. Restarting stack..."
    docker-compose up -d
  fi
  echo "✅ Update complete."
else
  echo "✨ Already up to date."
fi
