#Security Group for the ALB

resource "aws_security_group" "alb_security_group" {
  vpc_id = aws_vpc.financial-management-vpc.id
  name   = "financial-service-alb"

  ingress {
    from_port   = 5000
    protocol    = "tcp"
    to_port     = 5000
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group_rule" "sg_alb_egress_5000" {
  from_port                = 5000
  protocol                 = "tcp"
  security_group_id        = aws_security_group.alb_security_group.id
  to_port                  = 5000
  type                     = "egress"
  source_security_group_id = aws_security_group.ec2-sg.id
  #cidr_blocks = ["0.0.0.0/0"]
}


resource "aws_lb" "financial-management-alb" {
  name               = "financial-management-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups = [
    aws_security_group.alb_security_group.id
  ]
  
  subnets = [aws_subnet.financial-management-public-us-east-1a.id, aws_subnet.financial-management-public-us-east-1b.id]
}

resource "aws_lb_target_group" "alb-tg-5000-alb" {
  name        = "alb-tg-5000-alb"
  port        = 5000
  protocol    = "HTTP"
  vpc_id      = aws_vpc.financial-management-vpc.id
  target_type = "instance"
}

resource "aws_lb_listener" "alb_products_listener" {
  load_balancer_arn = aws_lb.financial-management-alb.arn
  port              = 5000
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb-tg-5000-alb.arn
  }
}

#Creating load balancer target group attachment (adding our EC2)
resource "aws_lb_target_group_attachment" "tg-attachment-financial-management-01" {
  target_group_arn = aws_lb_target_group.alb-tg-5000-alb.arn
  target_id        = aws_instance.financial-management-instance-01.id
  port             = 5000
}

#Creating load balancer target group attachment (adding our EC2)
resource "aws_lb_target_group_attachment" "tg-attachment-financial-management-02" {
  target_group_arn = aws_lb_target_group.alb-tg-5000-alb.arn
  target_id        = aws_instance.financial-management-instance-02.id
  port             = 5000
}
