vpc_cidr           = "10.0.0.0/16"
public_subnet_cidr = "10.0.3.0/24"
public2_subnet_cidr = "10.0.2.0/24"
availability_zone  = "us-west-2a"
availability_zone2 = "us-west-2b"
instance_type      = "t2.micro"
env                = "prod"
ami_id             = "ami-0c1fe732b5494dc14"
region             = "us-west-2"
#------- Rds---------
db_name = "prashanthhhh"
db_user = "admin"
db_instance_class = "db.t3.micro"
db_password = "devprod1234"
#-------sg---------
#vpc_id = "vpc-0fe4bc40f4506caeb"

ingress_ports = [22, 80, 3306]

allowed_cidr = ["0.0.0.0/0"]
