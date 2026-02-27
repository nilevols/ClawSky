#!/bin/bash
# ClawSky-CloudSync: Offsite Disaster Recovery
set -e

BACKUP_DIR="./backups"
RCLONE_CONFIG="$HOME/.config/rclone/rclone.conf"
REMOTE_NAME="clawsky-remote"

echo "[$(date)] ☁️ Initiating cloud synchronization..."

if [ ! -f "$RCLONE_CONFIG" ]; then
  echo "⚠️  Rclone not configured. Please run 'rclone config' first."
  exit 1
fi

# Sync backups to remote
if command -v rclone >/dev/null 2>&1; then
  rclone sync "$BACKUP_DIR" "$REMOTE_NAME:ClawSky_Backups" --progress
  echo "✅ Cloud sync complete. Your AI soul is now geo-replicated."
else
  echo "❌ Error: rclone not installed. Run 'sudo apt install rclone' first."
fi
