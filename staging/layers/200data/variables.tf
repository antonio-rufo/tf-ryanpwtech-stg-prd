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
  default     = "Staging"
}

###############################################################################
# Variables - RDS
###############################################################################
variable "db_identifier" {
  description = "The name of the RDS instance."
}

variable "db_name" {
  description = "The name of the database to create when the DB instance is created."
}

variable "db_username" {
  description = "Username for the master DB user."
}

variable "db_password" {
  description = "Password for the master DB user."
}

variable "db_instance_class" {
  description = "The instance type of the RDS instance."
}

variable "db_engine" {
  description = "The database engine to use."
}

variable "db_engine_version" {
  description = "The engine version to use."
}

variable "db_allocated_storage" {
  description = "The amount of allocated storage."
}

variable "db_multi_az" {
  description = "Does the DB need multi-az for High Availability."
}

###############################################################################
# Variables - S3
###############################################################################
variable "bucket1_name" {
  description = "Name of the first S3 bucket to be created."
}

variable "force_destroy_bucket1" {
  description = "A boolean that indicates all objects (including any locked objects) should be deleted from the bucket so that the bucket can be destroyed without error. These objects are not recoverable."
}

variable "bucket2_name" {
  description = "Name of the second S3 bucket to be created."
}

variable "force_destroy_bucket2" {
  description = "A boolean that indicates all objects (including any locked objects) should be deleted from the bucket so that the bucket can be destroyed without error. These objects are not recoverable."
}
