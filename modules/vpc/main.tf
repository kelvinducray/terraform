resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true # Gives you an internal host name
  enable_dns_support   = true # Gives you an internal domain name
  instance_tenancy     = "default"

  tags = {
    Name = "${var.environment}-vpc"
  }
}

# Create Internet Gateway and attach it to VPC
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "${var.environment}-igw"
  }
}

# Create a Public Subnets
resource "aws_subnet" "public_subnets" {
  count = 3

  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.public_subnets_cidrs[count.index]
  map_public_ip_on_launch = "true" # Makes this a public subnet
  availability_zone       = "${var.aws_region}${var.az_suffixes[count.index]}"

  tags = {
    Name = "${var.environment}-vpc-public-subnet-${count.index}"
  }
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc.id

  route {
    # Associated Subnets can reach everywhere
    cidr_block = "0.0.0.0/0"

    # RT uses the IGW to reach internet
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "${var.environment}-route-table"
  }
}

# Associate public routing table with public subnets
resource "aws_route_table_association" "public_subnets_rt_assoc" {
  count          = 3
  subnet_id      = aws_subnet.public_subnets[count.index].id
  route_table_id = aws_route_table.public_route_table.id
}

# Create a Private Subnets
resource "aws_subnet" "private_subnets" {
  count = 3

  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.private_subnets_cidrs[count.index]
  availability_zone = "${var.aws_region}${var.az_suffixes[count.index]}"

  tags = {
    Name = "${var.environment}-vpc-private-subnet-${count.index}"
  }
}

# Route table for Public Subnets
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

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



###########################################################



# resource "aws_eip" "nateIP" {
#   vpc = true
# }

# # Creating the NAT Gateway using subnet_id and allocation_id
# resource "aws_nat_gateway" "NATgw" {
#   allocation_id = aws_eip.nateIP.id
#   subnet_id     = aws_subnet.publicsubnets.id
# }

## Elastic-IP (eip) for NAT
#resource "aws_eip" "nat-eip" {
#  vpc        = true
#  depends_on = [aws_internet_gateway.igw]
#
#  tags = {
#    Name = "${var.environment}-nat-eip"
#  }
#}
#
## NAT
## NOTE: We use a NAT gateway in a public VPC subnet to enable outbound
##       internet traffic from instances in a private subnet.
#resource "aws_nat_gateway" "nat" {
#  allocation_id = aws_eip.nat-eip.id
#  subnet_id     = element(aws_subnet.public-subnet-*.id, 0)
#
#  tags = {
#    Name = "${var.environment}-nat-gateway"
#  }
#}

############################################################

# Allow SSH - but only in dev
resource "aws_security_group" "dev_allow_ssh" {
  count = var.production ? 0 : 1 # Only do this in dev

  vpc_id = aws_vpc.vpc.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.ssh_ip}/32"]
  }

  tags = {
    Name = "dev-allow-ssh"
  }
}
