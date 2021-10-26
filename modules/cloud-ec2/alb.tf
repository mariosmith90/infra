resource "aws_lb" "alb_ec2" {
  name               = "alb-${var.name}"
  internal           = true
  load_balancer_type = "application"
  subnets            = var.alb_subnet_1
  security_groups = ["${var.sg_ecs_tasks_id}"]


  enable_deletion_protection = true

  tags = {
    Environment = var.environment
  }
}

resource "aws_lb_target_group" "alb_tg_ec2" {
  depends_on = [
    aws_lb.alb_ec2
  ]

  name        = "alb-ec2-dev-group"
  port        = 8080
  protocol    = "HTTP"
  vpc_id      = var.alb_vpc_id
  target_type = "ip"
}

resource "aws_lb_listener" "alb_listener" {
  load_balancer_arn = aws_lb.alb_ec2.arn
  port              = 8080
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.alb_tg_ec2.arn
    type             = "forward"
  }
}