# Get the latest Amazon Linux 2 AMI (Frankfurt region)
data "aws_ami" "amazon_linux_2" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  owners = ["137112412989"] # Amazon
}

# Bastion Host in Public Subnet
resource "aws_instance" "bastion" {
  ami                    = data.aws_ami.amazon_linux_2.id
  instance_type          = var.aws_instance_type_t2micro
  availability_zone      = var.aws_availability_zone_a
  subnet_id              = aws_subnet.public_subnet.id
  vpc_security_group_ids = [aws_security_group.bastion_sg.id]
  key_name               = "vockey"
  user_data              = file("bastion-userdata.sh")

  tags = {
    Name = "tadka-twist-bastion-host"
  }
}

# Laravel App EC2 in Private Subnet
resource "aws_instance" "laravel_app" {
  ami                    = data.aws_ami.amazon_linux_2.id
  instance_type          = var.aws_instance_type_t2micro
  availability_zone      = var.aws_availability_zone_a
  subnet_id              = aws_subnet.private_subnet.id
  vpc_security_group_ids = [aws_security_group.app_sg.id]
  key_name               = "vockey"
  user_data              = file("app-userdata.sh")

  tags = {
    Name = "tadka-twist-laravel-app"
  }
}
