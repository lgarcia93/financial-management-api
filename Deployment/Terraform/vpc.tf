resource "aws_vpc" "financial-management-vpc" {
  cidr_block           = "172.31.0.0/24"
  enable_dns_support   = true #gives you an internal domain name
  enable_dns_hostnames = true #gives you an internal host name  
  instance_tenancy     = "default"

  tags = {
    Name = "financial-management-vpc"
  }
}

#Internet Gateway
resource "aws_internet_gateway" "financial-management-igw" {
  vpc_id = aws_vpc.financial-management-vpc.id
  tags   = {
    Name = "financial-management-igw"
  }
}

#Custom Route Table
resource "aws_route_table" "custom-rt" {
  vpc_id = aws_vpc.financial-management-vpc.id
  
  tags = {
    Name = "custom-financial-management-rt"
  }
}

resource "aws_route" "rt-igw-igw" {
  route_table_id = aws_route_table.custom-rt.id
  
  gateway_id = aws_internet_gateway.financial-management-igw.id
  destination_cidr_block = "0.0.0.0/0"
}
