terraform {

  required_version = ">= 1.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.73.0"
    }
  }

  backend "s3" {
    bucket = "antonio1414-remote-state-bucket"
    key    = "aws-vm-pipeline-github/terraform.tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
  region = "us-east-1"

  default_tags {
    tags = {
      Owner      = "antonio1414"
      CostCenter = "PBCompass"
      Project    = "PB"
      ManagedBy  = "Terraform"
    }
  }

}

data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = "antonio1414-remote-state-bucket"
    key    = "aws-vpc/terraform.tfstate"
    region = "us-east-1"
  }
}