
#Public Subnet us-east-1a
resource "aws_subnet" "financial-management-public-us-east-1a" {
  cidr_block              = "172.31.0.0/26"
  vpc_id                  = aws_vpc.financial-management-vpc.id
  map_public_ip_on_launch = true
  availability_zone       = var.us-east-1a
  tags                    = {
    Name = "financial-management-public-1a"
  }
}

#Private Subnet us-east-1a
resource "aws_subnet" "financial-management-private-us-east-1a" {
  cidr_block              = "172.31.0.64/26"
  vpc_id                  = aws_vpc.financial-management-vpc.id
  map_public_ip_on_launch = false
  availability_zone       = var.us-east-1a
  tags                    = {
    Name = "financial-management-private-1a"
  }
}

#Public Subnet us-east-1b
resource "aws_subnet" "financial-management-public-us-east-1b" {
  cidr_block              = "172.31.0.128/26"
  vpc_id                  = aws_vpc.financial-management-vpc.id
  map_public_ip_on_launch = true
  availability_zone       = var.us-east-1b
  tags                    = {
    Name = "financial-management-public-1b"
  }
}

#Private Subnet us-east-1b
resource "aws_subnet" "financial-management-private-us-east-1b" {
  cidr_block              = "172.31.0.192/26"
  vpc_id                  = aws_vpc.financial-management-vpc.id
  map_public_ip_on_launch = false
  availability_zone       = var.us-east-1b
  tags                    = {
    Name = "financial-management-private-1b"
  }
}