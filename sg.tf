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

  # Allow SSH access only from the Bastion host
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [aws_security_group.bastion_sg.ingress[0].cidr_blocks[0]]
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