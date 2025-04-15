resource "aws_opensearch_domain" "main" {
  domain_name     = "my-opensearch-domain"
  engine_version  = "OpenSearch_1.0"
  
  cluster_config {
    instance_type  = "t3.small.search"
    instance_count = 1
  }

  ebs_options {
    ebs_enabled = true
    volume_size = 10
    volume_type = "gp2"
  }
  
  # Security configurations
  encrypt_at_rest {
    enabled = true
  }
  
  node_to_node_encryption {
    enabled = true
  }
  
  domain_endpoint_options {
    enforce_https       = true
    tls_security_policy = "Policy-Min-TLS-1-2-2019-07"
  }
  
  # Fine-grained access control with hardcoded values
  advanced_security_options {
    enabled                        = true
    internal_user_database_enabled = true
    master_user_options {
      master_user_name     = "admin"
      master_user_password = "Secure_Password_123!"
    }
  }
  
  access_policies = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "*"
      },
      "Action": "es:*",
      "Resource": "arn:aws:es:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:domain/my-opensearch-domain/*"
    }
  ]
}
POLICY
}

# Get current AWS region and account ID for policy
data "aws_region" "current" {}
data "aws_caller_identity" "current" {}