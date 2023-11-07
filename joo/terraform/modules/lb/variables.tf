################################################################################
# Common
################################################################################

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

variable "tags" {
  description = "Additional information for the all resources"
  type        = map(string)
  # default     = ""
}

variable "azs" {
  description = "A list of availability zones names or ids in the region"
  type        = list(string)
  # default     = []
}

################################################################################
# Load Balancer
################################################################################

variable "load_balancer_type" {
  description = "The type of load balancer to create. Possible values are `application`, `gateway`, or `network`. The default value is `application`"
  type        = string
#  default     = "application"
}

################################################################################
# Security Group
################################################################################

variable "lb_sg_ports" {
  description = "List of allowed ports to LB Security Group"
  type        = map(any)
  # default     = {}
}

################################################################################
# Dependencies
################################################################################

variable "vpc_id" {
  description = "VPC ID of network module"
  type        = string
  # default     = ""
}