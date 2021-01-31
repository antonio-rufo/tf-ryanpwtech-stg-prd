# 100beanstalk Layer
###############################################################################
# Terraform main config
###############################################################################

### PLEASE UPDATE BACKEND BUCKET NAME AND REGION

terraform {
  required_version = ">= 0.14"
  required_providers {
    aws = "~> 3.6.0"
  }

  backend "s3" {
    bucket  = "162198556136-build-state-bucket-production"
    key     = "terraform.production.100beanstalk.tfstate"
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
    bucket  = "162198556136-build-state-bucket-production"
    key     = "terraform.production.000base.tfstate"
    region  = "ap-southeast-2"
    encrypt = "true"
  }
}

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
# Remote State Locals
###############################################################################
locals {
  vpc_id          = data.terraform_remote_state._000base.outputs.vpc_id
  private_subnets = data.terraform_remote_state._000base.outputs.private_subnets
  public_subnets  = data.terraform_remote_state._000base.outputs.public_subnets
}

###############################################################################
# Elastic Beanstalk
###############################################################################
module "elastic_beanstalk_application" {
  source      = "../../modules/terraform-aws-elastic-beanstalk-application"
  stage       = var.stage
  name        = var.name
  description = var.description
}

module "elastic_beanstalk_environment" {
  source = "../../modules/terraform-aws-elastic-beanstalk-environment"

  stage                              = var.stage
  name                               = var.name
  description                        = var.description
  region                             = var.region
  availability_zone_selector         = "Any 3"
  elastic_beanstalk_application_name = module.elastic_beanstalk_application.elastic_beanstalk_application_name

  instance_type           = var.instance_type
  autoscale_min           = var.autoscale_min
  autoscale_max           = var.autoscale_max
  updating_min_in_service = var.updating_min_in_service
  updating_max_batch      = var.updating_max_batch

  loadbalancer_type       = var.loadbalancer_type
  force_destroy           = true
  vpc_id                  = local.vpc_id
  loadbalancer_subnets    = local.public_subnets
  application_subnets     = local.private_subnets

  enhanced_reporting_enabled = true
  managed_actions_enabled    = false

  // https://docs.aws.amazon.com/elasticbeanstalk/latest/platforms/platforms-supported.html
  // https://docs.aws.amazon.com/elasticbeanstalk/latest/platforms/platforms-supported.html#platforms-supported.docker
  solution_stack_name = var.solution_stack_name
  loadbalancer_certificate_arn = var.acm_certificate_arn

  # additional_settings = [
  #   {
  #     namespace = "aws:elasticbeanstalk:application:environment"
  #     name      = "DB_HOST"
  #     value     = "xxxxxxxxxxxxxx"
  #   },
  #   {
  #     namespace = "aws:elasticbeanstalk:application:environment"
  #     name      = "DB_USERNAME"
  #     value     = "yyyyyyyyyyyyy"
  #   },
  #   {
  #     namespace = "aws:elasticbeanstalk:application:environment"
  #     name      = "DB_PASSWORD"
  #     value     = "zzzzzzzzzzzzzzzzzzz"
  #   },
  #   {
  #     namespace = "aws:elasticbeanstalk:application:environment"
  #     name      = "ANOTHER_ENV_VAR"
  #     value     = "123456789"
  #   }
  # ]
}
