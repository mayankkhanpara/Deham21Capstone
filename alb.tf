# Security Group for ALB
resource "aws_security_group" "alb_sg" {
  name        = "tadka-alb-sg"
  description = "Allow HTTP from internet to ALB"
  vpc_id      = aws_vpc.tadka_vpc.id

  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
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

# Target Group for Laravel EC2
resource "aws_lb_target_group" "tadka_backend_tg" {
  name     = "tadka-backend-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.tadka_vpc.id

  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 3
    unhealthy_threshold = 3
    matcher             = "200-399"
  }

  target_type = "instance"
}

# Attach EC2 to Target Group
resource "aws_lb_target_group_attachment" "tadka_backend_attach" {
  target_group_arn = aws_lb_target_group.tadka_backend_tg.arn
  target_id        = aws_instance.laravel_backend.id
  port             = 80
}

# ALB
resource "aws_lb" "tadka_alb" {
  name               = "tadka-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = [
    aws_subnet.public_subnet_1.id,
    aws_subnet.public_subnet_2.id
  ]

  enable_deletion_protection = false
}

# ALB Listener (HTTP)
resource "aws_lb_listener" "tadka_alb_http" {
  load_balancer_arn = aws_lb.tadka_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tadka_backend_tg.arn
  }
}
