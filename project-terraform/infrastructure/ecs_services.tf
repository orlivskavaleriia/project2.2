#ecs_services.tf:
resource "aws_ecs_service" "backend-rds" {
  name                   = "backend-rds"
  cluster                = aws_ecs_cluster.glovo.id
  task_definition        = aws_ecs_task_definition.backend_rds.arn
  desired_count          = 1
  launch_type            = "FARGATE"
  enable_execute_command = true

  network_configuration {
    subnets          = module.vpc.private_subnets
    security_groups  = [aws_security_group.ecs.id]
    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.backend_rds_tg.arn
    container_name   = "backend-rds"
    container_port   = 8000
  }
  service_connect_configuration {
      enabled   = true
      namespace = aws_service_discovery_http_namespace.service_discovery.arn
      service {
        discovery_name = "backend-rds"
        port_name      = "backend-rds"
        client_alias {
          dns_name = "backend-rds"
          port     = 8000
        }
      }
}
  lifecycle {
    ignore_changes = [task_definition]
  }
}

resource "aws_ecs_service" "backend-redis" {
  name            = "backend-redis"
  cluster         = aws_ecs_cluster.glovo.id
  task_definition = aws_ecs_task_definition.backend_redis.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  enable_execute_command = true

  network_configuration {
    subnets          = module.vpc.private_subnets
    security_groups  = [aws_security_group.ecs.id]
    assign_public_ip = false
  }
  load_balancer {
    target_group_arn = aws_lb_target_group.redis_tg.arn
    container_name   = "backend-redis"
    container_port   = 8001
  }
  service_connect_configuration {
      enabled   = true
      namespace = aws_service_discovery_http_namespace.service_discovery.arn
      service {
        discovery_name = "backend-redis"
        port_name      = "backend-redis"
        client_alias {
          dns_name = "backend-redis"
          port     = 8001
        }
      }
}
  lifecycle {
    ignore_changes = [task_definition]
  }
}

resource "aws_ecs_service" "frontend" {
  name            = "frontend"
  cluster         = aws_ecs_cluster.glovo.id
  task_definition = aws_ecs_task_definition.frontend.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  enable_execute_command = true

  network_configuration {
    subnets          = module.vpc.private_subnets
    security_groups  = [aws_security_group.ecs.id]
    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.frontend_tg.arn
    container_name   = "frontend"
    container_port   = 3000
  }
    service_connect_configuration {
      enabled   = true
      namespace = aws_service_discovery_http_namespace.service_discovery.arn
      service {
        discovery_name = "frontend"
        port_name      = "frontend"
        client_alias {
          dns_name = "frontend"
          port     = 3000
        }
      }
}
  lifecycle {
    ignore_changes = [task_definition]
  }
}