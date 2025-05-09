resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.tadka_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "eu-central-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "tadka-public-subnet"
    Project = "Tadka Twist"
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id            = aws_vpc.tadka_vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "eu-central-1b"
  tags = {
    Name = "tadka-private-subnet"
    Project = "Tadka Twist"
  }
}
