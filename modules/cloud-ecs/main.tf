# Cluster 
resource "aws_ecs_cluster" "main" {
  name = var.name

  setting {
    name  = "containerInsights"
    value = "enabled"
  }

  tags = {
    Name = var.cluster_tag_name
  }
}

# Task Definition
resource "aws_ecs_task_definition" "main" {
  family                   = var.name
  task_role_arn            = aws_iam_role.task_role.arn
  execution_role_arn       = aws_iam_role.main_ecs_tasks.arn
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.fargate_cpu
  memory                   = var.fargate_memory
  container_definitions = jsonencode([
    {
      name : var.name,
      image : var.app_image,
      cpu : var.fargate_cpu,
      memory : var.fargate_memory,
      networkMode : "awsvpc",
      portMappings : [
        {
          containerPort : var.app_port
          protocol : "tcp",
          hostPort : var.app_port
        }
      ]
    }
  ])

  lifecycle {
    prevent_destroy = true
  }

  depends_on = [
    aws_ecs_cluster.main,
  ]
}

# Service
resource "aws_ecs_service" "main" {
  name             = "${var.name}-service"
  cluster          = aws_ecs_cluster.main.name
  task_definition  = aws_ecs_task_definition.main.family
  desired_count    = var.app_count
  launch_type      = "FARGATE"
  platform_version = "1.3.0"

  network_configuration {
    security_groups  = ["${var.sg_ecs_tasks_id}"]
    subnets          = var.alb_subnet_1
    assign_public_ip = "true"

  }

  load_balancer {
    target_group_arn = aws_lb_target_group.alb_tg.arn
    container_name   = var.name
    container_port   = var.app_port
  }

  lifecycle {
    ignore_changes = [task_definition]
  }

  depends_on = [
    aws_ecs_task_definition.main,
  ]
}