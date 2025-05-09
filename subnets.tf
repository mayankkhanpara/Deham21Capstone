# Public Subnet
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.tadka_twist_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "eu-central-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "tadka-twist-public-subnet"
  }
}

# Public Subnet in eu-central-1b
resource "aws_subnet" "public_subnet_b" {
  vpc_id                  = aws_vpc.tadka_twist_vpc.id
  cidr_block              = "10.0.4.0/24"
  availability_zone       = "eu-central-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "tadka-twist-public-subnet-b"
  }
}


# Private Subnet
resource "aws_subnet" "private_subnet" {
  vpc_id            = aws_vpc.tadka_twist_vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "eu-central-1a"

  tags = {
    Name = "tadka-twist-private-subnet"
  }
}
# Private Subnet in eu-central-1b
resource "aws_subnet" "private_subnet_b" {
  vpc_id            = aws_vpc.tadka_twist_vpc.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "eu-central-1b"

  tags = {
    Name = "tadka-twist-private-subnet-b"
  }
}
