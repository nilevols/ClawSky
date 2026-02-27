#!/bin/bash
# ClawSky-Init: The First Seed
set -e

echo "🌌 ClawSky: Initializing system..."
echo "--------------------------------"

# 1. Create essential directories
mkdir -p workspace logs backups

# 2. Setup .env with random token if not exists
if [ ! -f deploy/.env ]; then
  echo "📝 Creating secure .env..."
  RANDOM_TOKEN=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 32)
  cp deploy/.env.example deploy/.env
  sed -i "s|your_secure_token_here|$RANDOM_TOKEN|g" deploy/.env
  chmod 600 deploy/.env
  echo "✅ Secure token generated and .env created."
fi

# 3. Ensure script permissions
chmod +x scripts/*.sh clawsky 2>/dev/null || true

echo "✨ Initialization complete. Run './clawsky doctor' to check your environment."
