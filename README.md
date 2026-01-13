# Production Cloud Infrastructure (DevOps / SRE Project)

## Overview

This project demonstrates a **production-style cloud infrastructure** deployed on **AWS**, focusing on **DevOps and SRE practices** rather than application complexity.

The system provisions infrastructure using **Terraform**, deploys a **containerized FastAPI application** on an EC2 instance, implements **monitoring and observability** using **Prometheus and Grafana**, and includes a **self-healing (auto-recovery)** mechanism to automatically recover from failures.

This project is designed to simulate **real-world production operations** and is suitable as a **portfolio project for DevOps, Cloud, SRE, and Platform Engineering roles**.

---

## High-Level Architecture

```
┌────────────────────────────┐
│        User / Browser      │
└─────────────┬──────────────┘
              │ HTTP (80)
              ▼
┌────────────────────────────┐
│        AWS EC2 Instance    │
│   (Amazon Linux 2023)      │
│                            │
│  ┌──────────────────────┐ │
│  │   FastAPI (Docker)   │ │
│  │   /health endpoint   │ │
│  └──────────────────────┘ │
│            ▲               │
│            │               │
│  ┌──────────────────────┐ │
│  │  Auto-Recovery       │ │
│  │  (Cron + Script)     │ │
│  └──────────────────────┘ │
│                            │
│  ┌──────────────────────┐ │
│  │ Node Exporter (9100) │ │
│  └──────────────────────┘ │
│            ▲               │
│            │               │
│  ┌──────────────────────┐ │
│  │ Prometheus (9090)    │ │
│  └──────────────────────┘ │
│            ▲               │
│            │               │
│  ┌──────────────────────┐ │
│  │ Grafana (3000)       │ │
│  └──────────────────────┘ │
└────────────────────────────┘
```

---

## Technology Stack

### Cloud & Infrastructure

* **AWS EC2** – Cloud compute
* **Terraform** – Infrastructure as Code (IaC)
* **Security Groups** – Network access control

### Application & Runtime

* **FastAPI** – Lightweight Python API service
* **Docker** – Containerization

### Observability (Monitoring)

* **Prometheus** – Metrics collection
* **Node Exporter** – Host-level metrics
* **Grafana** – Metrics visualization

### Reliability & Operations

* **Cron (cronie)** – Scheduled health checks
* **Bash scripting** – Auto-recovery logic

---

## Project Structure

```
production-cloud-infra/
├── terraform/          # Infrastructure as Code (AWS EC2, SG, SSH keys)
├── app/                # FastAPI application + Dockerfile
├── monitoring/         # Prometheus config + Node Exporter
├── scripts/            # Auto-recovery health check scripts
├── demo/               # Screenshots & evidence
└── README.md
```

---

## Key Features

### 1. Infrastructure as Code

* EC2 instance provisioned using Terraform
* SSH keys managed programmatically
* Infrastructure is fully reproducible

### 2. Containerized Application

* FastAPI application running in Docker
* Health endpoint exposed at `/health`
* Internet-facing service via EC2 public IP

### 3. Monitoring & Observability

* Node Exporter collects CPU, memory, disk, and network metrics
* Prometheus scrapes metrics from host
* Grafana visualizes metrics with live dashboards

### 4. Self-Healing (Auto-Recovery)

* Health check script polls `/health`
* If unhealthy, Docker container is restarted automatically
* Cron runs checks every minute
* Failure simulation validated using `docker kill`

---

## How to Run 

### Infrastructure

```bash
terraform init
terraform apply
```

### Application

```bash
docker build -t fastapi-prod .
docker run -d -p 80:5000 --name fastapi-app fastapi-prod
```

### Monitoring

* Prometheus: `http://<PUBLIC_IP>:9090`
* Grafana: `http://<PUBLIC_IP>:3000`

### Auto-Recovery

```bash
docker kill fastapi-app
# Container restarts automatically via cron
```

---

## Lessons & Troubleshooting

* Diagnosed container-to-host networking issues (localhost vs private IP)
* Fixed Prometheus scrape failures
* Configured persistent Node Exporter using systemd
* Implemented self-healing without Kubernetes

---

## Project Points

* Built production-style cloud infrastructure using Terraform
* Deployed containerized services on AWS EC2
* Implemented observability using Prometheus and Grafana
* Designed and validated a self-healing mechanism
* Practiced real SRE troubleshooting scenarios
* CI/CD pipeline enabled via GitHub Actions.


---

## Future Improvements

* Docker image registry (ECR)
* HTTPS with ALB
* Kubernetes migration

---

## Author

**Muhammad Izzat Farhan**
DevOps / Cloud / SRE Portfolio Project
Trigger pipeline after enabling Actions
