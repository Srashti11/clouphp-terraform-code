

# VPC
resource "aws_vpc" "cloudphp_staging_vpc" {
  cidr_block = var.vpc_cidr
}

# Public Subnets
resource "aws_subnet" "pub_sub_1" {
  vpc_id            = aws_vpc.cloudphp_staging_vpc.id
  cidr_block        = var.public_subnet_1_cidr
  availability_zone = var.availability_zone_1
}

resource "aws_subnet" "pub_sub_2" {
  vpc_id            = aws_vpc.cloudphp_staging_vpc.id
  cidr_block        = var.public_subnet_2_cidr
  availability_zone = var.availability_zone_2
}

# Private Subnets
resource "aws_subnet" "private_sub_1" {
  vpc_id            = aws_vpc.cloudphp_staging_vpc.id
  cidr_block        = var.private_subnet_1_cidr
  availability_zone = var.availability_zone_1
}

resource "aws_subnet" "private_sub_2" {
  vpc_id            = aws_vpc.cloudphp_staging_vpc.id
  cidr_block        = var.private_subnet_2_cidr
  availability_zone = var.availability_zone_2
}

# Internet Gateway
resource "aws_internet_gateway" "IGW" {
  vpc_id = aws_vpc.cloudphp_staging_vpc.id
}

# Elastic IP for NAT Gateway
resource "aws_eip" "my_eip" {
  domain = "vpc"
}

# NAT Gateway
resource "aws_nat_gateway" "NGW" {
  allocation_id = aws_eip.my_eip.id
  subnet_id     = aws_subnet.pub_sub_1.id
}

# Public Route Table
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.cloudphp_staging_vpc.id
}

resource "aws_route" "public_route" {
  route_table_id         = aws_route_table.public_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.IGW.id
}

resource "aws_route_table_association" "asso_pub_sub_1" {
  subnet_id      = aws_subnet.pub_sub_1.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "asso_pub_sub_2" {
  subnet_id      = aws_subnet.pub_sub_2.id
  route_table_id = aws_route_table.public_route_table.id
}

# Private Route Table
resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.cloudphp_staging_vpc.id
}

resource "aws_route" "private_route" {
  route_table_id         = aws_route_table.private_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.NGW.id
}

resource "aws_route_table_association" "asso_private_sub_1" {
  subnet_id      = aws_subnet.private_sub_1.id
  route_table_id = aws_route_table.private_route_table.id
}

resource "aws_route_table_association" "asso_private_sub_2" {
  subnet_id      = aws_subnet.private_sub_2.id
  route_table_id = aws_route_table.private_route_table.id
}
