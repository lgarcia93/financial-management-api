resource "aws_instance" "financial-management-instance-01" {
  ami                         = var.ami
  instance_type               = var.instance_type
  associate_public_ip_address = true
  security_groups             = [aws_security_group.ec2-sg.id]
  subnet_id                   = aws_subnet.financial-management-public-us-east-1a.id
  key_name                    = "ec2api"
  iam_instance_profile        = aws_iam_instance_profile.ec2_instance_profile.name
  user_data                   = "#!/bin/bash\necho ECS_CLUSTER=${aws_ecs_cluster.financial-management-cluster.name} >> /etc/ecs/ecs.config"

  depends_on = [aws_ecs_cluster.financial-management-cluster]

  tags = {
    Name        = var.name
    Environment = var.env
    Provisioner = "Terraform"
    Repo        = var.repo
  }

  #lifecycle {
  #  prevent_destroy = true
  #}
}

resource "aws_instance" "financial-management-instance-02" {
  ami                         = var.ami
  instance_type               = var.instance_type
  associate_public_ip_address = true
  security_groups             = [aws_security_group.ec2-sg.id]
  subnet_id                   = aws_subnet.financial-management-public-us-east-1b.id
  key_name                    = "ec2api"
  iam_instance_profile        = aws_iam_instance_profile.ec2_instance_profile.name
  user_data                   = "#!/bin/bash\necho ECS_CLUSTER=${aws_ecs_cluster.financial-management-cluster.name} >> /etc/ecs/ecs.config"

  depends_on = [aws_ecs_cluster.financial-management-cluster]

  tags = {
    Name        = var.name
    Environment = var.env
    Provisioner = "Terraform"
    Repo        = var.repo
  }
  
 # lifecycle {
 #   prevent_destroy = true
 # }
}