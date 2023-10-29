terraform {
  backend "s3" {
    bucket  = "github-actions-juiceb"
    key     = "joo/terraform.tfstate"
    region  = "ap-northeast-2"
    encrypt = true

    dynamodb_table = "tf-backend"
  }
}