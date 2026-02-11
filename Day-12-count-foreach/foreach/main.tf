variable "env" {
    type = list(string)
    default = [ "test","prod"]
  
}

resource "aws_instance" "name" {
    ami = "ami-0c1fe732b5494dc14"
    instance_type = "t2.micro"
    for_each = toset(var.env) 
    # tags = {
    #   Name = "dev"
    # }
  tags = {
      Name = each.value
    }
}