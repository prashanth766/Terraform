resource "aws_db_subnet_group" "db_subnet_group1" {
  name       = "db-subnet-group1"
  subnet_ids = [var.subnet-1-id, var.subnet-2-id]
  

  tags = {
    Name = "My DB Subnet Group"
  }
}

resource "aws_db_instance" "mysql" {
  allocated_storage    = 20
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = var.instance_class
  db_name              = var.db_name
  username             = var.db_user
  password             = var.db_password
  db_subnet_group_name = aws_db_subnet_group.db_subnet_group1.name
  skip_final_snapshot  = true
}