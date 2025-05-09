# Bastion Host Security Group (Public Subnet)
resource "aws_security_group" "bastion_sg" {
  vpc_id = aws_vpc.tadka_vpc.id

  # Allow SSH access from anywhere (or restrict to specific IPs for more security)
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Replace with a specific IP for better security
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "tadka-bastion-sg"
    Project = "Tadka Twist"
  }
}

# EC2 Instance Security Group (Private Subnet)
resource "aws_security_group" "ec2_sg" {
  vpc_id = aws_vpc.tadka_vpc.id

  # Allow SSH access only from the Bastion host (security group reference)
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    security_groups = [aws_security_group.bastion_sg.id] # Use security group ID
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "tadka-ec2-sg"
    Project = "Tadka Twist"
  }
}


# ALB Security Group
resource "aws_security_group" "alb_sg" {
  vpc_id = aws_vpc.tadka_vpc.id

  # Allow HTTP and HTTPS traffic
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
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
    Name    = "tadka-alb-sg"
    Project = "Tadka Twist"
  }
}
