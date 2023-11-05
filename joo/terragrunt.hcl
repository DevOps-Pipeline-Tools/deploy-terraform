generate "backend" {
  path      = "s3-backend.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
terraform {
    backend "s3" {
        bucket  = "github-actions-juiceb"
        key     = "joo/${path_relative_to_include()}/terraform.tfstate"
        region  = "ap-northeast-2"
        encrypt = true
        dynamodb_table = "terragrunt-lock"
    }
}
EOF
}