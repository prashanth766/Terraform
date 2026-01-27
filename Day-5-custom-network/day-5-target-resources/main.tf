resource "aws_vpc" "name" {
    cidr_block = "10.0.0.0/16"
  
}
resource "aws_s3_bucket" "name" {
    bucket = "kjddsffbcxcfdsj"
  
}
resource "aws_internet_gateway" "name" {
    vpc_id = aws_vpc.name.id
  
}
#target resource is used to apply,plan,destroy the specific resource
#   terraform plan -target=aws_vpc.name
#    terraform apply -target=aws_vpc.name 
#    terraform destroy -target=aws_vpc.name 
#  we can also do multiple targets
#   terraform apply -target=aws_vpc.name -target=aws_s3_bucket.name

