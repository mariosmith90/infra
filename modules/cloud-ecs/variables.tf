variable "platform_name" {
  description = "The name of the platform"
  default     = "aws"
  type        = string
}

variable "environment" {
  type        = string
  default     = "development"
  description = "This is the name of the application environment."
}

variable "name" {
  type        = string
  default     = "dev-cluster"
  description = "The name of the cluster"
}

variable "cluster_tag_name" {
  type        = string
  default     = "This cluster is managed by Terraform"
  description = "Name tag for the cluster"
}

variable "app_image" {
  type        = string
  default     = "447671213941.dkr.ecr.us-east-1.amazonaws.com/cloud-lab:latest"
  description = "Container image to be used for application in task definition file"
}

variable "fargate_cpu" {
  type        = number
  default     = "512"
  description = "Fargate cpu allocation"
}

variable "fargate_memory" {
  type        = number
  default     = "1024"
  description = "Fargate memory allocation"
}

variable "app_port" {
  type        = number
  description = "Application port"
  default     = "8080"
}

variable "alb_subnet_1" {
  type = set(string)
}

variable "database_subnet" {
  type = set(string)
}

variable "alb_vpc_id" {
  type = string
}

# variable "vpc_id" {
#   type        = string
#   description = "The id for the VPC where the ECS container instance should be deployed"
# }

variable "cluster_id" {
  type        = string
  default     = "development-cluster"
  description = "Cluster ID"
}

variable "app_count" {
  type        = number
  default     = "1"
  description = "The number of instances of the task definition to place and keep running."
}

variable "sg_ecs_tasks_id" {
  type        = string
  description = "The ID of the security group for the ECS tasks"
}