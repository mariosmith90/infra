variable "name" {
  type    = string
  default = "cloud"
}

variable "aws_acm_certificate_domain_name" {
  type = string
}

variable "app_port" {
  type    = string
  default = "8080"
}

variable "aws_acm_certificate_arn" {
  type = string
}

variable "rest_api_domain_name" {
  default     = "citigrove.co"
  description = "Domain name of the API Gateway REST API for self-signed TLS certificate"
  type        = string
}

variable "rest_api_name" {
  default     = "api-gateway-rest-api"
  description = "Name of the API Gateway REST API (can be used to trigger redeployments)"
  type        = string
}

variable "rest_api_path" {
  default     = "/path1"
  description = "Path to create in the API Gateway REST API (can be used to trigger redeployments)"
  type        = string
}

variable "path_part" {
  type        = string
  default     = "{proxy+}"
  description = "The last path segment of this API resource"
}

variable "integration_input_type" {
  type        = string
  default     = "HTTP_PROXY"
  description = "The integration input's type."
}

variable "integration_http_method" {
  type        = string
  default     = "ANY"
  description = "The integration HTTP method (GET, POST, PUT, DELETE, HEAD, OPTIONs, ANY, PATCH) specifying how API Gateway will interact with the back end."
}

variable "alb_dns_name" {
  type        = string
  description = "The DNS name of the internal NLB"
}

variable "alb_arn" {
  type        = string
  description = "The ARN of the internal NLB"
}