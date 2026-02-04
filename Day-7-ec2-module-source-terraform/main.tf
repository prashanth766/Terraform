module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = "single-instance"

  instance_type = "t3.micro"
  
  monitoring    = true
  subnet_id     = "subnet-062b488c439abe3a3"

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
  associate_public_ip_address = true
}