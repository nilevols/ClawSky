#!/bin/bash
# ClawSky-Setup: Interactive Configuration Engine
set -e

ENV_FILE="deploy/.env"
TEMPLATE="deploy/.env.example"

echo "🌌 ClawSky: Configuration Wizard"
echo "--------------------------------"

if [ ! -f "$TEMPLATE" ]; then
  echo "❌ Error: .env.example not found!"
  exit 1
fi

# 1. Basic Info
read -p "🌐 Enter your domain (e.g., claw.example.com): " DOMAIN
read -p "🔑 Enter a secure Gateway Token: " GW_TOKEN

# 2. LLM Keys
echo -e "\n--- LLM Provider Setup ---"
read -p "🤖 Enter Gemini API Key (Optional): " GEMINI_KEY
read -p "🧠 Enter OpenAI API Key (Optional): " OPENAI_KEY

# 3. Write to .env
echo "📝 Generating $ENV_FILE..."
cp "$TEMPLATE" "$ENV_FILE"

# Replace placeholders (Simple sed approach)
sed -i "s|your_secure_token_here|$GW_TOKEN|g" "$ENV_FILE"
sed -i "s|OPENAI_API_KEY=sk-.*|OPENAI_API_KEY=$OPENAI_KEY|g" "$ENV_FILE"
sed -i "s|GEMINI_API_KEY=.*|GEMINI_API_KEY=$GEMINI_KEY|g" "$ENV_FILE"

# Update Caddyfile with domain
sed -i "s|openclaw {|$DOMAIN {|g" deploy/Caddyfile 2>/dev/null || true

chmod 600 "$ENV_FILE"
echo "✅ Configuration successful! Run './clawsky up' to start."
