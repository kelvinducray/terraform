variable "aws_region" {
  description = "The physical location of all of the AWS infrastructure for this project."
  type        = string
  default     = "ap-southeast-2" # Sydney
}

variable "production" {
  description = "Used to toggle dev/prod only infrastructure."
  # NOTE: Overwrite dev. default by setting TF_VAR_production=true
  type    = bool
  default = false
}

variable "environment" {
  description = "Used for naming resources."
  # NOTE: Overwrite dev. default by setting TF_VAR_environment=prod
  type    = string
  default = "dev"
}

variable "ssh_ip" {
  description = "This will get added as an exception to the VPC security group so you can use SSH."
  # NOTE: Parse this value in by using TF_VAR_ssh-ip
  type = string
}
