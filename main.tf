provider "aws" {
  # profile = "default"
  region = "ap-southeast-2"
}

module "dev-environment" {
  source = "./modules/dev"
}
