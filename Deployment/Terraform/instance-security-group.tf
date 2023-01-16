resource "aws_security_group" "ec2-sg" {
  name   = "financial-management-sg"
  vpc_id = aws_vpc.financial-management-vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  #Financial Service
  ingress {
    from_port = 5000
    protocol  = "tcp"
    to_port   = 5000
    #Accept requests on port 80 only from Network Load Balancer
    security_groups = [
      aws_security_group.alb_security_group.id
    ]    
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}