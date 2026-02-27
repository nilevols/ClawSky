#!/bin/bash
# ClawSky-SoulRestore: Recovering the AI Soul
set -e

BACKUP_FILE=$1
WORKSPACE_DIR="./workspace"

if [ -z "$BACKUP_FILE" ]; then
  echo "❌ Error: Please specify a backup file (e.g., backups/soul_backup_2026.tar.gz)"
  exit 1
fi

if [ ! -f "$BACKUP_FILE" ]; then
  echo "❌ Error: File $BACKUP_FILE not found!"
  exit 1
fi

echo "[$(date)] 🛡️ Initiating soul restoration from $BACKUP_FILE..."

# 1. Automatic pre-restore backup (Safety first!)
./scripts/backup.sh > /dev/null

# 2. Extract and restore files
tar -xzf "$BACKUP_FILE" -C .
echo "✅ Restoration complete. Your AI soul has been successfully re-embodied."
