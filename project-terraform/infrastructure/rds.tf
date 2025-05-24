resource "aws_db_instance" "glovo_rds_instance" {
  identifier             = "glovo-rds-instance"
  engine                 = "postgres"
  engine_version         = "13"
  instance_class         = "db.t3.micro"
  allocated_storage      = 20
  db_subnet_group_name   = aws_db_subnet_group.glovo_rds_subnet_group.name
  vpc_security_group_ids = [aws_security_group.glovo_rds_sg.id]
  multi_az               = false
  publicly_accessible    = false
  username               = "postgres"
  password               = "postgres"
  skip_final_snapshot    = true

  parameter_group_name = "default.postgres13"
}

resource "aws_db_subnet_group" "glovo_rds_subnet_group" {
  name       = "glovo-rds-subnet-group"
  subnet_ids = module.vpc.private_subnets
  tags = {
    Name = "glovo-rds-subnet-group"
  }
}
