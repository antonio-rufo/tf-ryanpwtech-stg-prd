###############################################################################
# Variables - Environment
###############################################################################
variable "aws_account_id" {
  description = "AWS Account ID."
}

variable "region" {
  description = "Default Region."
  default     = "ap-southeast-2"
}

variable "environment" {
  description = "Name of the environment for the deployment, e.g. Integration, PreProduction, Production, QA, Staging, Test."
  default     = "Production"
}

###############################################################################
# Variables - CloudFront
###############################################################################
variable "origin_id" {
  description = "A unique identifier for the origin."
}

variable "acm_certificate_arn" {
  description = "SSL certificate ARN. The certificate must be present in AWS Certificate Manager."
}
