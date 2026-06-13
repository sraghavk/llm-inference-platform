# ADR 002: WSL2 Memory Configuration for Local Development

## Status
Accepted

## Problem
Ollama pod stuck in ContainerCreating due to WSL2 default memory limit of 3.8GB.

## Solution
Created .wslconfig with 6GB memory allocation.

## Config
[wsl2]
memory=6GB
processors=4
swap=2GB

## Result
Pod started successfully, LLM serving requests on CPU.

## Additional note: applicationset-controller CrashLoopBackOff

After cluster restarts via docker stop/start, argocd-applicationset-controller
repeatedly enters CrashLoopBackOff with "failed to wait for applicationset
caches to sync" error.

Fix: reapply Argo CD manifests + rollout restart the deployment:
```bash
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
kubectl rollout restart deployment argocd-applicationset-controller -n argocd
```

This is a recurring issue specific to kind cluster restarts — CRDs
sometimes aren't fully ready when the controller starts.
