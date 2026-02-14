 variable"vpc_cidr" {}
variable "public_subnet_cidr" {}
variable "public2_subnet_cidr" {}
variable "availability_zone" {}
variable "availability_zone2" {}
variable "instance_type" {}
variable "env" {}
variable "ami_id" {}
variable "region" {}
variable "db_name" {}
variable "db_instance_class" {}
variable "db_password" {}
variable "db_user" {}

variable "ingress_ports" {
  type = list(number)
}

variable "allowed_cidr" {
  type = list(string)
}


