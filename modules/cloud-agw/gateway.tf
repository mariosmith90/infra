resource "aws_api_gateway_rest_api" "demo_rest_api" {
  body = jsonencode({
    openapi = "3.0.1"
    info = {
      title   = var.rest_api_name
      version = "1.0"
    }
    paths = {
      (var.rest_api_path) = {
        get = {
          x-amazon-apigateway-integration = {
            httpMethod           = "GET"
            payloadFormatVersion = "1.0"
            type                 = "HTTP_PROXY"
            uri                  = "https://ip-ranges.amazonaws.com/ip-ranges.json"
          }
        }
      }
    }
  })

  name = var.rest_api_name

  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

resource "aws_api_gateway_vpc_link" "vpc_link" {
  name        = "vpc-link-${var.name}"
  target_arns = [var.alb_arn]
}

resource "aws_api_gateway_integration" "gateway_integration" {
  rest_api_id = aws_api_gateway_rest_api.demo_rest_api.id
  resource_id = aws_api_gateway_resource.gateway_resource.id
  http_method = aws_api_gateway_method.gateway_method.http_method

  request_parameters = {
    "integration.request.path.proxy" = "method.request.path.proxy"
  }

  type                    = var.integration_input_type
  uri                     = "http://${var.alb_dns_name}:${var.app_port}/{proxy}"
  integration_http_method = var.integration_http_method

  connection_type = "VPC_LINK"
  connection_id   = aws_api_gateway_vpc_link.vpc_link.id
}

resource "aws_api_gateway_resource" "gateway_resource" {
  rest_api_id = aws_api_gateway_rest_api.demo_rest_api.id
  parent_id   = aws_api_gateway_rest_api.demo_rest_api.root_resource_id
  path_part   = var.path_part
}

resource "aws_api_gateway_deployment" "api_deployment" {
  rest_api_id = aws_api_gateway_rest_api.demo_rest_api.id
  depends_on  = [aws_api_gateway_integration.gateway_integration]


  triggers = {
    redeployment = sha1(jsonencode(aws_api_gateway_rest_api.demo_rest_api.body))
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_stage" "gateway_stage" {
  deployment_id = aws_api_gateway_deployment.api_deployment.id
  rest_api_id   = aws_api_gateway_rest_api.demo_rest_api.id
  stage_name    = "gateway_stage"
}

resource "aws_api_gateway_method" "gateway_method" {
  rest_api_id   = aws_api_gateway_rest_api.demo_rest_api.id
  resource_id   = aws_api_gateway_resource.gateway_resource.id
  http_method   = "ANY"
  authorization = "NONE"

  request_parameters = {
    "method.request.path.proxy" = true
  }
}

resource "aws_api_gateway_method_settings" "gateway_method" {
  rest_api_id = aws_api_gateway_rest_api.demo_rest_api.id
  stage_name  = aws_api_gateway_stage.gateway_stage.stage_name
  method_path = "*/*"

  settings {
    metrics_enabled = true
  }
}