# Create ECR repositories for backend_rds, backend_redis, and frontend
resource "aws_ecr_repository" "backend_rds_ecr" {
  name = "glovo-backend_rds-repo"

  tags = {
    Name = "glovo-backend_rds-ecr-repository"
  }
}

resource "aws_ecr_repository" "backend_redis_ecr" {
  name = "glovo-backend_redis-repo"

  tags = {
    Name = "glovo-backend_redis-ecr-repository"
  }
}

resource "aws_ecr_repository" "frontend_ecr" {
  name = "glovo-frontend-repo"

  tags = {
    Name = "glovo-frontend-ecr-repository"
  }
}

# VPC Endpoint для ECR API
resource "aws_vpc_endpoint" "ecr_api" {
  vpc_id              = module.vpc.vpc_id
  service_name        = "com.amazonaws.eu-central-1.ecr.api"
  vpc_endpoint_type   = "Interface"
  security_group_ids  = [aws_security_group.ecr_endpoint_sg.id]
  subnet_ids          = module.vpc.private_subnets # Додайте приватні підмережі
  private_dns_enabled = true

  tags = {
    Name = "glovo-ecr-api-endpoint"
  }
}

# VPC Endpoint для ECR DKR
resource "aws_vpc_endpoint" "ecr_dkr" {
  vpc_id              = module.vpc.vpc_id
  service_name        = "com.amazonaws.eu-central-1.ecr.dkr"
  vpc_endpoint_type   = "Interface"
  security_group_ids  = [aws_security_group.ecr_endpoint_sg.id]
  subnet_ids          = module.vpc.private_subnets # Додайте приватні підмережі
  private_dns_enabled = true

  tags = {
    Name = "glovo-ecr-dkr-endpoint"
  }
}
