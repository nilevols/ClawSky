#!/bin/bash
# ClawSky-RemoteShell: Direct Container Access
set -e

CONTAINER="clawsky-gateway"

if [ "$1" == "browser" ]; then
  CONTAINER="clawsky-browser"
fi

echo "🌌 ClawSky: Entering $CONTAINER..."
docker exec -it "$CONTAINER" /bin/bash || docker exec -it "$CONTAINER" /bin/sh
