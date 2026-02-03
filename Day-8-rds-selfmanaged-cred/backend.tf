terraform {
  backend "s3" {
    bucket = "asdfqwertkdf"
    key = "dev/terraform.tfstate"
    region = "us-west-2"
    
  }
}