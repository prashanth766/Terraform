# provider "aws" {
  
# }
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws" # The source of the AWS provider or "open-tofu/aws" if using OpenTofu
      version = "~> 5.0"        # Example version constraint, adjust as needed
    }
  }
}