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
    availability_zone = "us-east-1a"
    tags = {
      Name ="public subnet"
    }
  
}
resource "aws_subnet" "private" {
    vpc_id = aws_vpc.name.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "us-east-1b"
    tags = {
        Name ="priivate subnet"
    }
  
}
#create internet gateway and attach to vpc
resource "aws_internet_gateway" "name" {
    vpc_id = aws_vpc.name.id
    tags = {
      Name = "igw"
    }
  
}
#create route table and edit routes
resource "aws_route_table" "name" {
    vpc_id = aws_vpc.name.id
    tags = {
      Name ="routetable"
    }
    route  {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.name.id

    }
  
}
#create subnet association
resource "aws_route_table_association" "name" {
    route_table_id = aws_route_table.name.id
    subnet_id = aws_subnet.public.id
  
}
#create securrity groups
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
#create instance
resource "aws_instance" "name" {
    ami = var.ami_id
    instance_type = var.type
    subnet_id = aws_subnet.public.id
    vpc_security_group_ids = [ aws_security_group.name.id ]
    associate_public_ip_address = true
    tags = {
      Name="server"
    }
  
}
#crreate elastic ip
resource "aws_eip" "name" {
    domain = "vpc"
  
}

#create nat gateway
resource "aws_nat_gateway" "name" {
  allocation_id = aws_eip.name.id
  subnet_id     = aws_subnet.public.id

  tags = {
    Name = "gw NAT"
  }
}


#create route table and edit routes
resource "aws_route_table" "name2" {
    vpc_id = aws_vpc.name.id
    tags = {
      Name ="private route"
    }
    route {
        nat_gateway_id = aws_nat_gateway.name.id
        cidr_block = "0.0.0.0/0"
    }
  
}
#create subnet associaton for nat
resource "aws_route_table_association" "dev" {
    route_table_id = aws_route_table.name2.id
    subnet_id = aws_subnet.private.id
  
}
resource "aws_instance" "private" {
    ami = var.ami_id
    instance_type = var.type
    subnet_id = aws_subnet.private.id
    vpc_security_group_ids = [ aws_security_group.name.id ]
    associate_public_ip_address = false
    tags = {
      Name = "private-ec2"
    }
  
}