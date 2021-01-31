###############################################################################
# Environment
###############################################################################
aws_account_id = "162198556136"
region         = "ap-southeast-2"
environment    = "Production"

###############################################################################
# RDS
###############################################################################
db_identifier        = "postgres-db"
db_name              = "app"
db_username          = "postgres"
db_password          = "changeme"
db_instance_class    = "db.t3.small"
db_engine            = "postgres"
db_engine_version    = "10.13"
db_allocated_storage = 50
db_multi_az          = true

###############################################################################
# S3
###############################################################################
bucket1_name          = "ryanpwtech-test-bucket1"
force_destroy_bucket1 = true
bucket2_name          = "ryanpwtech-test-bucket2"
force_destroy_bucket2 = true
