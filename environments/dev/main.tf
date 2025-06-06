module "s3_static_site" {
  source      = "../../modules/s3_static_site"
  bucket_name = "yoshitaka-static-site-demo-bucket" # お好みで変更OK
}
