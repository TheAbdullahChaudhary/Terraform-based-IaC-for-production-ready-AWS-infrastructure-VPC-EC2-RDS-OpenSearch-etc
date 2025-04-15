# Secrets Manager for DB credentials
resource "aws_secretsmanager_secret" "db_secret" {
  name        = "dev-db-secret"
  description = "Database credentials"
}

resource "aws_secretsmanager_secret_version" "db_secret_version" {
  secret_id = aws_secretsmanager_secret.db_secret.id
  secret_string = jsonencode({
    username = var.username
    password = var.password
  })
}

# DB Subnet Group - Corrected resource type
resource "aws_db_subnet_group" "db_subnet_group" {
  name       = var.db_subnet_group_name
  subnet_ids = var.subnet_ids # Accept subnet IDs as a variable

  tags = {
    Name = "db-subnet-group"
  }
}


# RDS Aurora MySQL Cluster
resource "aws_rds_cluster" "aurora" {
  cluster_identifier      = var.cluster_id
  engine                  = "aurora-mysql"
  master_username         = var.username
  master_password         = var.password
  skip_final_snapshot     = true
  backup_retention_period = 7
  vpc_security_group_ids  = [var.security_group_id]
  db_subnet_group_name    = aws_db_subnet_group.db_subnet_group.name
}



# Outputs
output "rds_cluster_endpoint" {
  value = aws_rds_cluster.aurora.endpoint
}

output "db_secret_arn" {
  value = aws_secretsmanager_secret.db_secret.arn
}


