resource "aws_instance" "name" {
    ami = "ami-0532be01f26a3de55"
    instance_type = "t3.micro"
    tags = {
      Name ="server"
    }
  
}
## command terraform import aws resourename.name in main.tf instaneid
# terraform import aws_instance.name i-0f805ae729b101f2f