terraform {
  source = "../../modules/network"
}

inputs = {
  
  ################################################################################
  # VPC
  ################################################################################
  create_vpc = true
  multi_az = true
  vpc_tags = "vpc"
  name = "prod"
  azs  = ["ap-northeast-2a", "ap-northeast-2c"]
  cidr = "192.168.0.0/16"

  ################################################################################
  # Public Subnets
  ################################################################################
  create_public_subnet = true
  public_subnet_cidr = ["192.168.0.0/24", "192.168.10.0/24"]
  public_subnet_tags = ["ap-northeast-2a-public-subnet", "ap-northeast-2c-public-subnet"]

  ################################################################################
  # WEB Subnets
  ################################################################################
  create_web_subnet = true
  web_subnet_cidr = ["192.168.20.0/24", "192.168.30.0/24"]
  web_subnet_tags = ["ap-northeast-2a-web-subnet", "ap-northeast-2c-web-subnet"]

  ################################################################################
  # WAS Subnets
  ################################################################################
  create_was_subnet = true
  was_subnet_cidr = ["192.168.40.0/24", "192.168.50.0/24"]
  was_subnet_tags = ["ap-northeast-2a-was-subnet", "ap-northeast-2c-was-subnet"]
  
  ################################################################################
  # DB Subnets
  ################################################################################
  create_db_subnet = true
  db_subnet_cidr = ["192.168.60.0/24", "192.168.70.0/24"]
  db_subnet_tags = ["ap-northeast-2a-db-subnet", "ap-northeast-2c-db-subnet"]
}