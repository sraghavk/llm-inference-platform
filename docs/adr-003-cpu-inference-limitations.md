# ADR 003: CPU Inference Performance Limitations

## Status
Accepted

## Context
Running LLM inference on CPU in local development environment.

## Observation
- phi-2 (3B parameters) takes 1-3 minutes per response on CPU
- Acceptable for development and testing
- Not acceptable for production use

## Solution for Production
- Use GPU node pools on GKE (NVIDIA T4 or A100)
- Switch from Ollama to vLLM for better throughput
- Expected improvement: 10-50x faster inference on GPU

## Current Status
CPU inference is sufficient for:
- Proving the GitOps pipeline works
- Testing observability stack
- Portfolio demonstration purposes
