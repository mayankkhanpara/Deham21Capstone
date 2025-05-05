# Lookup latest Amazon Linux 2 AMI
data "aws_ami" "bastion_ami" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["137112412989"] # Amazon
}

# Security group to allow SSH from your IP
resource "aws_security_group" "bastion_sg" {
  name        = "tadka-bastion-sg"
  description = "Allow SSH to bastion"
  vpc_id      = aws_vpc.tadka_vpc.id

  ingress {
    description = "SSH from my IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["84.143.29.54/32"] # 🔒 Replace with your real IP
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "tadka-bastion-sg"
  }
}

# Bastion EC2 instance in public subnet
resource "aws_instance" "bastion_host" {
  ami                         = data.aws_ami.bastion_ami.id
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.public_subnet_1.id
  vpc_security_group_ids      = [aws_security_group.bastion_sg.id]
  associate_public_ip_address = true
  key_name                    = "tadka-twist-204"

  tags = {
    Name = "tadka-bastion"
  }
}
