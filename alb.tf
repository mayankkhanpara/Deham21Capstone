# Create Target Group
resource "aws_lb_target_group" "tadka_twist_tg" {
  name     = "tadka-twist-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.tadka_twist_vpc.id
  target_type = "instance"

  health_check {
  path                = "/login"
  protocol            = "HTTP"
  interval            = 30
  timeout             = 5
  healthy_threshold   = 2
  unhealthy_threshold = 2
  matcher             = "200-499"  # <- Accept 422, 403, etc.
}

  tags = {
    Name = "tadka-twist-tg"
  }
}

# Attach EC2 app instance to Target Group
resource "aws_lb_target_group_attachment" "tadka_twist_tg_attach" {
  target_group_arn = aws_lb_target_group.tadka_twist_tg.arn
  target_id        = aws_instance.laravel_app.id
  port             = 80
}

# Create ALB
resource "aws_lb" "tadka_twist_alb" {
  name               = "tadka-twist-alb"
  internal           = false
  load_balancer_type = "application"
  subnets            = [
    aws_subnet.public_subnet.id,
    aws_subnet.public_subnet_b.id
  ]
  security_groups    = [aws_security_group.app_sg.id]

  tags = {
    Name = "tadka-twist-alb"
  }
}


# ALB Listener
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.tadka_twist_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tadka_twist_tg.arn
  }
}
