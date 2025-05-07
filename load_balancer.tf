# ALB Security Group (Allow HTTP from anywhere)
resource "aws_security_group" "alb_sg" {
  name        = "tadka-alb-sg"
  description = "Allow HTTP access to ALB"
  vpc_id      = aws_vpc.tadka_vpc.id

  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "tadka-alb-sg"
  }
}

# Target Group for backend EC2
resource "aws_lb_target_group" "tadka_tg" {
  name        = "tadka-target-group"
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = aws_vpc.tadka_vpc.id

  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
    matcher             = "200-399" # Laravel install returns 302
  }

  tags = {
    Name = "tadka-target-group"
  }
}

# Attach EC2 instance to target group
resource "aws_lb_target_group_attachment" "tadka_tg_attachment" {
  target_group_arn = aws_lb_target_group.tadka_tg.arn
  target_id        = aws_instance.laravel_backend.id
  port             = 80
}

# Application Load Balancer
resource "aws_lb" "tadka_alb" {
  name               = "tadka-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = [
    aws_subnet.public_subnet_1.id,
    aws_subnet.public_subnet_2.id
  ]

  tags = {
    Name = "tadka-alb"
  }
}

# HTTP Listener
resource "aws_lb_listener" "tadka_listener" {
  load_balancer_arn = aws_lb.tadka_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tadka_tg.arn
  }
}

# ✅ Output for browser access
output "alb_dns_name" {
  description = "Public DNS of the Application Load Balancer"
  value       = aws_lb.tadka_alb.dns_name
}
