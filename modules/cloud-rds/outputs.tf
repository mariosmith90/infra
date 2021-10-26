output db_username {
    value = aws_db_instance.database_instance.username
}

output db_hostname {
    value = aws_db_instance.database_instance.endpoint
}

# output db_password {
#     value = random_password.master.result
# }

output db_port{
    value = aws_db_instance.database_instance.port
}