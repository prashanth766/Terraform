# resource "aws_instance" "name" {
#     ami = "ami-0c1fe732b5494dc14"
#     instance_type = "t2.micro"
    
#     count = 2
#     # tags = {
#     #   Name="dev"
#     # }
#     tags = {
#       Name="dev-${count.index}"
#     }
#}
  
variable "env" {
    type = list(string)
    default = [ "dev","prod"]
  
}

resource "aws_instance" "name" {
    ami = "ami-0c1fe732b5494dc14"
    instance_type = "t2.micro"
    count = length(var.env)
    # tags = {
    #   Name = "dev"
    # }
  tags = {
      Name = var.env[count.index]
    }
}


