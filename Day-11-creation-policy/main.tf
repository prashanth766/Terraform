provider "aws" {
  region = "us-east-1"
}

####### IAM custom policy creation #########################
resource "aws_iam_policy" "s3_read_policy" {
  name        = "CustomS3ReadPolicy"
  description = "Allow read access to specific S3 bucket"
   depends_on = [ aws_s3_bucket.name ]
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:GetObject",
          "s3:ListBucket"
        ]
        Resource = [
          "arn:aws:s3:::my-bucket-name",
          "arn:aws:s3:::my-bucket-name/*"
        ]
      }
    ]
  })
}
resource "aws_s3_bucket" "name" {
  bucket = "kjfjfndvjsnvvn"
}