variable "vpc_cidr" {
  description = "The full range of IPs in the VPC, totalling 65,528 hosts."
  type        = string
  default     = "192.168.0.0/16"
}

variable "subnet_availability_zones" {
  description = "A map of Availability zones that should be used for public & private subnets."
  type        = list(string)
  default     = ["ap-southeast-2a", "ap-southeast-2b", "ap-southeast-2c"]
}

variable "public_subnets_cidrs" {
  description = "Total hosts: 24,570"
  # Subnet 1: 192.168.0.1 - 192.168.31.254 (8,190 hosts)
  # Subnet 2: 192.168.32.1 - 192.168.63.254, (8,190 hosts)
  # Subnet 3: 192.168.64.1 - 192.168.95.254, (8,190 hosts)

  type    = list(string)
  default = ["192.168.0.0/19", "192.168.32.0/19", "192.168.64.0/19"]
}

variable "private_subnets_cidrs" {
  description = "Total hosts: 24,570"
  # Subnet 1: 192.168.96.1 - 192.168.127.254 (8,190 hosts)
  # Subnet 2: 192.168.128.1 - 192.168.159.254, (8,190 hosts)
  # Subnet 3: 192.168.160.1 - 192.168.191.254, (8,190 hosts)

  type    = list(string)
  default = ["192.168.96.0/19", "192.168.128.0/19", "192.168.160.0/19"]
}

# Variables to be parsed from the root module:
variable "aws_region" {
  type = string
}
variable "production" {
  type = bool
}
variable "environment" {
  type = string
}
variable "ssh_ip" {
  type = string
}
