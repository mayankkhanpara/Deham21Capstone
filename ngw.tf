# 1. Allocate Elastic IP
resource "aws_eip" "nat_eip" {
  vpc = true
  tags = {
    Name = "tadka-twist-nat-eip"
  }
}

# 2. Create NAT Gateway in Public Subnet
resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_subnet_1.id

  tags = {
    Name = "tadka-twist-nat-gw"
  }
}

# 3. Route Table for Private Subnet
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.tadka_twist_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gw.id
  }

  tags = {
    Name = "tadka-twist-private-rt"
  }
}

# 4. Associate Route Table to Private Subnet A
resource "aws_route_table_association" "private_subnet_1_association" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.private_rt.id
}

# 5. Associate Route Table to Private Subnet B (if any)
resource "aws_route_table_association" "private_subnet_2_association" {
  subnet_id      = aws_subnet.private_subnet_b.id
  route_table_id = aws_route_table.private_rt.id
}