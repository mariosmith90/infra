variable "bucket_name" {
  description = "S3 bucket name"
  type        = string
}

variable "aws_cloudfront_origin_access_identity" {
  type = string
}

variable "domain_name" {
  type    = string
  default = "https://citigrove.co"
}