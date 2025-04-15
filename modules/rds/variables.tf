variable "cluster_id" {
  description = "The name of the RDS cluster"
  type        = string
}

variable "username" {
  description = "The username for the database"
  type        = string
}

variable "password" {
  description = "The password for the database"
  type        = string
}

variable "security_group_id" {
  description = "The security group ID"
  type        = string
}

variable "db_subnet_group_name" {
  description = "The DB subnet group name"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs for the RDS instance"
  type        = list(string)
}

variable "access_policies" {
  description = "IAM policy document specifying the access policies for the OpenSearch domain"
  type        = string
  default     = null  # Or provide a default JSON policy if appropriate
}