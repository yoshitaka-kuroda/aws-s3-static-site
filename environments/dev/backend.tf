terraform {
  backend "s3" {
    bucket = "yoshitaka-terraform-state-bucket"       # 既に作成済みのバケット名
    key    = "ml-terraform-project/dev/terraform.tfstate"
    region = "ap-northeast-1"
  }
}
