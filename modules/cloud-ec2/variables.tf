variable "cluster_name" {
  description = "The name to use to create the cluster and the resources. Only alphanumeric characters and dash allowed (e.g. 'my-cluster')"
}

variable "alb_vpc_id" {
  type    = string
  default = ""
}

variable "app_count" {
  type    = number
  default = "1"
}

variable "environment" {
  type    = string
  default = "Development"
}

variable "task_role" {
  type    = string
  default = ""
}

variable "main_ecs_role" {
  type    = string
  default = ""
}

variable "name" {
  type    = string
  default = "ec2-dev-cluster"
}

# variable "public_subnet_1" {
#   type = set(string)
# }



variable "ec2_name" {
  type    = string
  default = "ec2-development-cluster"
}


variable "vpc_zone_identifier" {
  type = set(string)
}

variable "sg_ecs_tasks_id" {
  type        = string
  description = "The ID of the security group for the ECS tasks"
}


variable "aws_lb_target_group" {
  type    = string
  default = ""
}

variable "alb_subnet_1" {
  type    = set(string)
}

variable "ec2_app_image" {
  type        = string
  default     = "447671213941.dkr.ecr.us-east-1.amazonaws.com/citigrove-api:latest"
  description = "Container image to be used for application in task definition file"

}

variable "fargate_cpu" {
  type        = number
  default     = "1024"
  description = "Fargate cpu allocation"
}

variable "fargate_memory" {
  type        = number
  default     = "2048"
  description = "Fargate memory allocation"
}

variable "cluster_tag_name" {
  type    = string
  default = "Cluster managed by Terraform"
}

variable "ssh_key_name" {
  description = "SSH key to use to enter and manage the EC2 instances within the cluster. Optional"
  default     = ""
}

variable "instance_type" {
  default = "t2.small"
}

variable "spot_bid_price" {
  default     = "0.0113"
  description = "How much you are willing to pay as an hourly rate for an EC2 instance, in USD"
}

variable "min_spot_instances" {
  default     = "1"
  description = "The minimum EC2 spot instances to have available within the cluster when the cluster receives less traffic"
}

variable "max_spot_instances" {
  default     = "5"
  description = "The maximum EC2 spot instances that can be launched during period of high traffic"
}

variable "app_port" {
  type        = number
  description = "Application port"
  default     = "8080"
}