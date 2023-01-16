resource "aws_ssm_parameter" "rds-database-address" {
  name  = "rds-address-${var.app_name}"
  type  = "String"
  value = aws_db_instance.database_instance.address
}

resource "aws_ssm_parameter" "rds-database-user" {
  name  = "rds-user-${var.app_name}"
  type  = "String"
  value = var.rds_user
}

resource "aws_ssm_parameter" "rds-database-master-password" {
  name  = "rds-password-${var.app_name}"
  type  = "String"
  value = var.rds_password
}