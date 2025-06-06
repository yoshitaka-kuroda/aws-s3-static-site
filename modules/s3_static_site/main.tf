resource "aws_s3_bucket" "this" {
  bucket = var.bucket_name
  force_destroy = true
  website {
    index_document = "index.html"
    error_document = "error.html"
  }
  tags = { "Project" = "static-site" }
}
