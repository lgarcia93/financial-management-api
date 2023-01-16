resource "aws_security_group" "rds_sg" {
  name   = "${var.app_name}-database-sg"
  vpc_id = aws_vpc.vpc.id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_db_instance" "database_instance" {
  allocated_storage = 20
  identifier        = "${var.app_name}-db-instance"
  storage_type      = var.rds_storage_type
  engine            = "mysql"
  engine_version    = "5.7"
  instance_class    = var.rds_instance_class
  db_name           = var.db_name
  username          = aws_ssm_parameter.rds-database-user.value
  multi_az = false  
  password             = aws_ssm_parameter.rds-database-master-password.value
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
  publicly_accessible  = true
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  db_subnet_group_name = aws_db_subnet_group.db_subnet_group.name
}

resource "aws_db_subnet_group" "db_subnet_group" {
  name = "db_subnets"
  subnet_ids = [aws_subnet.public-us-east-1a.id, aws_subnet.public-us-east-1b.id]

}
