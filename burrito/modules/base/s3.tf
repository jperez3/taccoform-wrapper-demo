resource "random_pet" "burrito" {
}

resource "aws_s3_bucket" "burrito" {
  bucket = local.bucket_name

  tags = {
    Name        = local.bucket_name
    Environment = var.env
  }
}

resource "aws_s3_bucket_acl" "burrito" {
  bucket = aws_s3_bucket.burrito.id
  acl    = "private"
}

resource "aws_s3_bucket_public_access_block" "burrito" {
  bucket = aws_s3_bucket.burrito.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
