output db_username {
    value = module.cloud_rds.db_username
}

output db_hostname {
    value = module.cloud_rds.db_hostname
}

# output db_password {
#     value = module.cloud_rds.db_password
#     sensitive = true
# }

output db_port{
    value = module.cloud_rds.db_port
}