

# Fetch existing MySQL Master RDS
data "aws_db_instance" "existing_master" {
  db_instance_identifier = "mysql-master-db"
}

# Fetch existing DB Subnet Group
data "aws_db_subnet_group" "existing_subnet_group" {
  name = "custsubgroup"
}

# Create Read Replica
resource "aws_db_instance" "read_replicaaaaaa" {
  identifier     = "mysql-read-replicaaa"
  instance_class = "db.t3.micro"

  # ✅ Correct attribute
  replicate_source_db = data.aws_db_instance.existing_master.db_instance_arn

  db_subnet_group_name   = data.aws_db_subnet_group.existing_subnet_group.name
  
  skip_final_snapshot = true
}
