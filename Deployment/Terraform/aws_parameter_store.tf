resource "aws_ssm_parameter" "rds-database-address" {
  name  = "rds_address"
  type  = "String"
  value = aws_db_instance.database_instance.address
}

resource "aws_ssm_parameter" "rds-database-user" {
  name  = "rds_user"
  type  = "String"
  value = var.rds_user
}


resource "aws_ssm_parameter" "rds-database-master-password" {
  name  = "rds_password"
  type  = "String"
  value = var.rds_password
}