# Ollama Verification

## Status: Working ✅

## Test performed
Date: 2026-05-31
Environment: kind cluster (local, WSL2)
Model: phi
Deployment: via Argo CD GitOps pipeline

## Test command
```bash
curl http://localhost:11434/api/generate \
  -H "Content-Type: application/json" \
  -d '{
    "model": "phi",
    "prompt": "Explain Kubernetes in one sentence.",
    "stream": false
  }'
```

## Response
Model answered correctly:
"Kubernetes is an open-source platform for managing containerized 
applications by automatically provisioning, scaling, and monitoring 
their instances, as well as providing tools for network isolation 
and load balancing."

## Pipeline
GitHub → Argo CD → Kubernetes (kind) → Ollama → LLM response
