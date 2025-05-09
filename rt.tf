# Public Route Table
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.tadka_twist_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.tadka_twist_igw.id
  }

  tags = {
    Name = "tadka-twist-public-rt"
  }
}

# Associate Public Subnet with Public Route Table
resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_rt.id
}

# Private Route Table (no route to IGW)
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.tadka_twist_vpc.id

  tags = {
    Name = "tadka-twist-private-rt"
  }
}

# Associate Private Subnet with Private Route Table
resource "aws_route_table_association" "private_assoc" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.private_rt.id
}
