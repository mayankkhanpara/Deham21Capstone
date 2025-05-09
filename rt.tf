resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.tadka_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.tadka_igw.id
  }

  tags = {
    Name    = "tadka-public-route-table"
    Project = "Tadka Twist"
  }
}

resource "aws_route_table_association" "public_route_association" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.tadka_vpc.id

  tags = {
    Name    = "tadka-private-route-table"
    Project = "Tadka Twist"
  }
}

resource "aws_route_table_association" "private_route_association" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.private_route_table.id
}
