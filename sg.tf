# Replace this with your IP address (get via https://whatismyipaddress.com/)
variable "my_ip" {
  default = "YOUR.IP.ADDRESS.HERE/32"
}

# Security Group for Bastion Host (public subnet)
resource "aws_security_group" "bastion_sg" {
  name        = "bastion-sg"
  description = "Allow SSH from my IP"
  vpc_id      = aws_vpc.tadka_twist_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.my_ip]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "tadka-twist-bastion-sg"
  }
}

# Security Group for Private EC2 App
resource "aws_security_group" "app_sg" {
  name        = "app-sg"
  description = "Allow HTTP from ALB and SSH from Bastion"
  vpc_id      = aws_vpc.tadka_twist_vpc.id

  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.bastion_sg.id]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Will be refined when ALB is created
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "tadka-twist-app-sg"
  }
}

# Security Group for RDS
resource "aws_security_group" "rds_sg" {
  name        = "rds-sg"
  description = "Allow MySQL from App EC2 only"
  vpc_id      = aws_vpc.tadka_twist_vpc.id

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.app_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "tadka-twist-rds-sg"
  }
}
