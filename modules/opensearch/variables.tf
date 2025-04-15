variable "domain_name" {
  description = "Name of the OpenSearch domain"
  type        = string
  default     = "my-opensearch-domain"
}

variable "instance_type" {
  description = "Instance type for OpenSearch nodes"
  type        = string
  default     = "t3.small.search"
}

variable "instance_count" {
  description = "Number of instances in the OpenSearch cluster"
  type        = number
  default     = 1
}

variable "master_user_arn" {
  description = "ARN of the IAM role for OpenSearch master user"
  type        = string
  default     = null
}

variable "master_user_name" {
  description = "Username for the master user in OpenSearch"
  type        = string
  default     = "admin"
}

variable "master_user_password" {
  description = "Password for the master user in OpenSearch"
  type        = string
  default     = "Secure_Password_123!"  # Replace with your desired password
}

variable "access_policies" {
  description = "IAM policy document specifying the access policies for the OpenSearch domain"
  type        = string
  default     = null
}