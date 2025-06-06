output "s3_bucket_name" {
  value = module.s3_static_site.bucket_name
}

output "website_endpoint" {
  value = module.s3_static_site.website_endpoint
}