# provider "aws" {
#   region = "us-east-1"
# }

variable "aws_s3_bucket-names" {
  type = list
  default = ["dev.app11","test.app22","prod.app33"]
}

resource "aws_s3_bucket" "name" {
    count = length(var.aws_s3_bucket-names)
    bucket = var.aws_s3_bucket-names[count.index]
    force_destroy = true
}