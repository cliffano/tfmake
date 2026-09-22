resource "aws_kms_key" "example" {
  description             = "KMS key for example S3 bucket encryption"
  enable_key_rotation     = true
  deletion_window_in_days = 30
}

resource "aws_s3_bucket" "example" {
  bucket = "example-bucket"
}

resource "aws_s3_bucket_public_access_block" "example" {
  bucket = aws_s3_bucket.example.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_server_side_encryption_configuration" "example" {
  bucket = aws_s3_bucket.example.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "aws:kms"
      kms_master_key_id = aws_kms_key.example.arn
    }
    bucket_key_enabled = true
  }
}

resource "aws_s3_bucket_versioning" "example" {
  bucket = aws_s3_bucket.example.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_logging" "example" {
  bucket = aws_s3_bucket.example.id

  target_bucket = aws_s3_bucket.example_log.id
  target_prefix = "log/"
}

# example_log is the access log destination for the example bucket above.
# S3 server access logging does not support SSE-KMS destination buckets, so
# this bucket uses the default SSE-S3 (AES256) encryption instead.
resource "aws_s3_bucket" "example_log" {
  bucket = "example-bucket-log"
}

resource "aws_s3_bucket_public_access_block" "example_log" {
  bucket = aws_s3_bucket.example_log.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

#trivy:ignore:AWS-0132 S3 server access logging destination buckets don't support SSE-KMS
resource "aws_s3_bucket_server_side_encryption_configuration" "example_log" {
  bucket = aws_s3_bucket.example_log.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_versioning" "example_log" {
  bucket = aws_s3_bucket.example_log.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_logging" "example_log" {
  bucket = aws_s3_bucket.example_log.id

  target_bucket = aws_s3_bucket.example_log.id
  target_prefix = "log/"
}
