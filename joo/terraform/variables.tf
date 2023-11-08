variable "name" {
  description = "Name to be used on all the resources as identifier"
  type        = string
  # default     = ""
}

variable "tags" {
  description = "Additional information for the all resources"
  type        = map(string)
  # default     = ""
}

variable "cidr" {
  description = "The IPv4 CIDR block for the VPC"
  type        = string
  # default     = "10.0.0.0/16"
}

variable "azs" {
  description = "A list of availability zones names or ids in the region"
  type        = list(string)
  # default     = []
}

variable "public_subnet_cidr" {
  description = "The IPv4 CIDR block for the Public Subnets"
  type        = list(string)
  # default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "web_subnet_cidr" {
  description = "The IPv4 CIDR block for the WEB Subnets"
  type        = list(string)
  # default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_lb_subnet_cidr" {
  description = "The IPv4 CIDR block for the Private LB Subnets"
  type        = list(string)
  # default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "was_subnet_cidr" {
  description = "The IPv4 CIDR block for the WAS Subnets"
  type        = list(string)
  # default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "db_subnet_cidr" {
  description = "The IPv4 CIDR block for the DB Subnets"
  type        = list(string)
  # default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "load_balancer_type" {
  description = "The type of load balancer to create. Possible values are `application`, `gateway`, or `network`. The default value is `application`"
  type        = string
#  default     = "application"
}

variable "certificate_arn" {
  description = "ARN of certificate for LB"
  type        = string
  # default     = ""
}

variable "public_lb_sg_ports" {
  description = "List of allowed ports to Public LB Security Group"
  type        = map(any)
  # default     = {}
}

variable "private_lb_sg_ports" {
  description = "List of allowed ports to Private LB Security Group"
  type        = map(any)
  # default     = {}
}

variable "public_zone_id" {
  description = "The zone_id of the Public Route 53 Zone to assist with creating DNS records"
  type        = string
  # default     = ""
}

variable "instance_type" {
  description = "The type of the instance"
  type        = string
  # default     = ""
}

variable "key_name" {
  description = "The key name that should be used for the instance"
  type        = string
  # default     = null
}

variable "wait_for_capacity_timeout" {
  description = "A maximum duration that Terraform should wait for ASG instances to be healthy before timing out. (See also Waiting for Capacity below.) Setting this to '0' causes Terraform to skip all Capacity Waiting behavior."
  type        = string
  # default     = null
}

variable "health_check_type" {
  description = "`EC2` or `ELB`. Controls how health checking is done"
  type        = string
  # default     = null
}

variable "health_check_grace_period" {
  description = "Time (in seconds) after instance comes into service before checking health"
  type        = number
  # default     = null
}

variable "web_sg_ports" {
  description = "List of allowed ports to WEB Security Group"
  type        = map(any)
  # default     = {}
}

variable "was_sg_ports" {
  description = "List of allowed ports to WAS Security Group"
  type        = map(any)
  # default     = {}
}

variable "db_sg_ports" {
  description = "List of allowed ports to DB Security Group"
  type        = map(any)
  # default     = {}
}