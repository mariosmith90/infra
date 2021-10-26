resource "aws_security_group" "sg_for_ec2_instances" {
  name_prefix = "${var.cluster_name} group"
  description = "Security group for EC2 instances within the cluster"
  vpc_id      = var.alb_vpc_id

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = var.cluster_name
  }
}


resource "aws_security_group_rule" "allow_alb" {
  type      = "ingress"
  from_port = 8080
  to_port   = 8080
  protocol  = "all"
  cidr_blocks = [
    "0.0.0.0/0"
  ]
  security_group_id = aws_security_group.sg_for_ec2_instances.id
}

resource "aws_security_group_rule" "allow_ssh" {
  type      = "ingress"
  from_port = 22
  to_port   = 22
  protocol  = "tcp"
  cidr_blocks = [
    "0.0.0.0/0"
  ]
  security_group_id = aws_security_group.sg_for_ec2_instances.id
}

resource "aws_security_group_rule" "allow_http_in" {
  from_port         = 80
  protocol          = "tcp"
  security_group_id = aws_security_group.sg_for_ec2_instances.id
  to_port           = 80
  cidr_blocks = [
    "0.0.0.0/0"
  ]
  type = "ingress"
}

resource "aws_security_group_rule" "allow_https_in" {
  protocol  = "tcp"
  from_port = 443
  to_port   = 443
  cidr_blocks = [
    "0.0.0.0/0"
  ]
  security_group_id = aws_security_group.sg_for_ec2_instances.id
  type              = "ingress"
}

resource "aws_security_group_rule" "allow_egress_all" {
  security_group_id = aws_security_group.sg_for_ec2_instances.id
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks = [
  "0.0.0.0/0"]
}