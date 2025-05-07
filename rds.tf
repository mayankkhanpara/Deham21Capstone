# RDS Subnet Group (using private subnets)
resource "aws_db_subnet_group" "tadka_rds_subnet_group" {
  name       = "tadka-rds-subnet-group"
  subnet_ids = [aws_subnet.private_subnet_1.id, aws_subnet.private_subnet_2.id]

  tags = {
    Name = "tadka-rds-subnet-group"
  }
}

# Security Group for RDS (only Laravel EC2 SG can connect)
resource "aws_security_group" "rds_sg" {
  name        = "tadka-rds-sg"
  description = "Allow DB access from Laravel SG"
  vpc_id      = aws_vpc.tadka_vpc.id

  ingress {
    description     = "Allow MySQL/MariaDB from Laravel SG"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.laravel_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "tadka-rds-sg"
  }
}

# RDS Instance (MariaDB or MySQL)
resource "aws_db_instance" "tadka_rds" {
  identifier         = "tadkatwist-db"
  engine             = "mariadb"
  engine_version     = "10.6.14"
  instance_class     = "db.t3.micro"
  allocated_storage  = 20
  storage_type       = "gp2"
  db_name            = var.db_name
  username           = var.db_user
  password           = var.db_pass
  db_subnet_group_name   = aws_db_subnet_group.tadka_rds_subnet_group.name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  multi_az           = false
  publicly_accessible = false
  skip_final_snapshot = true

  tags = {
    Name = "tadka-twist-rds"
  }
}
