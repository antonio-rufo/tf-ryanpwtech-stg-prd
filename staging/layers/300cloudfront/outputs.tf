###############################################################################
# Cloudfront Output
###############################################################################
output "cloudfront_arn" {
  description = "The ARN (Amazon Resource Name) for the distribution."
  value       = aws_cloudfront_distribution.cloudfront_distribution.arn
}

output "cloudfront_id" {
  description = "The identifier for the distribution."
  value       = aws_cloudfront_distribution.cloudfront_distribution.id
}

output "cloudfront_domain_name" {
  description = "The domain name corresponding to the distribution."
  value       = aws_cloudfront_distribution.cloudfront_distribution.domain_name
}
