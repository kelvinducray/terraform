provider "aws" {
  region = var.aws_region
}

module "vpc-module" {
  source      = "./modules/vpc"
  aws_region  = var.aws_region
  environment = var.environment
  production  = var.production
  ssh_ip      = var.ssh_ip
}
