 # key management
 resource "aws_key_pair" "mykey" {
    key_name = "first"
    public_key = file("~/.ssh/id_ed25519.pub")
   
 }
 #vpc creation
 resource "aws_vpc" "myvpc" {
    cidr_block = "10.0.0.0/16"
    enable_dns_support   = true
  enable_dns_hostnames = true

   tags = {
    Name="Myvpc"
    }
   
 }
 #creation of subnet
 resource "aws_subnet" "sub1" {
  vpc_id                  = aws_vpc.myvpc.id
  cidr_block              = "10.0.0.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "PublicSubnet"
  }
 }

#creation of internetgateway
resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.myvpc.id
    tags = {
      Name ="igw"
    }

  
}
# creation of route-table and edit route
resource "aws_route_table" "rt" {
    vpc_id = aws_vpc.myvpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }
    tags = {
      Name ="rt"
    }
  
}
# creation of subnet-assosiation
resource "aws_route_table_association" "name" {
  
    route_table_id = aws_route_table.rt.id
    subnet_id = aws_subnet.sub1.id
    
    
  
}
# security group
resource "aws_security_group" "sg" {
  name = "sgg"
  vpc_id = aws_vpc.myvpc.id
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
 # creation of ubuntu server
 resource "aws_instance" "name" {
  ami = "ami-0b6c6ebed2801a5cb"
  instance_type = "t2.micro"
  key_name = aws_key_pair.mykey.key_name
  subnet_id = aws_subnet.sub1.id
  vpc_security_group_ids = [ aws_security_group.sg.id ]
  associate_public_ip_address = true
  tags ={
    Name="ubuntu_server"
  }
  connection {
    type = "ssh"
    user = "ubuntu"
    private_key = file("~/.ssh/id_ed25519")
     host        = self.public_ip
     timeout     = "2m"
  }
  # file provisioner
  provisioner "file" {
    source = "file1"
    destination = "/home/ubuntu/file1"

    
  }
  # remote execution provisinor
 provisioner "remote-exec" {
    inline = [
       "touch /home/ubuntu/file200",
     "echo 'hello from awsdevopsmulticloud devops' >> /home/ubuntu/file200"
     ]
   }
   provisioner "local-exec" {
    command = "touch file10"
     
   }

   
 }
 


   
 