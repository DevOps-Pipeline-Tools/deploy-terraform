name     = "joo"
tags     = {"owner": "joo"}

azs      = ["ap-northeast-2a", "ap-northeast-2c"]
cidr       = "10.0.0.0/16"
public_subnet_cidr      = ["10.0.0.0/24", "10.0.10.0/24"]
web_subnet_cidr      = ["10.0.20.0/24", "10.0.30.0/24"]
private_lb_subnet_cidr = ["10.0.40.0/24", "10.0.50.0/24"]
was_subnet_cidr   = ["10.0.60.0/24", "10.0.70.0/24"]
db_subnet_cidr   = ["10.0.80.0/24", "10.0.90.0/24"]

load_balancer_type = "application"
public_lb_sg_ports = {
    http  = "80"
    https = "443"
  }

private_lb_sg_ports = {
    app  = "8080"
  }

instance_type = "t3.micro"
key_name = "juiceb"
wait_for_capacity_timeout = "5m"
health_check_type = "EC2"
health_check_grace_period = 180
min_size = 2
max_size = 4
desired_capacity = 2
web_sg_ports = {
    http  = "80"
    https = "443"
  }

was_sg_ports = {
    app = "8080"
  }

db_sg_ports = {
    postgresql = "5432"
  }