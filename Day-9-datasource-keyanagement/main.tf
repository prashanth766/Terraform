
data "aws_vpc" "existing" {
    filter {
      name="tag:Name"
      values = [ "new-vpc" ]
    }
  
}
data "aws_subnet" "name" {
    filter {
      name="tag:Name"
      values = [ "public subnet" ]
    }
  
}
data "aws_key_pair" "existing" {
   key_name = "task"
  
}
resource "aws_instance" "server" {
  ami                         = "ami-055a9df0c8c9f681c" 
  instance_type               = "t2.micro"
  
  subnet_id = data.aws_subnet.name.id
  key_name = data.aws_key_pair.existing.key_name
  
  
}