# Allocate Elastic IP for NAT Gateway
resource "aws_eip" "nat_eip" {
  vpc = true

  tags = {
    Name = "tadka-nat-eip"
  }
}

# NAT Gateway in the public subnet
resource "aws_nat_gateway" "tadka_nat" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_subnet_1.id

  tags = {
    Name = "tadka-nat-gateway"
  }

  depends_on = [aws_internet_gateway.tadka_igw]
}
