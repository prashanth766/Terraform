variable "sg_name" {
  description = "Name of the security group"
  type        = string
}



variable "ingress_ports" {
  description = "List of ingress ports"
  type        = list(number)
}

variable "allowed_cidr" {
  description = "CIDR block allowed"
  type        = list(string)
}
