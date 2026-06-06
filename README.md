# LLM Inference Platform on Kubernetes

A production-style AI inference platform built with Kubernetes, GitOps, and open-source LLM tooling — deployed and managed entirely through a GitOps pipeline.


## What this project demonstrates

- **GitOps pipeline** — every deployment goes through Git via Argo CD, no manual kubectl apply in production
- **Kubernetes platform engineering** — namespace isolation, resource limits, health probes, service discovery
- **AI infrastructure** — LLM model serving on Kubernetes, inference API, chat UI
- **Observability** — Prometheus + Grafana monitoring (in progress)
- **Infrastructure as Code** — full GKE cluster provisioned via Terraform (see terraform/)
- **Engineering decisions documented** — Architecture Decision Records (ADRs) for every key choice

## Architecture

