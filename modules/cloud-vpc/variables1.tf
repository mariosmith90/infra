# VPC Variables

variable "environment_name" {
  type = string
}

variable "region" {
  default     = "us-east-1"
  description = "AWS Region"
  type        = string
}

variable "app_port" {
  type    = number
  default = "8080"
}

variable "vpc_cidr" {
  default     = "10.0.0.0/16"
  description = "VPC CIDR Block"
  type        = string
}

variable "main_pvt_route_table_id" {
  type        = string
  default     = "rtb-dev-private"
  description = "Main route table id"
}

variable "vpc_cidr_block" {
  type        = string
  default     = "10.0.0.0/16"
  description = "CIDR block range for vpc"
}

variable "security_group_lb_name" {
  type        = string
  default     = "alb-sg"
  description = "Load Balancer security group name"
}

variable "security_group_lb_description" {
  type        = string
  default     = "controls access to the ALB"
  description = "Load Balancer security group description"
}

variable "security_group_ecs_tasks_name" {
  type        = string
  default     = "ecs-tasks-sg"
  description = "ECS Tasks security group name"
}

variable "security_group_ecs_tasks_description" {
  type        = string
  default     = "allow inbound access from the ECS ALB only"
  description = "ECS tasks security group description"
}

variable "public_subnet_1_cidr" {
  default     = "10.0.0.0/24"
  description = "Public Subnet 1 CIDR Block"
  type        = string
}

variable "public_subnet_2_cidr" {
  default     = "10.0.1.0/24"
  description = "Public Subnet 2 CIDR Block"
  type        = string
}

variable "private_subnet_1_cidr" {
  default     = "10.0.2.0/24"
  description = "Private Subnet 1 CIDR Block"
  type        = string
}

variable "private_subnet_2_cidr" {
  default     = "10.0.3.0/24"
  description = "Private Subnet 2 CIDR Block"
  type        = string
}

variable "private_subnet_3_cidr" {
  default     = "10.0.4.0/24"
  description = "Private Subnet 3 CIDR Block"
  type        = string
}

variable "database_cidr" {
  default     = "10.0.5.0/24"
  description = "Private Subnet 4 CIDR Block"
  type        = string
}