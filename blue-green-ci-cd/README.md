# Micro-service based app with Blue-Green CI/CD (BEGINNER FRIENDLY)

This repo is a **simple learning project** that shows:

- 3 tiny Python Flask microservices
- Each service is built into a Docker image
- A Jenkins **multibranch pipeline**:
  - branch `int`  → deploy to INT server
  - branch `main` → blue‑green deploy to PROD server
- Terraform code (very small) to create 2 EC2 instances which act as:
  - INT Docker server
  - PROD Docker + NGINX server

> This is **not production‑grade**, but it is perfect for learning and for interviews.
> You can open each file and read the comments step‑by‑step.
