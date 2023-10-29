resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr
  enable_dns_hostnames = true

  tags = {
    Name = "vpc"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  
  depends_on = [ aws_vpc.vpc ]
  
  tags = {
    Name = "igw"
  }
}