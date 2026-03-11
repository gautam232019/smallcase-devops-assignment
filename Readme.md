# smallcase DevOps Assignment

## Overview

This project demonstrates a simple DevOps workflow involving infrastructure provisioning using Terraform and application deployment using Docker.

---

# Architecture

User
->
EC2 Public IP
->
Docker Container
->
Flask API
->
Random Response

Infrastructure is provisioned using **Terraform**, and the application is packaged and deployed using **Docker**.

---

# Infrastructure (Terraform)

Terraform provisions the following AWS resources:

* EC2 Instance + Public IP
* KMS encrypted EBS
* Security Group -> ports **22** and **8081** allowed
* Dynamic Amazon Linux AMI (region agnostic)

### Key Features

**Dynamic AMI**

Terraform data source is used to fetch the latest Amazon Linux image:

```
data "aws_ami" "amazon_linux"
```

**Encrypted Storage**

The EC2 instance uses an encrypted EBS volume backed by AWS KMS.

---

# Application

A simple Flask API returns a random string from the following list:

* Investments
* Smallcase
* Stocks
* buy-the-dip
* TickerTape

### Endpoint

```
GET /api/v1
```

ex response:

```
{
 "message": "Stocks"
}
```

---

# Docker

The application is containerized using Docker.

### Build Image

```
docker build -t smallcase-random-app .
```

### Run Container

```
docker run -p 8081:8081 smallcase-random-app
```

---

# Deployment Process

1. Docker image built locally
2. Image pushed to DockerHub
3. Terraform provisions infrastructure
4. EC2 instance runs a **user-data script** that:

   * Installs Docker
   * Pulls the Docker image
   * Runs the container automatically

---

# Accessing the Application

After deployment, can be accessed using:

```
http://<EC2_PUBLIC_IP>:8081/api/v1
```

---

# Challenges Encountered

### Docker Architecture Issue

The Docker image was initially built on an Apple Silicon (ARM) machine, which caused compatibility issues when deploying to an EC2 instance running AMD64 architecture.

This was resolved by building the image using Docker Buildx with the following command:

```
docker buildx build --platform linux/amd64 -t <dockerhub-username>/smallcase-random-app --push .
```

# Future Improvements

If this were a production system, the following improvements could be implemented:

* CI/CD pipeline
* Container registry (ECR)
* Infrastructure modules in Terraform
* HTTPS via ALB or Nginx
* Health checks and monitoring
---
