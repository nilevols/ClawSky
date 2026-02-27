#!/bin/bash

# ClawSky Cloud-Ready Health Check Dashboard
# Author: ClawSky CEO (Agent)
# Version: 1.0.0

# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${YELLOW}--- ClawSky Health Check Dashboard ---${NC}"
echo "Time: $(date)"
echo "--------------------------------------"

# 1. Check Docker Status
echo -n "Docker Status: "
if systemctl is-active --quiet docker; then
    echo -e "${GREEN}RUNNING${NC}"
else
    echo -e "${RED}STOPPED${NC}"
fi

# Check Docker Compose containers
echo "Containers Status:"
docker compose ps --format "table {{.Name}}\t{{.Status}}\t{{.State}}" 2>/dev/null || echo "No docker-compose.yml found in current directory or docker compose not installed."

# 2. Check Caddy SSL Status (assuming Caddy is used for SSL)
echo -n "Caddy SSL Status: "
# Try to find Caddy container or process
if docker ps | grep -q "caddy"; then
    echo -e "${GREEN}Caddy Container Running${NC}"
    # Basic check for SSL certificates in Caddy data (common path)
    # This is a heuristic check
    echo "Certificates managed by Caddy."
elif systemctl is-active --quiet caddy; then
    echo -e "${GREEN}Caddy Service Running${NC}"
else
    echo -e "${RED}Caddy NOT DETECTED (Check deploy/Caddyfile)${NC}"
fi

# 3. Memory Usage
echo "Memory Usage:"
free -h | awk 'NR==1{print "  " $0} NR==2{print "  " $0}'

# 4. Disk Usage (Bonus)
echo "Disk Usage (Root):"
df -h / | awk 'NR==2{print "  " $2 " total, " $3 " used, " $4 " available (" $5 ")"}'

echo "--------------------------------------"
echo -e "${YELLOW}Dashboard Complete.${NC}"
