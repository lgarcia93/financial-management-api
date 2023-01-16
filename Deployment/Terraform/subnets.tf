
#Public Subnet us-east-1a
resource "aws_subnet" "public-us-east-1a" {
  cidr_block              = var.subnet_public_us_east_1a_cidr
  vpc_id                  = aws_vpc.vpc.id
  map_public_ip_on_launch = true
  availability_zone       = var.us-east-1a
  tags                    = {
    Name = "${var.app_name}-public-1a"
  }
}

#Private Subnet us-east-1a
resource "aws_subnet" "private-us-east-1a" {
  cidr_block              = var.subnet_private_us_east_1a_cidr
  vpc_id                  = aws_vpc.vpc.id
  map_public_ip_on_launch = false
  availability_zone       = var.us-east-1a
  tags                    = {
    Name = "${var.app_name}-private-1a"
  }
}

#Public Subnet us-east-1b
resource "aws_subnet" "public-us-east-1b" {
  cidr_block              = var.subnet_public_us_east_1b_cidr
  vpc_id                  = aws_vpc.vpc.id
  map_public_ip_on_launch = true
  availability_zone       = var.us-east-1b
  tags                    = {
    Name = "${var.app_name}-public-1b"
  }
}

#Private Subnet us-east-1b
resource "aws_subnet" "private-us-east-1b" {
  cidr_block              = var.subnet_private_us_east_1b_cidr
  vpc_id                  = aws_vpc.vpc.id
  map_public_ip_on_launch = false
  availability_zone       = var.us-east-1b
  tags                    = {
    Name = "${var.app_name}-private-1b"
  }
}