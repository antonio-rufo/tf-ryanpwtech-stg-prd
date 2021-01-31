###############################################################################
# Environment
###############################################################################
aws_account_id = "162198556136"
region         = "ap-southeast-2"
environment    = "Production"

###############################################################################
# Base Network
###############################################################################
vpc_name            = "vpc-main-production"
cidr_range          = "10.0.0.0/16"
public_cidr_ranges  = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
private_cidr_ranges = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
