# 300cloudfront Layer

###############################################################################
# Providers
###############################################################################
provider "aws" {
  region              = var.region
  allowed_account_ids = [var.aws_account_id]
}

locals {
  tags = {
    Environment = var.environment
  }
}

###############################################################################
# Terraform main config
###############################################################################
terraform {
  required_version = ">= 0.14"
  required_providers {
    aws = "~> 3.6.0"
  }

  backend "s3" {
    bucket  = "162198556136-build-state-bucket-staging"
    key     = "terraform.staging.300cloudfront.tfstate"
    region  = "ap-southeast-2"
    encrypt = "true"
  }
}

###############################################################################
# Terraform Remote State
###############################################################################

### PLEASE UPDATE BACKEND BUCKET NAME AND REGION

# 000base
data "terraform_remote_state" "_000base" {
  backend = "s3"

  config = {
    bucket  = "162198556136-build-state-bucket-staging"
    key     = "terraform.staging.000base.tfstate"
    region  = "ap-southeast-2"
    encrypt = "true"
  }
}

# 100beanstalk
data "terraform_remote_state" "_100beanstalk" {
  backend = "s3"

  config = {
    bucket  = "162198556136-build-state-bucket-staging"
    key     = "terraform.staging.100beanstalk.tfstate"
    region  = "ap-southeast-2"
    encrypt = "true"
  }
}

# 200data
data "terraform_remote_state" "_200data" {
  backend = "s3"

  config = {
    bucket  = "162198556136-build-state-bucket-staging"
    key     = "terraform.staging.200data.tfstate"
    region  = "ap-southeast-2"
    encrypt = "true"
  }
}

# Remote State Locals
locals {
  elb_dns_name = data.terraform_remote_state._100beanstalk.outputs.elastic_beanstalk_environment_load_balancers[0]
}

data "aws_caller_identity" "current" {}

data "aws_elb" "elb" {
  name  = local.elb_dns_name
}

###############################################################################
# CloudFront
###############################################################################
resource "aws_cloudfront_distribution" "cloudfront_distribution" {
  origin {
    domain_name = data.aws_elb.elb.dns_name
    origin_id   = var.origin_id
    custom_origin_config {
      http_port = 80
      https_port = 443
      origin_protocol_policy = "match-viewer"
      origin_ssl_protocols   = ["TLSv1"]
    }
  }

  enabled         = true
  is_ipv6_enabled = true

  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = var.origin_id

    forwarded_values {
      query_string = true

      cookies {
        forward = "all"
      }
    }

    viewer_protocol_policy = "allow-all"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn = var.acm_certificate_arn
    ssl_support_method  = "sni-only"
    minimum_protocol_version = "TLSv1"
  }

  tags = {
    Environment = var.environment
  }
}
