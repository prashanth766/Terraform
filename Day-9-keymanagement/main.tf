 #Key Pair
resource "aws_key_pair" "example" {
  key_name   = "task"
  public_key = file("~/.ssh/id_ed25519.pub")
}


resource "aws_instance" "server" {
  ami                         = "ami-055a9df0c8c9f681c" 
  instance_type               = "t2.micro"
  key_name                    = "task"
  subnet_id = data.aws_subnet.name.id
  
  
}
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