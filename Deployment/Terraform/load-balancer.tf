#Security Group for the ALB

resource "aws_security_group" "alb_security_group" {
  vpc_id = aws_vpc.vpc.id
  name   = "${var.app_name}-alb"

  ingress {
    from_port   = var.app_port
    protocol    = "tcp"
    to_port     = var.app_port
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group_rule" "sg_alb_egress_5000" {
  from_port                = var.app_port
  protocol                 = "tcp"
  security_group_id        = aws_security_group.alb_security_group.id
  to_port                  = var.app_port
  type                     = "egress"
  source_security_group_id = aws_security_group.ec2-sg.id
}


resource "aws_lb" "alb" {
  name               = "${var.app_name}-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups = [
    aws_security_group.alb_security_group.id
  ]
  
  subnets = [aws_subnet.public-us-east-1a.id, aws_subnet.public-us-east-1b.id]
}

resource "aws_lb_target_group" "alb-tg-5000-alb" {
  name        = "alb-tg-${var.app_port}-alb"
  port        = var.app_port
  protocol    = "HTTP"
  vpc_id      = aws_vpc.vpc.id
  target_type = "instance"
}

resource "aws_lb_listener" "alb_service_listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = var.app_port
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb-tg-5000-alb.arn
  }
}

#Creating load balancer target group attachment (adding our EC2)
resource "aws_lb_target_group_attachment" "tg-attachment-instance-01" {
  target_group_arn = aws_lb_target_group.alb-tg-5000-alb.arn
  target_id        = aws_instance.instance-01.id
  port             = var.app_port
}

#Creating load balancer target group attachment (adding our EC2)
resource "aws_lb_target_group_attachment" "tg-attachment-instance-02" {
  target_group_arn = aws_lb_target_group.alb-tg-5000-alb.arn
  target_id        = aws_instance.instance-02.id
  port             = var.app_port
}
