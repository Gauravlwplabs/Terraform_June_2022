terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.22.0"
    }
  }
  backend "s3" {
    bucket = "terraform-state-bucket-20346"
    key    = "terraform-state-file"
    region = "us-east-1"
    dynamodb_table = "terraform_lockstate"
  }
}

provider "aws" {
  region = "us-east-1"
}



