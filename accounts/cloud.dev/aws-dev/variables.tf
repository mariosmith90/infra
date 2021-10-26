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