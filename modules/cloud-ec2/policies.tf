resource "aws_iam_instance_profile" "instance_iam" {
  name = "ec2_instance_iam"
  role = aws_iam_role.ec2_iam.name
}

resource "aws_iam_role" "ec2_iam" {
  name = "AmazonEC2ContainerServiceforEC2Role"
  path = "/"

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Principal": {
               "Service": "ec2.amazonaws.com"
            },
            "Effect": "Allow",
            "Sid": ""
        }
    ]
}
EOF
}