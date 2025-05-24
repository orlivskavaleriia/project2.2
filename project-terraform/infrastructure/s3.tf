# Створення S3 bucket для статичного сайту
resource "aws_s3_bucket" "static_site" {
  bucket         = "glovo-static-site-bckt"
  force_destroy  = true

  tags = {
    Name        = "StaticSiteBucket"
    Environment = "Dev"
  }
}

# Дозвіл на публічний доступ (вимкнення Block Public Access)
resource "aws_s3_bucket_public_access_block" "static_site" {
  bucket = aws_s3_bucket.static_site.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

# Налаштування політики доступу до об'єктів в бакеті
resource "aws_s3_bucket_policy" "public_read" {
  bucket = aws_s3_bucket.static_site.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicReadGetObject"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.static_site.arn}/*"
      }
    ]
  })
}
