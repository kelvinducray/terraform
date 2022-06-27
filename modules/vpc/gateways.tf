# Create Internet Gateway for the VPC
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "${var.environment}-igw"
  }
}

# Create NAT Gateway
# But first, we need an EIP for it!
resource "aws_eip" "nat_gateway_eip" {
  vpc = true

  tags = {
    Name = "${var.environment}-eip"
  }
}
resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.nat_gateway_eip.id

  subnet_id = aws_subnet.public_subnets[0].id

  tags = {
    Name = "${var.environment}-nat-gateway"
  }
}

# *PUBLIC* Route Table - (will go via IGW)
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.environment}-public-route-table"
  }
}
resource "aws_route" "public_route" {
  route_table_id         = aws_route_table.public_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}
# Associate public routing table with public subnets
resource "aws_route_table_association" "public_subnets_rt_assoc" {
  count          = 3
  subnet_id      = aws_subnet.public_subnets[count.index].id
  route_table_id = aws_route_table.public_route_table.id
}

# *PRIVATE* Route Table - (will go via NAT gateway)
resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.environment}-private-route-table"
  }
}
resource "aws_route" "private_route" {
  route_table_id         = aws_route_table.private_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat_gateway.id
}
# Associate public routing table with public subnets
resource "aws_route_table_association" "private_subnets_rt_assoc" {
  count          = 3
  subnet_id      = aws_subnet.private_subnets[count.index].id
  route_table_id = aws_route_table.private_route_table.id
}
