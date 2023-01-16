resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true #gives you an internal domain name
  enable_dns_hostnames = true #gives you an internal host name  
  instance_tenancy     = "default"

  tags = {
    Name = "${var.app_name}-vpc"
  }
}

#Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags   = {
    Name = "${var.app_name}-igw"
  }
}

#Custom Route Table
resource "aws_route_table" "custom-rt" {
  vpc_id = aws_vpc.vpc.id
  
  tags = {
    Name = "custom-${var.app_name}-rt"
  }
}

resource "aws_route" "rt-igw-igw" {
  route_table_id = aws_route_table.custom-rt.id
  
  gateway_id = aws_internet_gateway.igw.id
  destination_cidr_block = var.cidr_everywhere
}
