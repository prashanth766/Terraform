resource "aws_instance" "name" {
    ami = "ami-0532be01f26a3de55"
    instance_type = "t2.micro"
  
}
resource "aws_s3_bucket" "name" {
    bucket = "dklsfeelk"
    provider = aws.oregon
  
}