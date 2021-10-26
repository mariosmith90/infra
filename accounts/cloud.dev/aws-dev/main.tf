terraform {
  backend "s3" {
    bucket         = "cloud-state-management"
    key            = "terraform/state/dev/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-lock"
  }
}

resource "aws_dynamodb_table" "terraform_lock" {
  name         = "terraform-lock"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}


module "cloud_vpc" {
  source           = "../../../modules/cloud-vpc"
  environment_name = "Development"
}

module "cloud_agw" {
  source                          = "../../../modules/cloud-agw"
  alb_arn                         = module.cloud_ecs.alb_arn
  alb_dns_name                    = module.cloud_ecs.alb_dns_name
  aws_acm_certificate_arn         = module.cloud_cdn.aws_acm_certificate_arn
  aws_acm_certificate_domain_name = module.cloud_cdn.aws_acm_certificate_domain_name
}

module "cloud_cdn" {
  source                      = "../../../modules/cloud-cdn"
  domain_name                 = "citigrove.co"
  bucket_name                 = module.cloud_web.bucket_name
  bucket_domain_name          = module.cloud_web.bucket_domain_name
  bucket_regional_domain_name = module.cloud_web.bucket_regional_domain_name
}

module "cloud_ec2" {
  source              = "../../../modules/cloud-ec2"
  cluster_name        = "ec2-cluster-sg"
  main_ecs_role       = module.cloud_ecs.main_ecs_role
  aws_lb_target_group = module.cloud_ecs.aws_lb_target_group
  task_role           = module.cloud_ecs.task_role
  alb_vpc_id          = module.cloud_vpc.alb_vpc_id
  alb_subnet_1        = module.cloud_vpc.alb_subnet_1
  vpc_zone_identifier = module.cloud_vpc.alb_subnet_1
  sg_ecs_tasks_id     = module.cloud_vpc.sg_ecs_tasks_id
}

module "cloud_ecs" {
  source           = "../../../modules/cloud-ecs"
  name             = "${var.platform_name}-${var.environment}-cluster"
  environment      = "Development Lab"
  alb_vpc_id       = module.cloud_vpc.alb_vpc_id
  database_subnet  = module.cloud_vpc.database_subnet
  alb_subnet_1     = module.cloud_vpc.alb_subnet_1
  sg_ecs_tasks_id  = module.cloud_vpc.sg_ecs_tasks_id
}

module "cloud_rds" {
  source               = "../../../modules/cloud-rds"
  apply_immediately    = "true"
  parameter_group_name = "dev-paramgroup1"
  instance_identifier  = "dev-database1"
  instance_class       = "db.t3.medium"
  database_subnet      = module.cloud_vpc.database_subnet
}

module "cloud_redis" {
  source = "../../../modules/cloud-redis"
}

module "cloud_web" {
  source                                = "../../../modules/cloud-web"
  bucket_name                           = "citigrove.co"
  aws_cloudfront_origin_access_identity = module.cloud_cdn.aws_cloudfront_origin_access_identity
}