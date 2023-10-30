################################################################################
# VPC
################################################################################

output "vpc_id" {
  description = "The ID of the VPC"
  value       = try(aws_vpc.main[0].id, null)
}

output "vpc_arn" {
  description = "The ARN of the VPC"
  value       = try(aws_vpc.main[0].arn, null)
}

output "vpc_cidr_block" {
  description = "The CIDR block of the VPC"
  value       = try(aws_vpc.main[0].cidr_block, null)
}

output "vpc_owner_id" {
  description = "The ID of the AWS account that owns the VPC"
  value       = try(aws_vpc.main[0].owner_id, null)
}

################################################################################
# Publiс Subnets
################################################################################

output "public_subnets" {
  description = "List of IDs of public subnets"
  value       = aws_subnet.public[*].id
}

output "public_subnet_arns" {
  description = "List of ARNs of public subnets"
  value       = aws_subnet.public[*].arn
}

output "public_subnets_cidr_blocks" {
  description = "List of cidr_blocks of public subnets"
  value       = compact(aws_subnet.public[*].cidr_block)
}

################################################################################
# WEB Subnets
################################################################################

output "web_subnets" {
  description = "List of IDs of WEB subnets"
  value       = aws_subnet.web[*].id
}

output "web_subnet_arns" {
  description = "List of ARNs of WEB subnets"
  value       = aws_subnet.web[*].arn
}

output "web_subnets_cidr_blocks" {
  description = "List of cidr_blocks of WEB subnets"
  value       = compact(aws_subnet.web[*].cidr_block)
}

################################################################################
# WAS Subnets
################################################################################

output "was_subnets" {
  description = "List of IDs of WAS subnets"
  value       = aws_subnet.was[*].id
}

output "was_subnet_arns" {
  description = "List of ARNs of WAS subnets"
  value       = aws_subnet.was[*].arn
}

output "was_subnets_cidr_blocks" {
  description = "List of cidr_blocks of WAS subnets"
  value       = compact(aws_subnet.was[*].cidr_block)
}

################################################################################
# DB Subnets
################################################################################

output "db_subnets" {
  description = "List of IDs of DB subnets"
  value       = aws_subnet.db[*].id
}

output "db_subnet_arns" {
  description = "List of ARNs of DB subnets"
  value       = aws_subnet.db[*].arn
}

output "db_subnets_cidr_blocks" {
  description = "List of cidr_blocks of DB subnets"
  value       = compact(aws_subnet.db[*].cidr_block)
}

################################################################################
# Static values (arguments)
################################################################################

output "azs" {
  description = "A list of availability zones specified as argument to this module"
  value       = var.azs
}

output "name" {
  description = "The name of the VPC specified as argument to this module"
  value       = var.name
}