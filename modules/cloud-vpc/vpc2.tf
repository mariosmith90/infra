resource "aws_vpc" "alb_vpc" {
  cidr_block           = var.vpc_cidr
  instance_tenancy     = "default"
  enable_dns_hostnames = true

  tags = {
    Name        = "Application VPC"
    Environment = var.environment_name
  }
}

resource "aws_internet_gateway" "alb_gateway" {
  vpc_id = aws_vpc.alb_vpc.id

  tags = {
    Name        = "Cloud IGW"
    Environment = var.environment_name
  }
}

resource "aws_subnet" "alb_subnet_1" {
  vpc_id                  = aws_vpc.alb_vpc.id
  cidr_block              = cidrsubnet(var.public_subnet_1_cidr, 4, count.index)
  count                   = length(data.aws_availability_zones.available.names)
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name        = "Application Subnet"
    Environment = var.environment_name
  }
}

resource "aws_route_table" "alb_route_table" {
  vpc_id = aws_vpc.alb_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.alb_gateway.id
  }

  tags = {
    Name        = "Public Route Table"
    Environment = var.environment_name
  }
}

resource "aws_route_table_association" "public_subnet_1_route_table_association" {
  subnet_id      = aws_subnet.alb_subnet_1.0.id
  route_table_id = aws_route_table.alb_route_table.id
}
