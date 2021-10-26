resource "aws_ecs_cluster" "ec2_cluster" {
  name = var.cluster_name

  setting {
    name  = "containerInsights"
    value = "enabled"
  }

  tags = {
    Name = var.cluster_tag_name
  }
}

resource "aws_ecs_task_definition" "ec2_ecs_td" {
  family                   = var.cluster_name
  task_role_arn            = var.task_role
  execution_role_arn       = var.main_ecs_role
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.fargate_cpu
  memory                   = var.fargate_memory
  container_definitions = jsonencode([
    {
      name : var.ec2_name,
      image : var.ec2_app_image,
      cpu : var.fargate_cpu,
      memory : var.fargate_memory,
      
      environment: [
        { "name": "DATABASE_USER", "value": "postgres" },
        { "name": "DATABASE_HOST", "value": "dev-database1.cd5psmkdi9ov.us-east-1.rds.amazonaws.com" },
        { "name": "DATABASE_PASSWORD", "value": "bJvFgd0BrvEfwyLN" },
        { "name": "DATABASE_NAME", "value": "" },
        { "name": "DATABASE_PORT", "value": "5432" },
      ]
      networkMode : "awsvpc",
      portMappings : [
        {
          containerPort : 8080
          protocol : "tcp",
          hostPort : 8080
        },
        {
          containerPort : 5432
          protocol : "tcp",
          hostPort : 5432
        }
      ]
    }
  ])
  depends_on = [
    aws_ecs_cluster.ec2_cluster,
  ]
}

resource "aws_ecs_service" "ec2_ecs_service" {
  name             = "${var.cluster_name}-service"
  cluster          = aws_ecs_cluster.ec2_cluster.name
  task_definition  = aws_ecs_task_definition.ec2_ecs_td.family
  desired_count    = var.app_count
  launch_type      = "FARGATE"
  platform_version = "1.3.0"



  network_configuration {
    security_groups = ["${var.sg_ecs_tasks_id}"]
    subnets         = var.alb_subnet_1
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.alb_tg_ec2.id
    container_name   = "ec2-development-cluster"
    container_port   = 8080
  }

  lifecycle {
    ignore_changes = [task_definition]
  }


  depends_on = [
    aws_ecs_task_definition.ec2_ecs_td,
  ]
}