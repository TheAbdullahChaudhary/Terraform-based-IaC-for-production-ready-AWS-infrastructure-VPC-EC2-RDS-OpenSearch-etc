# main.tf

# Provider Configuration
provider "aws" {
  region = "us-west-2"
}

# VPC Module
module "vpc" {
  source               = "../../modules/vpc"
  vpc_cidr             = "10.0.0.0/16"
  name                 = "dev-vpc"
  azs                  = ["us-west-2a", "us-west-2b"]  # Changed from us-east-1a/b to us-west-2a/b
  public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnet_cidrs = ["10.0.3.0/24", "10.0.4.0/24"]
}

# EFS Module
module "efs" {
  source            = "../../modules/efs"
  subnet_ids        = module.vpc.private_subnet_ids
  security_group_id = module.vpc.security_group_id
}

# OpenSearch Module - with hardcoded values
module "opensearch" {
  source          = "../../modules/opensearch"
  # No need to pass variables as they'll be hardcoded in the module
}

# RDS Module
module "rds" {
  source               = "../../modules/rds"
  cluster_id           = "dev-aurora-cluster"
  username             = "admin"
  password             = "password"
  security_group_id    = module.vpc.security_group_id
  db_subnet_group_name = "dev-db-subnet-group"
  subnet_ids           = module.vpc.private_subnet_ids # Passing private subnet IDs from VPC module
}

# Secrets Manager Module
module "secrets" {
  source      = "../../modules/secrets"
  db_username = "admin"
  db_password = "password"
}