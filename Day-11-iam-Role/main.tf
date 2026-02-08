provider "aws" {
  
}
resource "aws_iam_role" "ec2-s3" {
    name="ec2-s3"


    assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "sts:AssumeRole"
            ],
            "Principal": {
                "Service": [
                    "ec2.amazonaws.com"
                ]
            }
        }
    ]
})
  
}
# attaching policy to the role
resource "aws_iam_role_policy_attachment" "name" {
    role = aws_iam_role.ec2-s3.name
    policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
  
}
#creation of ami_instance_profile
resource "aws_iam_instance_profile" "EC2-profile" {
    name = "ec2-iam-instance"
    role = aws_iam_role.ec2-s3.name
  
}
resource "aws_instance" "name" {
    ami="ami-0532be01f26a3de55"
    instance_type = "t3.micro"
    iam_instance_profile = aws_iam_instance_profile.EC2-profile.name
    tags = {
      Name="ec2-with-role-s3"
    }
  
}
resource "aws_s3_bucket" "name" {
    bucket = "dfkwewaqpavff"
  
}
