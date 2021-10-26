# data "aws_secretsmanager_secret" "password" {
#   name = "db-password"

# }

# Create Database Subnet Group
# terraform aws db subnet group
resource "aws_db_subnet_group" "database_subnet_group" {
  name        = "database subnets"
  subnet_ids  = var.database_subnet
  description = "Subnets for Database Instance"

  tags = {
    Name = "Database Subnets"
  }
}

# Create Database Instance Restored from DB Snapshots
# terraform aws db instance
resource "aws_db_instance" "database_instance" {
  availability_zone            = "us-east-1a"
  apply_immediately            = var.apply_immediately
  allocated_storage            = var.allocated_storage
  identifier                   = var.instance_identifier
  username                     = var.db_username
  password                     = "bJvFgd0BrvEfwyLN"
  # password                     = data.aws_secretsmanager_secret.password.id
  instance_class               = var.instance_class
  db_subnet_group_name         = aws_db_subnet_group.database_subnet_group.name
  engine                       = var.engine
  engine_version               = var.engine_version
  parameter_group_name         = var.parameter_group_name
  publicly_accessible          = true
  skip_final_snapshot          = true
  deletion_protection          = true
  performance_insights_enabled = true
}