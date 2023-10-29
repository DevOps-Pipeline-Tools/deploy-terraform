locals {
  aws_region   = "ap-northeast-2"
  # aws_assume_role = "arn:aws:iam::458197257493:policy/terragrunt-backend"
}

# Terraform Block
terraform {
  source = "./modules/network"
}

# Generate Block
generate "provider" {
  path = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
provider "aws" {
  region = "${local.aws_region}"
}
EOF
}

remote_state {
  backend = "s3"
  config = {
    encrypt        = true
    bucket         = "github-actions-juiceb"
    key            = "joo/dev/terraform.tfstate"
    region         = local.aws_region
    dynamodb_table = "tf-backend"
  }
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
}

# Inputs Block
inputs = {
  ################################################################################
  # VPC
  ################################################################################
  vpc_tags = "vpc"
  name = "dev"
  azs  = ["ap-northeast-2a", "ap-northeast-2c"]
  cidr = "10.0.0.0/16"

  ################################################################################
  # Public Subnets
  ################################################################################
  create_public_subnet = true
  public_multi_az = false
  public_subnet_cidr = ["10.0.0.0/24", "10.0.10.0/24"]
  public_subnet_tags = ["ap-northeast-2a-public-subnet", "ap-northeast-2c-public-subnet"]

  ################################################################################
  # WEB Subnets
  ################################################################################
  create_web_subnet = true
  web_multi_az = false
  web_subnet_cidr = ["10.0.20.0/24", "10.0.30.0/24"]
  web_subnet_tags = ["ap-northeast-2a-web-subnet", "ap-northeast-2c-web-subnet"]

  ################################################################################
  # WAS Subnets
  ################################################################################
  create_was_subnet = true
  was_multi_az = false
  was_subnet_cidr = ["10.0.40.0/24", "10.0.50.0/24"]
  was_subnet_tags = ["ap-northeast-2a-was-subnet", "ap-northeast-2c-was-subnet"]
  
  ################################################################################
  # DB Subnets
  ################################################################################
  create_db_subnet = true
  db_multi_az = false
  db_subnet_cidr = ["10.0.60.0/24", "10.0.70.0/24"]
  db_subnet_tags = ["ap-northeast-2a-db-subnet", "ap-northeast-2c-db-subnet"]
}