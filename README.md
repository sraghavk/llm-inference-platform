# LLM Inference Platform on Kubernetes

A production-style AI inference platform built with Kubernetes, GitOps, and open-source LLM tooling — deployed and managed entirely through a GitOps pipeline.

![Open WebUI showing LLM response](docs/screenshots/open_WebUI_Response.jpg)

## What this project demonstrates

- **GitOps pipeline** — every deployment goes through Git via Argo CD, no manual kubectl apply in production
- **Kubernetes platform engineering** — namespace isolation, resource limits, health probes, service discovery
- **AI infrastructure** — LLM model serving on Kubernetes, inference API, chat UI
- **Observability** — Prometheus + Grafana monitoring (in progress)
- **Infrastructure as Code** — full GKE cluster provisioned via Terraform (see terraform/)
- **Engineering decisions documented** — Architecture Decision Records (ADRs) for every key choice

## Architecture

```
Developer pushes to GitHub
        ↓
Argo CD detects change (GitOps)
        ↓
Kubernetes cluster (kind / GKE)
        ↓
Ollama serves LLM (phi-2, 3B params)
        ↓
Open WebUI — chat interface
```

## Stack

| Component | Tool | Purpose |
|---|---|---|
| Container orchestration | Kubernetes (kind / GKE) | Run all workloads |
| GitOps | Argo CD | Automated deployment from Git |
| LLM serving | Ollama | Serve open-source models |
| Chat UI | Open WebUI | Browser-based LLM interface |
| Observability | Prometheus + Grafana | Metrics and dashboards |
| Infrastructure as Code | Terraform | GKE cluster provisioning |
| Model | phi-2 (3B) | Local CPU inference |

## Project structure

```
llm-inference-platform/
├── terraform/          # GKE cluster infrastructure (IaC)
├── kubernetes/
│   └── ollama/         # Ollama + Open WebUI manifests
├── gitops/
│   └── apps/           # Argo CD Application definitions
├── monitoring/         # Prometheus + Grafana configs
└── docs/
    ├── adr-001-why-ollama-first.md
    ├── adr-002-wsl2-memory-config.md
    ├── adr-003-cpu-inference-limitations.md
    └── screenshots/
```

## Key engineering decisions

| Decision | Choice | Reasoning |
|---|---|---|
| Ollama over vLLM | Ollama | CPU-compatible for local dev; vLLM planned for GPU on GKE |
| GitOps over manual deploy | Argo CD | Auditability, drift detection, self-healing |
| phi-2 model | 3B params | Smallest viable model for CPU inference |
| kind for local dev | kind | Free, real Kubernetes API, no cloud cost |

Full decision rationale in [docs/](docs/)

## Running locally

### Prerequisites
- Docker Desktop with WSL2
- kubectl, kind, Helm

### Start the cluster
```bash
kind create cluster --name llm-lab --config kind-config.yaml
```

### Deploy via Argo CD
```bash
kubectl apply -f gitops/apps/ollama-app.yaml
```

Argo CD automatically syncs all manifests from this repo.

### Access the UI
```bash
kubectl port-forward svc/open-webui-service -n llm-inference 8081:8080
# Open http://localhost:8081
```

## Roadmap

- [ ] Migrate from Ollama to vLLM on GKE with GPU nodes
- [ ] Add Prometheus + Grafana observability dashboards
- [ ] Add HPA autoscaling based on inference load
- [ ] Add Kyverno policy enforcement
- [ ] Add CKS-aligned security hardening (RBAC, network policies)

## Author

Sri Kulkarni — Cloud Platform Engineer  
[github.com/sraghavk](https://github.com/sraghavk)
