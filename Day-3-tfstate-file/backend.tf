terraform {
  backend "s3" {
    bucket = "sdkajfkxnasd"
    key = "terraform.tfstate"
    region = "us-east-1"
    
  }
}