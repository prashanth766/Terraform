#ccreation of vpc
resource "aws_vpc" "name" {
    cidr_block = "10.0.0.0/16"
  
}
## cretate subnets
resource "aws_subnet" "name" {
    vpc_id = aws_vpc.name.id
    cidr_block = "10.0.0.0/24"
    availability_zone = "us-east-1a"
  
}
resource "aws_subnet" "name2" {
    vpc_id = aws_vpc.name.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "us-east-1b"
  
}
#creation of subnet group
resource "aws_db_subnet_group" "name" {
    subnet_ids = [ aws_subnet.name.id,aws_subnet.name2.id ]
    name = "custsubgroup"
  
}
#creation of rds sg
resource "aws_security_group" "name" {
    vpc_id = aws_vpc.name.id
    
    name = "allow"
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
####CREATION OF MASTER DB#####
resource "aws_db_instance" "master" {
    allocated_storage        = 10
    identifier              = "mysql-master-db"
    engine                 = "mysql"
    engine_version         = "8.0"
    instance_class        = "db.t3.micro"
    db_name              = "mydb"
    username                = "admin"
    password            = "cloud123"
    backup_retention_period = 7    # REQUIRED for read replica
    multi_az                = false

    vpc_security_group_ids  = [aws_security_group.name.id]
    db_subnet_group_name = aws_db_subnet_group.name.id

     publicly_accessible     = false
     skip_final_snapshot     = true
     deletion_protection = false
     
    

  
}
#####CREATION OF READ REPLACA#####
resource "aws_db_instance" "read_replica" {
  identifier          = "mysql-read-replica"
  instance_class      = "db.t3.micro"

  replicate_source_db = aws_db_instance.master.arn ## these is for read replica with subnet set

  vpc_security_group_ids = [aws_security_group.name.id]
  db_subnet_group_name = aws_db_subnet_group.name.id

  publicly_accessible = false
  skip_final_snapshot = true
}
