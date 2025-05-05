resource "aws_s3_bucket" "tadkatwist_images" {
  bucket = "tadkatwist-images-bucket"
  acl    = "private"

  tags = {
    Name        = "Tadka Twist Image Storage"
    Environment = "prod"
  }
}
