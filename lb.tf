resource "aws_lb" "tadka_alb" {
  name               = "tadka-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups   = [aws_security_group.alb_sg.id]
  subnets            = [aws_subnet.public_subnet.id]
  enable_deletion_protection = false

  enable_cross_zone_load_balancing = true

  tags = {
    Name    = "Tadka Twist ALB"
    Project = "Tadka Twist"
  }
}

resource "aws_lb_target_group" "tadka_alb_target_group" {
  name     = "tadka-alb-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.tadka_vpc.id

  health_check {
    path                = "/health"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 3
    unhealthy_threshold = 3
  }
}

resource "aws_lb_listener" "tadka_alb_listener" {
  load_balancer_arn = aws_lb.tadka_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "fixed-response"
    fixed_response {
      status_code = 200
      content_type = "text/plain"
      message_body = "Healthy"
    }
  }
}
