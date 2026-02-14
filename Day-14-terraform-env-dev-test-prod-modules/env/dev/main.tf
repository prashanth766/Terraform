

provider "aws" {
  region = var.region
  #profile = "dev"
}

module "vpc" {
  source              = "../../modules/vpc"
  cidr_block          = var.vpc_cidr             # ✅ Correct name
  availability_zone   = var.availability_zone 
  availability_zone2  =  var.availability_zone2    # ✅ Correct name
  public_subnet_cidr  = var.public_subnet_cidr
  public2_subnet_cidr = var.public2_subnet_cidr    # ✅ Correct name
  env                 = var.env
}

module "ec2" {
  source        = "../../modules/ec2"
  ami_id = var.ami_id
  instance_type = var.instance_type
  env           = var.env
 subnet_id     = module.vpc.public_subnet_id
 
  
}
module "rds" {
  source = "../../modules/rds"
  db_name=var.db_name
  db_instance_class=var.db_instance_class
  db_user = var.db_user
  db_password = var.db_password
  env = var.env
  public2_subnet_id = module.vpc.public2_subnet_id
  public_subnet_id = module.vpc.public_subnet_id

  db_sg_id = module.web_sg.security_group_id
  

  
}
module "web_sg" {
  source = "../../modules/sg"
  

  sg_name       = "web-sg"
  
  
  ingress_ports = [22, 80, 3306]
  allowed_cidr  = ["0.0.0.0/0"]
}
