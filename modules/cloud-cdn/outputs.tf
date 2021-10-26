output "aws_cloudfront_origin_access_identity" {
  value = aws_cloudfront_origin_access_identity.oai.iam_arn
}


output "aws_acm_certificate_domain_name" {
  value = aws_acm_certificate.cert.domain_name
}


output "aws_acm_certificate_arn" {
  value = aws_acm_certificate.cert.arn
}
