resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true # Gives you an internal host name
  enable_dns_support   = true # Gives you an internal domain name
  instance_tenancy     = "default"

  tags = {
    Name = "${var.environment}-vpc"
  }
}

# Create a Public Subnets
resource "aws_subnet" "public_subnets" {
  count = 3

  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.public_subnets_cidrs[count.index]
  map_public_ip_on_launch = "true" # Makes this a public subnet
  availability_zone       = var.subnet_availability_zones[count.index]

  tags = {
    Name = "${var.environment}-vpc-public-subnet-${count.index}"
  }
}

# Create a Private Subnets
resource "aws_subnet" "private_subnets" {
  count = 3

  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.private_subnets_cidrs[count.index]
  availability_zone = var.subnet_availability_zones[count.index]

  tags = {
    Name = "${var.environment}-vpc-private-subnet-${count.index}"
  }
}

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
