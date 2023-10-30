generate "backend" {
  path = "s3-backend.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
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

# Path_relative_to_include(): This function returns the relative path between the current terragrunt.hcl file and the path specified in its include block. We typically use this in a root terragrunt.hcl file so that each Terraform child module stores its Terraform state at a different key.
# remote_state {
#   backend = "s3"
#   generate = {
#     path      = "backend.tf"
#     if_exists = "overwrite_terragrunt"
#   }
#   config = {
#     bucket = "github-actions-juiceb"

#     key = "joo/${path_relative_to_include()}/terraform.tfstate"
#     region         = "ap-northeast-2"
#     encrypt        = true
#     dynamodb_table = "tf-backend"
#   }
# }