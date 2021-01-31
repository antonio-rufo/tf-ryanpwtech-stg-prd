###############################################################################
# RDS Output
###############################################################################
output "rds_address" {
  description = "The hostname of the RDS instance."
  value       = aws_db_instance.postgresdb.address
}

output "rds_sg_id" {
  description = "The RDS security group."
  value       = aws_security_group.postgres_security_group.id
}

###############################################################################
# S3 Bucket IDs
###############################################################################
output "bucket1_id" {
  description = "The Id of the first bucket."
  value       = aws_s3_bucket.bucket1.id
}

output "bucket2_id" {
  description = "The Id of the second bucket."
  value       = aws_s3_bucket.bucket2.id
}
