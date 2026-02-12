resource "aws_vpc" "main" {
  cidr_block = var.cidr_block
}

resource "aws_subnet" "subnet1" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.subnet-1-cidr
  availability_zone = var.az1
}

resource "aws_subnet" "subnet2" {
    vpc_id = aws_vpc.main.id
    cidr_block = var.subnet-2-cidr
    availability_zone = var.az2

  
}


output "subnet-1-id" {
  value = "${aws_subnet.subnet1.id}"
}

output "subnet-2-id" {
  value = "${aws_subnet.subnet2.id}"
}