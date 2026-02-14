resource "aws_vpc" "name" {
    cidr_block = "10.0.0.0/16"
    tags = {
      Name = "new-vpc"
    }
  
}
resource "aws_vpc" "name2" {
    cidr_block = "10.0.0.0/16"
    tags = {
      Name ="2ndvpc"
    }
  
}
resource "aws_subnet" "name" {
    vpc_id = aws_vpc.name.id
    cidr_block = "10.0.0.0/24"
    tags = {
      Name ="subnet1"
    }
  
}
resource "aws_subnet" "namee" {
    vpc_id = aws_vpc.name.id
    cidr_block = "10.0.1.0/24"
    tags = {
      Name ="subnet2" 
    }
  
}
resource "aws_subnet" "name3" {
    vpc_id = aws_vpc.name2.id
    cidr_block = "10.0.0.0/24"
    tags ={
        Name="subnet"
    }
  
}
  
