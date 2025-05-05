data "template_file" "user_data" {
  template = file("${path.module}/templates/user_data.sh")

  vars = {
    DB_NAME = var.db_name
    DB_USER = var.db_user
    DB_PASS = var.db_pass
  }
}

resource "aws_instance" "laravel_backend" {
  ami                         = "ami-0faab6bdbac9486fb"
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.private_subnet_1.id
  vpc_security_group_ids      = [aws_security_group.laravel_sg.id]
  associate_public_ip_address = false
  key_name                    = "tadka-twist-204"

  user_data = data.template_file.user_data.rendered

  tags = {
    Name = "tadka-laravel-backend-ec2"
  }
}

