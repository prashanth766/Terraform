resource "aws_instance" "name" {
    ami = "ami-055a9df0c8c9f681c"
    instance_type = "t2.micro"
  depends_on = [ aws_s3_bucket.name2]
}
resource "aws_s3_bucket" "name2" {
    bucket = "sjadkeujeur"
    
  
}