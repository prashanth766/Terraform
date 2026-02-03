terraform {
  backend "s3" {
    bucket = "asdfqwertkdf"
    key = "dev2datasrc/terraform.tfstate"
    region = "us-west-2"
    
  }
}


