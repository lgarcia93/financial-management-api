resource "aws_instance" "instance-01" {
  ami                         = var.ami
  instance_type               = var.instance_type
  associate_public_ip_address = true
  security_groups             = [aws_security_group.ec2-sg.id]
  subnet_id                   = aws_subnet.public-us-east-1a.id
  key_name                    = "ec2api"
  iam_instance_profile        = aws_iam_instance_profile.ec2_instance_profile.name
  user_data                   = "#!/bin/bash\necho ECS_CLUSTER=${aws_ecs_cluster.cluster.name} >> /etc/ecs/ecs.config"

  depends_on = [aws_ecs_cluster.cluster]

  tags = {
    Name        = "${var.app_name}-instance-01"
    Environment = var.env
    Provisioner = "Terraform"
  }
}

resource "aws_instance" "instance-02" {
  ami                         = var.ami
  instance_type               = var.instance_type
  associate_public_ip_address = true
  security_groups             = [aws_security_group.ec2-sg.id]
  subnet_id                   = aws_subnet.public-us-east-1b.id
  key_name                    = "ec2api"
  iam_instance_profile        = aws_iam_instance_profile.ec2_instance_profile.name
  user_data                   = "#!/bin/bash\necho ECS_CLUSTER=${aws_ecs_cluster.cluster.name} >> /etc/ecs/ecs.config"

  depends_on = [aws_ecs_cluster.cluster]

  tags = {
    Name        = "${var.app_name}-instance-02"
    Environment = var.env
    Provisioner = "Terraform"
  }  
}