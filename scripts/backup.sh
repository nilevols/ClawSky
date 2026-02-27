#!/bin/bash
# ClawSky-Backup: Protecting the Soul of AI
set -e

BACKUP_DIR="./backups"
WORKSPACE_DIR="./workspace"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)

mkdir -p "$BACKUP_DIR"

echo "[$(date)] 🛡️ Starting soul backup..."

# 1. Archive core identity and memory files
tar -czf "$BACKUP_DIR/soul_backup_$TIMESTAMP.tar.gz" \
    "$WORKSPACE_DIR/SOUL.md" \
    "$WORKSPACE_DIR/MEMORY.md" \
    "$WORKSPACE_DIR/IDENTITY.md" 2>/dev/null || true

# 2. Cleanup old backups (keep last 7 days)
find "$BACKUP_DIR" -name "*.tar.gz" -mtime +7 -exec rm -f {} \;

echo "✅ Backup completed: soul_backup_$TIMESTAMP.tar.gz"
