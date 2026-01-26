terraform {
  backend "s3" {
    bucket = "jhffdhfdsfdjdjfjfhfdhfd"
    key = "terraform.tfstate"
    #use_lockfile = true
    region = "us-east-1"
    dynamodb_table = "prashanth"
    encrypt = true
    
  }
}