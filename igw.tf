# Create Internet Gateway
resource "aws_internet_gateway" "tadka_twist_igw" {
  vpc_id = aws_vpc.tadka_twist_vpc.id

  tags = {
    Name = "tadka-twist-igw"
  }
}
