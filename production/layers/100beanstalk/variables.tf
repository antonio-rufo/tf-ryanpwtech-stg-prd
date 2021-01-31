###############################################################################
# Variables - Environment
###############################################################################
variable "aws_account_id" {
  description = "AWS Account ID"
}

variable "region" {
  description = "Default Region"
  default     = "ap-southeast-2"
}

variable "environment" {
  description = "Name of the environment for the deployment, e.g. Integration, PreProduction, Production, QA, Staging, Test"
  default     = "Staging"
}

###############################################################################
# Variables - Elastic Beanstalk
###############################################################################
variable "stage" {
  description = "Stage, e.g. 'prod', 'staging', 'dev', OR 'source', 'build', 'test', 'deploy', 'release'."
}

variable "name" {
  description = "Solution name, e.g. 'app' or 'jenkins'."
}

variable "description" {
  description = "Short description of the Environment."
}

variable "solution_stack_name" {
  description = "Elastic Beanstalk stack, e.g. Docker, Go, Node, Java, IIS. For more info, see https://docs.aws.amazon.com/elasticbeanstalk/latest/platforms/platforms-supported.html."
}

variable "loadbalancer_type" {
  description = "Load Balancer type, e.g. 'application' or 'classic'."
}

variable "updating_max_batch" {
  description = "Maximum number of instances to update at once."
}

variable "updating_min_in_service" {
  description = "Minimum number of instances in service during update."
}

variable "autoscale_max" {
  description = "Maximum instances to launch."
}

variable "autoscale_min" {
  description = "Minumum instances to launch."
}

variable "instance_type" {
  description = "EC2 Instances type."
}

variable "acm_certificate_arn" {
  description = "Load Balancer SSL certificate ARN. The certificate must be present in AWS Certificate Manager."
}
