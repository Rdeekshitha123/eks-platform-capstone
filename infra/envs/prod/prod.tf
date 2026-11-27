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

  name            = "eks-prod"
  vpc_cidr        = "10.1.0.0/16"
  cluster_version = "1.33"

  node_instance_types = ["t3.medium"]
  node_min_size       = 2
  node_desired_size   = 2
  node_max_size       = 4

  ecr_repository_name = "myapp-prod"

  public_subnets = {
    public-a = { cidr_block = "10.1.1.0/24", availability_zone = "us-east-1a" }
    public-b = { cidr_block = "10.1.2.0/24", availability_zone = "us-east-1b" }
  }

  private_subnets = {
    private-a = { cidr_block = "10.1.3.0/24", availability_zone = "us-east-1a" }
    private-b = { cidr_block = "10.1.4.0/24", availability_zone = "us-east-1b" }
  }
}
