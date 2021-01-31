###############################################################################
# Elastic Beanstalk Output
###############################################################################
output "elastic_beanstalk_application_name" {
  value       = module.elastic_beanstalk_application.elastic_beanstalk_application_name
  description = "Elastic Beanstalk Application name"
}

output "elastic_beanstalk_environment_hostname" {
  value       = module.elastic_beanstalk_environment.hostname
  description = "DNS hostname"
}

output "elastic_beanstalk_environment_id" {
  description = "ID of the Elastic Beanstalk environment"
  value       = module.elastic_beanstalk_environment.id
}

output "elastic_beanstalk_environment_name" {
  value       = module.elastic_beanstalk_environment.name
  description = "Elastic Beanstalk Environment Name"
}

output "elastic_beanstalk_environment_security_group_id" {
  value       = module.elastic_beanstalk_environment.security_group_id
  description = "Security group id"
}

output "elastic_beanstalk_environment_elb_zone_id" {
  value       = module.elastic_beanstalk_environment.elb_zone_id
  description = "ELB zone id"
}

output "elastic_beanstalk_environment_application" {
  description = "The Elastic Beanstalk Application specified for this environment"
  value       = module.elastic_beanstalk_environment.application
}

output "elastic_beanstalk_environment_endpoint" {
  description = "Fully qualified DNS name for the environment"
  value       = module.elastic_beanstalk_environment.endpoint
}

output "elastic_beanstalk_environment_load_balancers" {
  description = "Elastic Load Balancers in use by this environment"
  value       = module.elastic_beanstalk_environment.load_balancers
}
