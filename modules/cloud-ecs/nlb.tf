resource "aws_lb" "alb" {
  name               = "alb-${var.name}"
  internal           = true
  load_balancer_type = "network"
  subnets            = var.alb_subnet_1

  enable_deletion_protection = true

  tags = {
    Environment = var.environment
  }
}

resource "aws_lb_target_group" "alb_tg" {
  depends_on = [
    aws_lb.alb
  ]

  name        = "alb-dev-group"
  port        = var.app_port
  protocol    = "TCP"
  vpc_id      = var.alb_vpc_id
  target_type = "ip"
}

resource "aws_lb_listener" "alb_listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = var.app_port
  protocol          = "TCP"

  default_action {
    target_group_arn = aws_lb_target_group.alb_tg.arn
    type             = "forward"
  }
}