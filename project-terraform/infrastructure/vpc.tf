module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.17.0"

  name                 = "glovo-vpc"
  cidr                 = "10.0.0.0/16"
  azs                  = ["eu-central-1a", "eu-central-1b", "eu-central-2a", "eu-central-2b"]
  private_subnets      = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets       = ["10.0.101.0/24", "10.0.102.0/24"]
  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    "Environment" = "Production",
    "Owner"       = "Glovo"
  }

  create_igw = true

  # Автоматичні маршрути для public і private сабнетів
  public_subnet_tags = {
    Name        = "glovo-public"
    Environment = "Production"
  }
  private_subnet_tags = {
    Name        = "glovo-private"
    Environment = "Production"
  }
}

resource "aws_eip" "nat" {
  domain = "vpc"

  tags = {
    Name = "glovo-vpc-nat-eip"
  }
}

# Забезпечуємо, що NAT Gateway прив'язаний до першого публічного сабнету
resource "aws_nat_gateway" "this" {
  allocation_id = aws_eip.nat.id
  subnet_id     = module.vpc.public_subnets[0]

  tags = {
    Name = "glovo-vpc-nat"
  }
}

resource "aws_vpc_endpoint" "elasticache" {
  vpc_id       = module.vpc.vpc_id
  service_name = "com.amazonaws.eu-central-1.elasticache"
  vpc_endpoint_type = "Interface"
  security_group_ids = [aws_security_group.ecs.id]
  subnet_ids        = module.vpc.private_subnets
  private_dns_enabled = true
  }
