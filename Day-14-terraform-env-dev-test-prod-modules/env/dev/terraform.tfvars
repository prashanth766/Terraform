vpc_cidr           = "10.0.0.0/16"
public_subnet_cidr = "10.0.3.0/24"
public2_subnet_cidr = "10.0.2.0/24"
availability_zone  = "us-east-1a"
availability_zone2 = "us-east-1b"
instance_type      = "t2.micro"
env                = "dev"
ami_id             = "ami-0c1fe732b5494dc14"
region             = "us-east-1"
#------- Rds---------
db_name = "prashanth"
db_user = "admin"
db_instance_class = "db.t3.micro"
db_password = "devprod123"
#-------sg---------
#vpc_id = "vpc-0fe4bc40f4506caeb"

ingress_ports = [22, 80, 3306]

allowed_cidr = ["0.0.0.0/0"]
