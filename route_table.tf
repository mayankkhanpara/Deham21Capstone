# Public Route Table for Frontend & Load Balancer
resource "aws_route_table" "tadka_public_rt" {
  vpc_id = aws_vpc.tadka_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.tadka_igw.id
  }

  tags = {
    Name = "tadka-public-rt"
  }
}

# Associate Public Subnets (frontend)
resource "aws_route_table_association" "public_1_assoc" {
  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.tadka_public_rt.id
}

resource "aws_route_table_association" "public_2_assoc" {
  subnet_id      = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.tadka_public_rt.id
}

# ✅ Private Route Table with NAT Gateway route for backend EC2
resource "aws_route_table" "tadka_private_rt" {
  vpc_id = aws_vpc.tadka_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.tadka_nat.id
  }

  tags = {
    Name = "tadka-private-rt"
  }
}

# Associate Private Subnets (Laravel backend)
resource "aws_route_table_association" "private_1_assoc" {
  subnet_id      = aws_subnet.private_subnet_1.id
  route_table_id = aws_route_table.tadka_private_rt.id
}

resource "aws_route_table_association" "private_2_assoc" {
  subnet_id      = aws_subnet.private_subnet_2.id
  route_table_id = aws_route_table.tadka_private_rt.id
}