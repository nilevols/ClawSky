#!/bin/bash
# ClawSky-SecurityAudit: Protecting the Cloud Perimeter
set -e

echo "🛡️ ClawSky Security Audit [$(date)]"
echo "--------------------------------------"

# 1. Check for exposed sensitive ports
EXPOSED_PORTS=$(ss -tuln | grep -E "18800|9222|2375" || true)

if [ -n "$EXPOSED_PORTS" ]; then
  echo "🚨 WARNING: Sensitive ports detected!"
  echo "$EXPOSED_PORTS"
  echo "💡 ADVICE: Use Caddy reverse proxy and firewall (UFW) to restrict access."
else
  echo "✅ No obvious sensitive ports exposed to public."
fi

# 2. Check .env file permissions
ENV_PERM=$(stat -c "%a" deploy/.env 2>/dev/null || echo "0")
if [ "$ENV_PERM" != "600" ] && [ "$ENV_PERM" != "0" ]; then
  echo "⚠️  UNSAFE: deploy/.env permissions are $ENV_PERM. Recommended: 600"
  chmod 600 deploy/.env && echo "✅ Auto-fixed to 600."
fi

echo "✨ Audit complete."
