module "vpc" {
  source       = "./modules/vpc"
  cidr_block   = "10.0.0.0/16"
  subnet-1-cidr  = "10.0.1.0/24"
  subnet-2-cidr = "10.0.2.0/24"
  az1           = "us-east-1a"
  az2           = "us-east-1b"
}

 module "ec2" {
   source        = "./modules/ec2"
   ami_id        = "ami-0c1fe732b5494dc14"  # Replace with valid AMI
   instance_type = "t2.micro"
   subnet-1-id     = module.vpc.subnet-1-id
}

module "rds" {
  source         = "./modules/rds"
  subnet-1-id      = module.vpc.subnet-1-id
  subnet-2-id      = module.vpc.subnet-2-id
  instance_class = "db.t3.micro"
  db_name        = "mydb"
  db_user        = "admin"
  db_password    = "Admin12345"
}

module "s3" {
    source = "./modules/s3"
    bucket = "wertyuisdfghjxcfvghkkjbdf"
  

}