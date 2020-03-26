# Configure the AWS Provider

provider "aws" {
  region     = "us-east-2"
  access_key = "AKIAIAMK4MAKOPQZDQPQ"
  secret_key = "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"
}

provider "github" {
  version      = "> 2.4"
  token        = var.github_token
  organization = var.github_organization
}

data "aws_caller_identity" "current" {}




