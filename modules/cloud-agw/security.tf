resource "tls_private_key" "tls_encryption" {
  algorithm = "RSA"
}

resource "tls_self_signed_cert" "self_signed" {
  allowed_uses = [
    "key_encipherment",
    "digital_signature",
    "server_auth",
  ]
  dns_names             = [var.rest_api_domain_name]
  key_algorithm         = tls_private_key.tls_encryption.algorithm
  private_key_pem       = tls_private_key.tls_encryption.private_key_pem
  validity_period_hours = 12

  subject {
    common_name  = var.rest_api_domain_name
    organization = "Citigrove, Inc"
  }
}

resource "aws_acm_certificate" "tls_cert" {
  certificate_body = tls_self_signed_cert.self_signed.cert_pem
  private_key      = tls_private_key.tls_encryption.private_key_pem
}