# ElastiCache (Redis)
resource "aws_elasticache_cluster" "glovo_redis" {
  cluster_id           = "glovo-${var.project_name}-redis"
  engine               = "redis"
  node_type            = "cache.t3.micro"
  num_cache_nodes      = 1
  parameter_group_name = "default.redis7"
  port                 = 6379
  subnet_group_name    = aws_elasticache_subnet_group.glovo_main.name
  security_group_ids   = [aws_security_group.glovo_redis_sg.id]

  tags = {
    Name = "glovo-${var.project_name}-redis"
  }
}

# ElastiCache Subnet Group
resource "aws_elasticache_subnet_group" "glovo_main" {
  name       = "glovo-${var.project_name}-redis-subnet-group"
  subnet_ids = module.vpc.private_subnets

  tags = {
    Name = "glovo-${var.project_name}-redis-subnet-group"
  }
}
