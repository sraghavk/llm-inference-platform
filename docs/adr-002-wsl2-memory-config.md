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
