data "aws_availability_zones" "available" {}


resource "aws_eip" "gateway_ip" {
  vpc = true
}

# resource "aws_eip" "rds_eip" {
#   vpc = true
# }


resource "aws_vpc" "cloud_vpc" {
  cidr_block           = var.vpc_cidr
  instance_tenancy     = "default"
  enable_dns_hostnames = true

  tags = {
    Name        = "Cloud VPC"
    Environment = var.environment_name
  }
}

resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.cloud_vpc.id

  tags = {
    Name        = "Cloud IGW"
    Environment = var.environment_name
  }
}

# resource "aws_nat_gateway" "rds_gateway" {
#   connectivity_type = "private"
#   subnet_id         = aws_subnet.database_subnet.0.id
#   # allocation_id     = aws_eip.rds_eip.id

#   tags = {
#     Name        = "RDS NGW"
#     Environment = var.environment_name
#   }
# }

resource "aws_subnet" "public_subnet_2" {
  vpc_id                  = aws_vpc.cloud_vpc.id
  cidr_block              = var.public_subnet_2_cidr
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true

  tags = {
    Name        = "Public Subnet 2"
    Environment = var.environment_name
  }
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.cloud_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }

  tags = {
    Name        = "Public Route Table"
    Environment = var.environment_name
  }
}

resource "aws_route_table_association" "database_route_table_association" {
  subnet_id      = aws_subnet.database_subnet.0.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_subnet" "database_subnet" {
  vpc_id                  = aws_vpc.cloud_vpc.id
  cidr_block              = cidrsubnet(var.database_cidr, 4, count.index)
  count                   = length(data.aws_availability_zones.available.names)
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = false

  tags = {
    Name        = "Database Subnet"
    Environment = var.environment_name
  }
}