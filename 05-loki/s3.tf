resource "random_string" "random" {
  length  = 16
  special = false
  lower   = true
  numeric = true
}

resource "aws_s3_bucket" "chunks" {
  bucket = "loki-chunks-${random_string.random.result}"
}

resource "aws_s3_bucket_acl" "chunks" {
  bucket = aws_s3_bucket.chunks.id
  acl    = "private"
}
