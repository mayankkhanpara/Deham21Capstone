# Security Group for Frontend (Public Access)
resource "aws_security_group" "frontend_sg" {
  name        = "tadka-frontend-sg"
  description = "Allow HTTP/HTTPS from anywhere"
  vpc_id      = aws_vpc.tadka_vpc.id

  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "tadka-frontend-sg"
  }
}

# Security Group for Laravel Backend (Private)
resource "aws_security_group" "laravel_sg" {
  name        = "tadka-laravel-sg"
  description = "Allow HTTP from frontend and SSH from bastion"
  vpc_id      = aws_vpc.tadka_vpc.id

  # ✅ Allow HTTP (port 80) from frontend/load balancer
  ingress {
    description     = "Allow HTTP from frontend SG"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.frontend_sg.id]
  }

  # ✅ Allow SSH (port 22) from bastion host
  ingress {
    description     = "Allow SSH from bastion SG"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.bastion_sg.id]
  }

  # Outbound allowed to all
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "tadka-laravel-sg"
  }
}
