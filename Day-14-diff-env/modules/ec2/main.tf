resource "aws_instance" "web" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = var.subnet-1-id

  tags = {
    Name = "WebServer"
  }
}