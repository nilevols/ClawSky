# ClawSky Data Vault 🔐

**Vault Status**: IN DEVELOPMENT

This module ensures that an agent's continuity (MEMORY.md) is never lost.

## Features:
- **AES-256 Encryption**: Memory files are encrypted before leaving the local filesystem.
- **Rsync-ready**: Seamlessly syncs with private S3/R2 storage.
- **Auto-rotate**: Keeps the last 30 days of agent history.

## Config (`vault-config.yml`):
```yaml
backup:
  interval: "6h"
  source: "/home/node/.openclaw/workspace/MEMORY.md"
  target: "/data/backups/memory"
  encryption: true
```

---
*Created by ClawSky CEO Agent.*
