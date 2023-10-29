################################################################################
# VPC
################################################################################

resource "aws_vpc" "main" {
  count = var.create_vpc ? 1 : 0

  cidr_block = var.cidr

  tags = merge(
    { "Name" = "${var.name}-${var.vpc_tags}" }
  )
}

################################################################################
# Publiс Subnets
################################################################################

resource "aws_subnet" "public" {
  count = var.public_multi_az ? 2 : var.create_public_subnets ? 1 : 0

  vpc_id            = aws_vpc.main.id
  availability_zone = element(var.azs, count.index)
  cidr_block        = element(var.public_subnet_cidr, count.index)
  tags = merge(
    { "Name" = "${var.name}-${element(var.public_subnet_tags, count.index)}" }
  )
}

################################################################################
# WEB Subnets
################################################################################

resource "aws_subnet" "web" {
  count = var.web_multi_az ? 2 : var.create_web_subnets ? 1 : 0

  vpc_id            = aws_vpc.main.id
  availability_zone = element(var.azs, count.index)
  cidr_block        = element(var.web_subnet_cidr, count.index)

  tags = merge(
    { "Name" = "${var.name}-${element(var.web_subnet_tags, count.index)}" }
  )
}

################################################################################
# WAS Subnets
################################################################################

resource "aws_subnet" "was" {
  count = var.was_multi_az ? 2 : var.create_was_subnets ? 1 : 0

  vpc_id            = aws_vpc.main.id
  availability_zone = element(var.azs, count.index)
  cidr_block        = element(var.was_subnet_cidr, count.index)

  tags = merge(
    { "Name" = "${var.name}-${element(var.was_subnet_tags, count.index)}" }
  )
}

################################################################################
# DB Subnets
################################################################################

resource "aws_subnet" "db" {
  count = var.db_multi_az ? 2 : var.create_db_subnets ? 1 : 0

  vpc_id            = aws_vpc.main.id
  availability_zone = element(var.azs, count.index)
  cidr_block        = element(var.db_subnet_cidr, count.index)

  tags = merge(
    { "Name" = "${var.name}-${element(var.db_subnet_tags, count.index)}" }
  )
}