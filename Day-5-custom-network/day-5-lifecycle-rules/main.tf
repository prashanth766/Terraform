resource "aws_instance" "name" {
    ami = "ami-0532be01f26a3de55"
    instance_type = "t3.micro"
  tags = {
    Name= "developement"
  }
 # lifecycle {
  # ignore_changes = [ tags ,]
 # }
  lifecycle {
    create_before_destroy = true
  }
# lifecycle {
 #  prevent_destroy = true
 #}#
}