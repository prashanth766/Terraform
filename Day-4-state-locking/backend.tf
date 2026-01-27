terraform {
  backend "s3" {
   bucket = "jhffdhfdsfdjdjfjfhfdhfdf"
    key = "terraform.tfstate"
    #use_lockfile = true
    region = "us-east-1"
    dynamodb_table = "prashanth"
    encrypt = true
    
  }
}