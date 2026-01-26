terraform {
  backend "s3" {
    bucket = "sdkajfkxnasd"
    key = "dev/terraform.tfstate"
    region = "us-east-1"
    
  }
}