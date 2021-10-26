output "vpc_id" {
  value = aws_vpc.cloud_vpc.id
}

output "alb_vpc_id" {
  value = aws_vpc.alb_vpc.id
}

output "eip_address" {
  value = aws_eip.gateway_ip.id
}

output "sg_ecs_tasks_id" {
  value = aws_security_group.ecs_tasks.id
}

# output "vpc_zone_identifier" {
#   value = aws_subnet.public_subnet_1[*].id
# }

# output "public_subnet_1" {
#   value = aws_subnet.public_subnet_1[*].id
# }

output "alb_subnet_1" {
  value = aws_subnet.alb_subnet_1[*].id
}

output "public_subnet_2" {
  value = aws_subnet.public_subnet_2.id
}

output "database_subnet" {
  value = aws_subnet.database_subnet[*].id
}

output "rtb_id" {
  value = aws_route_table.public_route_table.id
}



