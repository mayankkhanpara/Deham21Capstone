resource "aws_internet_gateway" "tadka_igw" {
  vpc_id = aws_vpc.tadka_vpc.id

  tags = {
    Name    = "tadka-internet-gateway"
    Project = "Tadka Twist"
  }
}
