provider "aws" {
    region = var.region
  
}
module "vpc" {
  source       ="../../modules/vpc"
  cidr_block   = var.vpc_cidr
  subnet-1-cidr  = var.subnet-1-cidr
  subnet-2-cidr = var.subnet-2-cidr
  az1           = var.az1
  az2           = var.az2
  
}

 module "ec2" {
   source        = "../../modules/ec2"
   ami_id        = var.ami_id  # Replace with valid AMI
   instance_type = var.instance_type
   subnet-1-id     = module.vpc.subnet-1-id
   
}

module "rds" {
  source         = "../../modules/rds"
  subnet-1-id      = module.vpc.subnet-1-id
  subnet-2-id      = module.vpc.subnet-2-id
  instance_class = var.instance_class
  db_name        = var.db_name
  db_user        = var.db_user
  db_password    = var.db_password
  
}

module "s3" {
    source = "../../modules/s3"
    bucket = var.bucket
    
  

}