# DB Subnet Group (includes the private subnet)
resource "aws_db_subnet_group" "tadka_twist_db_subnet_group" {
  name       = "tadka-twist-db-subnet-group"
  subnet_ids = [
    aws_subnet.private_subnet.id
    aws_subnet.private_subnet_b.id
    ]
  tags = {
    Name = "tadka-twist-db-subnet-group"
  }
}

# RDS MySQL Instance
resource "aws_db_instance" "tadka_twist_db" {
  identifier              = "tadka-twist-db"
  engine                  = "mysql"
  engine_version          = "8.0"
  instance_class          = var.rds_instance_type
  allocated_storage       = 20
  max_allocated_storage   = 100
  db_subnet_group_name    = aws_db_subnet_group.tadka_twist_db_subnet_group.name
  vpc_security_group_ids  = [aws_security_group.rds_sg.id]
  publicly_accessible     = false
  skip_final_snapshot     = true
  deletion_protection     = false

  # 👇 Use your custom variables
  db_name     = var.db_name
  username = var.db_user
  password = var.db_pass

  tags = {
    Name = "tadka-twist-rds-mysql"
  }
}