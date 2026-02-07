provider "aws" {
  
}
resource "aws_db_instance" "mydb" {
    db_name = "prashanth"
    identifier = "master"
    db_subnet_group_name = aws_db_subnet_group.sub-grp.id
    instance_class = "db.t3.micro"
    allocated_storage = 20
    engine = "mysql"
    engine_version = "8.0"
    username = "admin"
    password = "cloud123"
    publicly_accessible = true
    skip_final_snapshot = true

  
}
resource "aws_vpc" "name" {
    cidr_block = "10.0.0.0/16"
    enable_dns_support = true
    enable_dns_hostnames = true
    tags = {
      Name = "dev"
    }
  
}
resource "aws_subnet" "subnet-1" {
    vpc_id = aws_vpc.name.id
    cidr_block = "10.0.0.0/24"
    availability_zone = "us-east-1a"
  
}
resource "aws_subnet" "subnet-2" {
    vpc_id = aws_vpc.name.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "us-east-1b"
  
}
resource "aws_db_subnet_group" "sub-grp" {
  name       = "mycutsubnett"
  subnet_ids = [aws_subnet.subnet-1.id, aws_subnet.subnet-2.id]

  tags = {
    Name = "My DB subnet group"
  }
}
#internet gateway
resource "aws_internet_gateway" "name" {
  vpc_id = aws_vpc.name.id
  
}
#route table
resource "aws_route_table" "name" {
  vpc_id = aws_vpc.name.id
  route {
    gateway_id = aws_internet_gateway.name.id
    cidr_block = "0.0.0.0/0"

  }
  
}
resource "aws_route_table_association" "name" {
  route_table_id = aws_route_table.name.id
  subnet_id = aws_subnet.subnet-1.id
  
  
}
resource "aws_route_table_association" "name2" {
  route_table_id = aws_route_table.name.id
  subnet_id = aws_subnet.subnet-2.id
  
  
}

# Use null_resource to execute the SQL script from your local machine
resource "null_resource" "local_sql_exec" {
  depends_on = [aws_db_instance.mydb]

  provisioner "local-exec" {
    command = "mysql -h ${aws_db_instance.mydb.address} -u admin -pcloud123 prashanth < init.sql"
  }

  triggers = {
    always_run = timestamp()
  }
}