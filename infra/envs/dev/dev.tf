terraform {
  required_version = ">= 1.8"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

module "platform" {
  source = "../../modules"

  name     = "eks-dev"
  vpc_cidr = "10.0.0.0/16"

  public_subnets = {
    public-a = { cidr_block = "10.0.1.0/24", availability_zone = "us-east-1a" }
    public-b = { cidr_block = "10.0.2.0/24", availability_zone = "us-east-1b" }
  }

  private_subnets = {
    private-a = { cidr_block = "10.0.3.0/24", availability_zone = "us-east-1a" }
    private-b = { cidr_block = "10.0.4.0/24", availability_zone = "us-east-1b" }
  }
}
