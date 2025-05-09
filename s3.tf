resource "aws_s3_bucket" "tadka_twist_bucket" {
  bucket = "tadka-twist-app-${random_id.bucket_id.hex}" # ensures unique bucket name

  tags = {
    Name        = "tadka-twist-s3"
    Environment = "production"
  }
}

# Random suffix for uniqueness
resource "random_id" "bucket_id" {
  byte_length = 4
}

# Optional: Block public access (recommended for app data)
resource "aws_s3_bucket_public_access_block" "tadka_twist_block_public" {
  bucket = aws_s3_bucket.tadka_twist_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
