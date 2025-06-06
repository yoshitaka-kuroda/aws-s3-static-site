output "bucket_name" { value = aws_s3_bucket.this.bucket }

output "website_endpoint" {
  value = aws_s3_bucket_website_configuration.this.website_endpoint
  description = "S3静的ウェブサイトのエンドポイントURL"
}