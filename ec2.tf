# Get latest Amazon Linux 2 AMI in eu-central-1
data "aws_ami" "amazon_linux" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["137112412989"] # Amazon official
}

# Read and inject user_data template with DB credentials
data "template_file" "user_data" {
  template = file("${path.module}/templates/user_data.sh")

  vars = {
    DB_NAME = var.db_name
    DB_USER = var.db_user
    DB_PASS = var.db_pass
  }
}

# Launch EC2 instance
resource "aws_instance" "laravel_backend" {
  ami                         = data.aws_ami.amazon_linux.id
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.private_subnet_1.id
  vpc_security_group_ids      = [aws_security_group.laravel_sg.id]
  associate_public_ip_address = true
  key_name                    = "tadka-twist-204"

  user_data = data.template_file.user_data.rendered

  tags = {
    Name = "tadka-laravel-backend-ec2"
  }
}