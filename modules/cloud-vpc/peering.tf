# resource "aws_vpc_peering_connection" "cloud_alb_peering" {
#   peer_vpc_id   = aws_vpc.cloud_vpc.id
#   vpc_id        = aws_vpc.alb_vpc.id
#   auto_accept   = true

#   tags = {
#     Name = "VPC Peering between Application and Website VPC"
#   }
# }
