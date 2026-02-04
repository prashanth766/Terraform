resource "aws_instance" "name" {
    ami = var.ami_id
    instance_type = var.type
    subnet_id = aws_subnet.public.id
    vpc_security_group_ids = [ aws_security_group.name.id ]
    user_data = file("prod.sh") ## calling test.sh from current directory by using file fucntion 
      tags = {
        Name ="dev"  
      }
      associate_public_ip_address = true
}
#create vpc
resource "aws_vpc" "name" {
    cidr_block = "10.0.0.0/16"
    tags = {
        Name ="new-vpc"
    }
  
}
#create subnet
resource "aws_subnet" "public" {
    vpc_id =aws_vpc.name.id
    cidr_block = "10.0.0.0/24"
    
    tags = {
      Name ="public subnet"
    }
}
#create internet gateway
resource "aws_internet_gateway" "name" {
    vpc_id = aws_vpc.name.id

  
}
#create route table
resource "aws_route_table" "name" {
    vpc_id = aws_vpc.name.id
    route {
        gateway_id = aws_internet_gateway.name.id 
        cidr_block = "0.0.0.0/0"
        
  
}

}
resource "aws_route_table_association" "name" {
    route_table_id = aws_route_table.name.id
    subnet_id = aws_subnet.public.id
  
}
resource "aws_security_group" "name" {
    name = "allow"
    vpc_id =aws_vpc.name.id
    tags = {
      Name ="new sg"
    }
ingress {
    description = "ssh"
    from_port = "22"
    to_port = "22"
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
}
  ingress {
    description = "http"
    from_port = "80"
    to_port = "80"
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }
   egress {
    from_port = "0"
    to_port = "0"
    protocol = "-1"
    cidr_blocks = [ "0.0.0.0/0" ]
   }
}
