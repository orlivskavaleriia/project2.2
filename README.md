# project2.2
AWS infrastructure + Docker + GitLab CI/CD + Terraform

AWS Infrastructure with Terraform
This repository defines a modular, production-ready AWS infrastructure using Terraform. It provisions a secure, scalable environment with services such as ECS, RDS, ElastiCache, S3, CloudFront, and more — suitable for containerized backend/frontend applications.

Overview
The infrastructure includes:
- VPC with public/private subnets across availability zones
- Security Groups for EC2, ALB, RDS, and ElastiCache
- Amazon RDS with PostgreSQL in private subnets
- Amazon ECS (Fargate) for deploying containerized services
- Application Load Balancer (ALB) with listener rules
- Elasticache (Redis) for caching
- S3 Bucket for static content and CloudFront origin
- CloudFront CDN for global distribution
- ECR for storing Docker container images

Project Structure
```
project-terraform/
└── infrastructure/
    ├── main.tf               # Root module for orchestration
    ├── vpc.tf                # Networking resources
    ├── sg.tf                 # Security groups
    ├── rds.tf                # Relational Database Service
    ├── ecs.tf                # ECS Cluster and Task Definitions
    ├── ecs_services.tf       # ECS Services configuration
    ├── alb.tf                # Application Load Balancer
    ├── elasticache.tf        # Redis Cluster
    ├── s3.tf                 # S3 Bucket for static files
    ├── cloudfront.tf         # CDN setup
    ├── ecr.tf                # Elastic Container Registry
    ├── variables.tf          # Input variables
    └── outputs.tf            # Outputs for referencing
```

Prerequisites
Terraform CLI ≥ 1.3
AWS CLI configured (aws configure)
IAM user with permission to manage:
VPC, RDS, ECS, ELB, CloudFront, ElastiCache, ECR, S3, IAM

Usage
Initialize the Terraform workspace:
terraform init

Validate the configuration:
terraform validate

Plan the changes:
terraform plan

Apply the infrastructure:
terraform apply

Security Groups
Fine-grained Security Group rules are configured to:
- Allow ALB to connect to ECS containers
- Allow ECS to access RDS and Redis
- Limit RDS/Redis access to private subnets only

 Load Balancing
- ALB routes traffic to ECS containers (port 80)
- ALB DNS is output for frontend/backend access
- CloudFront is used as a CDN with an origin pointing to the S3 bucket or ALB

Containers with ECS
- ECS Cluster on Fargate (serverless)
- Separate services for backend & frontend
- Each service pulls Docker images from ECR
- Logs are sent to CloudWatch

Database and Cache
- Amazon RDS (PostgreSQL) with subnet group and private access
- Amazon ElastiCache (Redis) in the private subnet for caching

Static Hosting and CDN
- Static assets are hosted in an S3 bucket
- CloudFront is configured with caching rules, SSL, and geo-distribution

Outputs
- After deployment, Terraform outputs:
- ALB DNS Name
- RDS Endpoint
- Redis Endpoint
- CloudFront Distribution URL
- S3 Bucket Name

Author
Created by Orlivska Valeriia
2025