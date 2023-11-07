terraform {
    backend "s3" {
        bucket  = "github-actions-juiceb"
        key     = "joo/github-actions-docker/terraform.tfstate"
        region  = "ap-northeast-2"
        encrypt = true
        dynamodb_table = "terragrunt-lock"
    }
}

module "network" {
  source = "./modules/network"

  multi_az = var.multi_az
  name     = var.name
  tags     = var.tags
  azs      = var.azs
  cidr       = var.cidr
  public_subnet_cidr      = var.public_subnet_cidr
  web_subnet_cidr      = var.web_subnet_cidr
  was_subnet_cidr   = var.was_subnet_cidr
  db_subnet_cidr   = var.db_subnet_cidr
}

output "vpc_id" {
  value = module.network.vpc_id
}

module "lb" {
  source = "./modules/lb"

  multi_az = var.multi_az
  name     = var.name
  tags     = var.tags
  azs      = var.azs
  load_balancer_type = var.load_balancer_type
  vpc_id = module.network.vpc_id
  lb_sg_ports = var.lb_sg_ports
}

output "lb_sg_id" {
  value = module.lb.security_group_id
}

output "vpc_zone_identifier" {
  value = module.network.web_subnets
}

module "web" {
  source = "./modules/web"

  multi_az = var.multi_az
  name     = var.name
  tags     = var.tags
  instance_type = var.instance_type
  key_name = var.key_name
  vpc_zone_identifier = module.network.web_subnets
  wait_for_capacity_timeout = var.wait_for_capacity_timeout
  health_check_type = var.health_check_type
  health_check_grace_period = var.health_check_grace_period
  web_sg_ports = var.web_sg_ports
  lb_sg_id = module.lb.security_group_id
  vpc_id = module.network.vpc_id
}

output "web_sg_id" {
  value = module.web.security_group_id
}

module "was" {
  source = "./modules/was"

  multi_az = var.multi_az
  name     = var.name
  tags     = var.tags
  instance_type = var.instance_type
  key_name = var.key_name
  vpc_zone_identifier = module.network.web_subnets
  wait_for_capacity_timeout = var.wait_for_capacity_timeout
  health_check_type = var.health_check_type
  health_check_grace_period = var.health_check_grace_period
  was_sg_ports = var.was_sg_ports
  web_sg_id = module.web.security_group_id
  vpc_id = module.network.vpc_id
}

output "was_sg_id" {
  value = module.was.security_group_id
}

module "db" {
  source = "./modules/db"
  
  multi_az = var.multi_az
  name     = var.name
  tags     = var.tags
  instance_type = var.instance_type
  key_name = var.key_name
  vpc_zone_identifier = module.network.web_subnets
  wait_for_capacity_timeout = var.wait_for_capacity_timeout
  health_check_type = var.health_check_type
  health_check_grace_period = var.health_check_grace_period
  db_sg_ports = var.db_sg_ports
  was_sg_id = module.was.security_group_id
  vpc_id = module.network.vpc_id
}