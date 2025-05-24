resource "aws_ecs_task_definition" "backend_rds" {
  family                   = "backend_rds_task"
  container_definitions    = file("backend_rds_task.json")
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = aws_iam_role.ecs_task_execution.arn
  task_role_arn            = aws_iam_role.ecs_task_execution.arn

}

resource "aws_ecs_task_definition" "backend_redis" {
  family                   = "backend_redis_task"
  container_definitions    = file("backend_redis_task.json")
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = aws_iam_role.ecs_task_execution.arn
  task_role_arn            = aws_iam_role.ecs_task_execution.arn
}

resource "aws_ecs_task_definition" "frontend" {
  family                   = "frontend_task"
  container_definitions    = file("frontend_task.json")
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = aws_iam_role.ecs_task_execution.arn
  task_role_arn            = aws_iam_role.ecs_task_execution.arn
}

resource "aws_cloudwatch_log_group" "backend_rds" {
  name              = "/ecs/backend_rds"
  retention_in_days = 7
}

resource "aws_cloudwatch_log_group" "backend_redis" {
  name              = "/ecs/backend_redis"
  retention_in_days = 7
}

resource "aws_cloudwatch_log_group" "frontend" {
  name              = "/ecs/frontend"
  retention_in_days = 7
}
