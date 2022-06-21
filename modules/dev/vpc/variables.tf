variable "dev_vpc_cidr" {
  description = "The full range of IPs in the VPC, totalling 65,528 hosts."
  type        = string
  default     = "192.168.0.0/16"
}

variable "public_subnet_1_cidr" {
  description = "Usable IPs: 192.168.0.1 - 192.168.63.254, totalling 16,382 hosts."
  type        = string
  default     = "192.168.0.0/18"
}

variable "public_subnet_2_cidr" {
  description = "Usable IPs: 192.168.64.1 - 192.168.127.254, totalling 16,382 hosts."
  type        = string
  default     = "192.168.64.0/18"
}

variable "private_subnet_1_cidr" {
  description = "Usable IPs: 192.168.128.1 - 192.168.191.254, totalling 16,382 hosts."
  type        = string
  default     = "192.168.128.0/18"
}

variable "private_subnet_2_cidr" {
  description = "Usable IPs: 192.168.192.1 - 192.168.255.254, totalling 16382 hosts."
  type        = string
  default     = "192.168.192.0/18"
}
