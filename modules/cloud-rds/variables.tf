variable "apply_immediately" {
  type = bool
}

variable "allocated_storage" {
  type    = number
  default = 20
}

variable "engine" {
  type    = string
  default = "postgres"
}

variable "engine_version" {
  type    = string
  default = "13"
}

variable "parameter_group_name" {
  type    = string
  default = ""
}

variable "instance_identifier" {
  type    = string
  default = ""
}

variable "db_username" {
  type    = string
  default = "postgres"
}

variable "instance_class" {
  type    = string
  default = ""
}

# variable "private_subnet_3" {
#     type = string
# }

variable "database_subnet" {
  type = set(string)
}
