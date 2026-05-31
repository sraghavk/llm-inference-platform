# ADR 001: Use Ollama before vLLM

## Status
Accepted

## Context
Building an LLM inference platform on Kubernetes.
Two main options: Ollama and vLLM.

## Decision
Start with Ollama on CPU, migrate to vLLM on GPU later.

## Reasons
- Ollama runs on CPU — no GPU needed for development
- Simpler deployment — single container, no model conversion
- Faster iteration — pull any model with one command
- vLLM requires GPU nodes which cost money on GCP

## Tradeoffs
- Ollama is slower than vLLM for inference
- vLLM has better throughput and batching for production
- Deliberate dev vs prod tradeoff

## Migration plan
Switch to vLLM when GKE cluster with GPU nodes is available.
vLLM manifests will be added in kubernetes/vllm/ folder.
