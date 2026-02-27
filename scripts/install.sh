#!/bin/bash
# ClawSky - One-Click Cloud Deployment Script
set -e

echo "🌌 ClawSky: Starting cloud deployment..."

# Check for Docker
if ! [ -x "$(command -v docker)" ]; then
  echo "📦 Docker not found. Installing Docker..."
  curl -fsSL https://get.docker.com -o get-docker.sh
  sh get-docker.sh
  rm get-docker.sh
fi

# Clone or Update Repo
if [ -d "ClawSky" ]; then
  echo "📂 Updating existing ClawSky..."
  cd ClawSky && git pull
else
  echo "🚀 Cloning ClawSky repository..."
  git clone https://github.com/nilevols/ClawSky.git
  cd ClawSky
fi

# Setup ENV
if [ ! -f "deploy/.env" ]; then
  echo "📝 Creating .env from template..."
  cp deploy/.env.example deploy/.env
  echo "⚠️  ACTION REQUIRED: Please edit deploy/.env with your keys!"
fi

echo "✅ ClawSky setup complete! Run 'docker-compose up -d' to start."
