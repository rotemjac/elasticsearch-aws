resource "aws_s3_bucket" "snapshot_bucket" {
  bucket = format(var.bucket_name , var.project_name)
  force_destroy = true

  # Security
  acl = "private"
  tags = {
      "Name" = format(var.bucket_name , var.project_name),
      "Environment" = var.environment
  }
}

