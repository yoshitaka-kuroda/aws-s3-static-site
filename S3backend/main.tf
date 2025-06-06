resource "aws_s3_bucket" "tf_backend" {
  bucket = "yoshitaka-terraform-state-bucket"
  force_destroy = true
  tags = {
    Name = "Terraform Backend State"
  }
}

resource "aws_s3_bucket_versioning" "tf_backend_versioning" {
  bucket = aws_s3_bucket.tf_backend.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "tf_backend_encryption" {
  bucket = aws_s3_bucket.tf_backend.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}