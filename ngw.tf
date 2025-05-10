# 1. Allocate Elastic IP for NAT Gateway
resource "aws_eip" "nat_eip" {
  vpc = true
  tags = {
    Name = "tadka-twist-nat-eip"
  }
}

# 2. NAT Gateway in Public Subnet
resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_subnet.id

  tags = {
    Name = "tadka-twist-nat-gw"
  }
}

# 3. Add NAT route to existing private_rt
resource "aws_route" "private_rt_nat_route" {
  route_table_id         = aws_route_table.private_rt.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat_gw.id
}