provider "aws" {
  region = "us-east-2"
}

terraform {
  required_version = "1.8.4"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.55.0"
    }
  }
}
