variable "bucket_domain_name" {
  description = "Endpoint url"
  type        = string
  default     = ""
}

variable "domain_name" {
  description = "Domain name"
  type        = string
}

variable "bucket_name" {
  type = string
}

variable "bucket_regional_domain_name" {
  description = "Regional Domain Name as reported by Amazon S3"
  type        = string
}