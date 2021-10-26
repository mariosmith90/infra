resource "aws_api_gateway_domain_name" "gateway_domain_name" {
  domain_name              = var.aws_acm_certificate_domain_name
  regional_certificate_arn = var.aws_acm_certificate_arn

  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

resource "aws_api_gateway_base_path_mapping" "gateway_base_mapping" {
  api_id      = aws_api_gateway_rest_api.demo_rest_api.id
  domain_name = aws_api_gateway_domain_name.gateway_domain_name.domain_name
  stage_name  = aws_api_gateway_stage.gateway_stage.stage_name
}

