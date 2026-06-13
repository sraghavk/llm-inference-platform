#!/bin/bash
echo "Starting LLM Inference Platform..."

# Start docker containers (kind cluster)
docker start $(docker ps -aq) 2>/dev/null
echo "Waiting for cluster to be ready..."
sleep 30

# Wait for nodes
kubectl wait --for=condition=ready node --all --timeout=60s

# Force delete any Unknown/Error pods from previous session
echo "Cleaning up stale pods..."
kubectl get pods -A 2>/dev/null | grep -E "Unknown|Error|CreateContainerConfigError" | \
  awk '{print "kubectl delete pod " $2 " -n " $1 " --force --grace-period=0"}' | bash 2>/dev/null

echo "Waiting for pods to reschedule (this takes 2-3 mins)..."
sleep 90

# Kill any existing port-forwards
pkill -f "port-forward" 2>/dev/null
sleep 2

# Start all port-forwards
kubectl port-forward svc/argocd-server -n argocd 8080:443 &
kubectl port-forward svc/ollama-service -n llm-inference 11434:11434 &
kubectl port-forward svc/monitoring-grafana -n monitoring 3000:80 &
kubectl port-forward svc/monitoring-kube-prometheus-prometheus -n monitoring 9090:9090 &

sleep 5

echo ""
echo "========================================"
echo "        LLM Inference Platform"
echo "========================================"
echo ""
echo "Services:"
echo "  Argo CD:    https://localhost:8080"
echo "  Ollama:     http://localhost:11434"
echo "  Grafana:    http://localhost:3000"
echo "  Prometheus: http://localhost:9090"
echo ""
echo "Argo CD password:"
kubectl -n argocd get secret argocd-initial-admin-secret \
  -o jsonpath="{.data.password}" | base64 -d && echo
echo ""
echo "Grafana password:"
kubectl --namespace monitoring get secret monitoring-grafana \
  -o jsonpath="{.data.admin-password}" | base64 -d && echo
echo ""
echo "========================================"
echo "Pod health check:"
echo "========================================"
kubectl get pods -A | grep -v kube-system
echo ""
echo "Memory:"
free -h | grep Mem
echo "========================================"
