#!/bin/bash
echo "Stopping LLM Inference Platform..."

# Kill all port-forwards
pkill -f "port-forward" 2>/dev/null
echo "Port-forwards stopped"

# Stop all docker containers (kind cluster)
docker stop $(docker ps -q) 2>/dev/null
echo "Cluster stopped"

echo ""
echo "All stopped. Your laptop is free."
echo ""
echo "Memory available:"
free -h | grep Mem
