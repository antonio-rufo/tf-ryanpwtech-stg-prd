# 200data Layer
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
    key     = "terraform.production.200data.tfstate"
    region  = "ap-southeast-2"
    encrypt = "true"
  }
}

###############################################################################
# Terraform Remote State - 000base
###############################################################################

### PLEASE UPDATE BACKEND BUCKET NAME AND REGION

data "terraform_remote_state" "_000base" {
  backend = "s3"

  config = {
    bucket  = "162198556136-build-state-bucket-production"
    key     = "terraform.production.000base.tfstate"
    region  = "ap-southeast-2"
    encrypt = "true"
  }
}

data "terraform_remote_state" "_100beanstalk" {
  backend = "s3"

  config = {
    bucket  = "162198556136-build-state-bucket-production"
    key     = "terraform.production.100beanstalk.tfstate"
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
  beanstalk_sg_id = data.terraform_remote_state._100beanstalk.outputs.elastic_beanstalk_environment_security_group_id
}

data "aws_caller_identity" "current" {}

###############################################################################
# Security Groups
###############################################################################
resource "aws_security_group" "postgres_security_group" {
  name_prefix = "postgres-sg-"
  description = "Allow Postgres access from EC2"
  vpc_id      = local.vpc_id

  tags = merge(
    local.tags,
    map("Name", "postgres-sg")
  )

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group_rule" "postgres_sg_egress_all" {
  type              = "egress"
  from_port         = 0
  to_port           = 65535
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.postgres_security_group.id
}

resource "aws_security_group_rule" "rds_ingress_tcp_5432_ec2_sg" {
  type                     = "ingress"
  from_port                = 5432
  to_port                  = 5432
  protocol                 = "tcp"
  source_security_group_id = local.beanstalk_sg_id
  security_group_id        = aws_security_group.postgres_security_group.id
  description              = "Allow Elastic Beanstalk to access RDS (TCP:5432)"
}

###############################################################################
# RDS
###############################################################################
resource "aws_db_instance" "postgresdb" {
  identifier = var.db_identifier
  name       = var.db_name
  username   = var.db_username
  password   = var.db_password

  db_subnet_group_name   = aws_db_subnet_group.subnet_group.id
  vpc_security_group_ids = [aws_security_group.postgres_security_group.id]
  instance_class         = var.db_instance_class
  engine                 = var.db_engine
  engine_version         = var.db_engine_version
  storage_type           = "gp2"
  allocated_storage      = var.db_allocated_storage

  backup_retention_period = 7
  storage_encrypted       = true
  multi_az                = var.db_multi_az
  skip_final_snapshot     = true
  tags                    = local.tags
}

resource "aws_db_subnet_group" "subnet_group" {
  name        = "subnet_group"
  description = "Subnet Group for the PostgresDB"

  subnet_ids = [local.private_subnets[0], local.private_subnets[1], local.private_subnets[2]]
}

###############################################################################
# S3 Buckets
###############################################################################
resource "aws_s3_bucket" "bucket1" {
  bucket        = var.bucket1_name
  acl           = "private"
  force_destroy = var.force_destroy_bucket1
  tags          = local.tags

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_s3_bucket" "bucket2" {
  bucket        = var.bucket2_name
  acl           = "private"
  force_destroy = var.force_destroy_bucket2
  tags          = local.tags

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}
