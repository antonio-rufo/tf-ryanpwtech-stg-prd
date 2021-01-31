###############################################################################
# Environment
###############################################################################
aws_account_id = "162198556136"
region         = "ap-southeast-2"
environment    = "Staging"

###############################################################################
# Elastic Beanstalk
###############################################################################
stage                   = "staging"
name                    = "chatapp"
description             = "Test elastic_beanstalk_environment"
instance_type           = "t3.small"
autoscale_min           = 1
autoscale_max           = 3
updating_min_in_service = 1
updating_max_batch      = 1
loadbalancer_type       = "classic"
solution_stack_name     = "64bit Amazon Linux 2018.03 v2.12.2 running Ruby 2.6 (Puma)"
acm_certificate_arn     = "arn:aws:acm:ap-southeast-2:162198556136:certificate/XXXXXXXXXXXXXX"
