resource "aws_efs_file_system" "main" {
  creation_token   = "dev-efs-token"
  performance_mode = "generalPurpose"
  throughput_mode  = "bursting"
 # Temporarily allow deletion
  # lifecycle {
  #   prevent_destroy = true
  # }

  tags = {
    Name = "dev-efs"
  }
}

resource "aws_efs_mount_target" "mount_target" {
  count           = length(var.subnet_ids)
  file_system_id  = aws_efs_file_system.main.id
  subnet_id       = var.subnet_ids[count.index]
  security_groups = [var.security_group_id]
}

output "efs_id" {
  value = aws_efs_file_system.main.id
}
