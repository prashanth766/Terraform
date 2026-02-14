provider "aws" {
  region = "us-east-1"
}

resource "aws_iam_user" "developer" {
  name = "developer-user"
}

########## Create IAM User + Console Login (Password Access) ###########
# resource "aws_iam_user" "developer" {
#   name = "developer-user"
# }

resource "aws_iam_user_login_profile" "developer_console" {
  user    = aws_iam_user.developer.name
  password_length = 12
}  # ⚠️ Terraform will generate a password.
 # to see password ( "terraform output")
 
 ###### Create IAM User + Access Keys (Programmatic Access) ########

#  resource "aws_iam_user" "developer" {
#   name = "developer-user"
# }

resource "aws_iam_access_key" "developer_key" {
  user = aws_iam_user.developer.name
}
# After terraform apply, Terraform will output:

# Access Key ID

# Secret Access Key (shown only once)

# ⚠️ Store it securely.

######### Attach Policy to IAM User (Best Practice) ############

# Example: Attach S3 read-only policy.

resource "aws_iam_user_policy_attachment" "attach_s3_read" {
  user       = aws_iam_user.developer.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
}

