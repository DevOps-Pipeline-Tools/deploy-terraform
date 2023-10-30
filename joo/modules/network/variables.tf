################################################################################
# VPC
################################################################################

variable "create_vpc" {
  description = "Controls if VPC should be created"
  type        = bool
  # default     = true
}

variable "multi_az" {
  description = "Settings for HA"
  type        = bool
  # default     = true
}

variable "name" {
  description = "Name to be used on all the resources as identifier"
  type        = string
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

variable "vpc_tags" {
  description = "Additional information for the VPC"
  type        = string
  # default     = ""
}


################################################################################
# Public Subnets
################################################################################

variable "public_subnet_cidr" {
  description = "The IPv4 CIDR block for the Public Subnets"
  type        = list(string)
  # default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "public_subnet_tags" {
  description = "Additional information for the Public Subnets"
  type        = list(string)
  # default = ["ap-northeast-2a-public-subnet", "ap-northeast-2c-public-subnet"]
}

################################################################################
# WEB Subnets
################################################################################

variable "web_subnet_cidr" {
  description = "The IPv4 CIDR block for the WEB Subnets"
  type        = list(string)
  # default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "web_subnet_tags" {
  description = "Additional information for the WEB Subnets"
  type        = list(string)
  # default = ["ap-northeast-2a-public-subnet", "ap-northeast-2c-public-subnet"]
}

################################################################################
# WAS Subnets
################################################################################

variable "was_subnet_cidr" {
  description = "The IPv4 CIDR block for the WAS Subnets"
  type        = list(string)
  # default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "was_subnet_tags" {
  description = "Additional information for the WAS Subnets"
  type        = list(string)
  # default = ["ap-northeast-2a-public-subnet", "ap-northeast-2c-public-subnet"]
}

################################################################################
# DB Subnets
################################################################################

variable "db_subnet_cidr" {
  description = "The IPv4 CIDR block for the DB Subnets"
  type        = list(string)
  # default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "db_subnet_tags" {
  description = "Additional information for the DB Subnets"
  type        = list(string)
  # default = ["ap-northeast-2a-public-subnet", "ap-northeast-2c-public-subnet"]
}

