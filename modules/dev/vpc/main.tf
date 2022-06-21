resource "aws_vpc" "vpc-dev" {
  cidr_block       = var.dev_vpc_cidr
  instance_tenancy = "default"
  tags = {
    Name = "vpc-dev"
  }
}

# Create Internet Gateway and attach it to VPC
resource "aws_internet_gateway" "igw-dev" {
  vpc_id = aws_vpc.vpc-dev.id
  tags = {
    Name = "igw-dev"
  }
}

# Create a Public Subnets
resource "aws_subnet" "public-subnet-1" {
  vpc_id     = aws_vpc.vpc-dev.id
  cidr_block = var.public_subnet_1_cidr
  tags = {
    Name = "vpc-dev-public-subnet-1"
  }
}
resource "aws_subnet" "public-subnet-2" {
  vpc_id     = aws_vpc.vpc-dev.id
  cidr_block = var.public_subnet_2_cidr
  tags = {
    Name = "vpc-dev-public-subnet-2"
  }
}

# Create a Private Subnets
resource "aws_subnet" "private-subnet-1" {
  vpc_id     = aws_vpc.vpc-dev.id
  cidr_block = var.private_subnet_1_cidr
  tags = {
    Name = "vpc-dev-private-subnet-1"
  }
}
resource "aws_subnet" "private-subnet-2" {
  vpc_id     = aws_vpc.vpc-dev.id
  cidr_block = var.private_subnet_2_cidr
  tags = {
    Name = "vpc-dev-private-subnet-2"
  }
}

# Route table for Public Subnets
# resource "aws_route_table" "PublicRT" {
#   vpc_id = aws_vpc.vpc-dev.id
#   route {
#     cidr_block = "0.0.0.0/0"
#     gateway_id = aws_internet_gateway.IGW.id
#   }
# }

# # Route table for Private Subnets
# resource "aws_route_table" "PrivateRT" { # Creating RT for Private Subnet
#   vpc_id = aws_vpc.Main.id
#   route {
#     cidr_block     = "0.0.0.0/0"
#     nat_gateway_id = aws_nat_gateway.NATgw.id
#   }
# }

# # Route table Association with Public Subnets
# resource "aws_route_table_association" "PublicRTassociation" {
#   subnet_id      = aws_subnet.publicsubnets.id
#   route_table_id = aws_route_table.PublicRT.id
# }

# # Route table Association with Private Subnets
# resource "aws_route_table_association" "PrivateRTassociation" {
#   subnet_id      = aws_subnet.privatesubnets.id
#   route_table_id = aws_route_table.PrivateRT.id
# }

# resource "aws_eip" "nateIP" {
#   vpc = true
# }

# # Creating the NAT Gateway using subnet_id and allocation_id
# resource "aws_nat_gateway" "NATgw" {
#   allocation_id = aws_eip.nateIP.id
#   subnet_id     = aws_subnet.publicsubnets.id
# }
