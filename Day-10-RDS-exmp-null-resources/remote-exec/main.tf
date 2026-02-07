
provider "aws" {
  
}
resource "aws_db_instance" "mydb" {
    db_name = "dev"
    identifier = "master"
    db_subnet_group_name = aws_db_subnet_group.sub-grp.id
    instance_class = "db.t3.micro"
    allocated_storage = 20
    engine = "mysql"
    engine_version = "8.0"
    username = "admin"
    password = "cloud123"
    publicly_accessible = false
    skip_final_snapshot = true
    vpc_security_group_ids = [ aws_security_group.sg.id ]

  
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
 #security group
resource "aws_security_group" "sg" {
  name = "sgg"
  vpc_id = aws_vpc.name.id
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
  ingress {
    description = "mysql"
    from_port = "3306"
    to_port = "3306"
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

resource "aws_key_pair" "example" {
  key_name   = "task"
  public_key = file("~/.ssh/id_ed25519.pub")
}
# Example EC2 instance (replace with yours if already existing)
resource "aws_instance" "sql_runner" {
  ami                    = "ami-0532be01f26a3de55" # Amazon Linux 2
  instance_type          = "t2.micro"
  key_name               = "task"                # Replace with your key pair name
  associate_public_ip_address = true
  subnet_id = aws_subnet.subnet-1.id
  user_data = <<-EOF
#!/bin/bash
yum update -y
yum install -y mariadb105
EOF

  vpc_security_group_ids = [ aws_security_group.sg.id ]

  tags = {
    Name = "SQL Runner"
  }
}

    
  



# Deploy SQL remotely using null_resource + remote-exec
resource "null_resource" "remote_sql_exec" {
  depends_on = [
    aws_db_instance.mydb,
    aws_instance.sql_runner
  ]

  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("~/.ssh/id_ed25519")
    host        = aws_instance.sql_runner.public_ip
  }

  provisioner "file" {
    source      = "init.sql"
    destination = "/tmp/init.sql"
  }

  provisioner "remote-exec" {
    inline = [
      "mariadb --version",
      #"mariadb -h ${aws_db_instance.mydb.address} -u admin -pcloud123  < /tmp/init.sql"
      "mysql -h ${aws_db_instance.mydb.address} -u admin -pcloud123  < /tmp/init.sql"
    ]
  }

  triggers = {
    always_run = timestamp()
  }
}

  
#   resource "null_resource" "remote_sql_exec" {
#   depends_on = [     aws_db_instance.mydb,
#      aws_instance.sql_runner
#    ]

#   connection {
#     type        = "ssh"
#     user        = "ec2-user"
#     private_key = file("~/.ssh/id_ed25519")   # Replace with your PEM file path
#     host        = aws_instance.sql_runner.public_ip
#   }

#   provisioner "file" {
#     source      = "init.sql"
#     destination = "/tmp/init.sql"
#   }

#   provisioner "remote-exec" {
#     inline = [
#       #"mysql -h ${aws_db_instance.mysql_rds.address} -u ${jsondecode(aws_secretsmanager_secret_version.rds_secret_value.secret_string)["username"]} -p${jsondecode(aws_secretsmanager_secret_version.rds_secret_value.secret_string)["password"]} < /tmp/init.sql"
#       "mysql -h ${aws_db_instance.mydb.address} -u admin -pcloud123 pras < /tmp/init.sql"
#     ]
#   }

#   triggers = {
#     always_run = timestamp() #trigger every time apply 
#   }
# }




# # # ADD RDS creation script only accessbale interanlly si disable public access 
# # # Remote provisioner server also should create insame vpc 
# # # enable secrets fro secret manager and call secrets into RDS for this process vpc endpoint is require or nat gateway is required to access secrets to rds internall as secremanger is not in side VPC sefrvice 