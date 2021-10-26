resource "aws_vpc_endpoint" "ecr_dkr" {
  vpc_id              = aws_vpc.alb_vpc.id
  service_name        = "com.amazonaws.${var.region}.ecr.dkr"
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true
  subnet_ids          = aws_subnet.alb_subnet_1.*.id

  security_group_ids = [
    "${aws_security_group.ecs_tasks.id}",
  ]

  tags = {
    Name        = "ECR Docker VPC Endpoint Interface - ${var.environment_name}"
    Environment = var.environment_name
  }
}

resource "aws_vpc_endpoint" "cloudwatch" {
  vpc_id            = aws_vpc.alb_vpc.id
  service_name      = "com.amazonaws.${var.region}.logs"
  vpc_endpoint_type = "Interface"
  subnet_ids        = aws_subnet.alb_subnet_1.*.id

  security_group_ids = [
    "${aws_security_group.ecs_tasks.id}",
  ]

  tags = {
    Name        = "CloudWatch VPC Endpoint Interface - ${var.environment_name}"
    Environment = var.environment_name
  }
}

resource "aws_vpc_endpoint" "s3" {
  vpc_id            = aws_vpc.alb_vpc.id
  service_name      = "com.amazonaws.${var.region}.s3"
  vpc_endpoint_type = "Gateway"
  route_table_ids   = ["${aws_route_table.alb_route_table.id}"]

  depends_on = [
    aws_route_table.alb_route_table
  ]

  tags = {
    Name        = "S3 VPC Endpoint Gateway - ${var.environment_name}"
    Environment = var.environment_name
  }
}