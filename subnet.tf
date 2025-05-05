resource "aws_subnet" "public_subnet_1" {
  vpc_id            = aws_vpc.tadka_twist_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "eu-central-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "tadka-twist-public-subnet-1"
    Tier = "Public"
  }
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id            = aws_vpc.tadka_twist_vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "eu-central-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "tadka-twist-public-subnet-2"
    Tier = "Public"
  }
}

resource "aws_subnet" "private_subnet_1" {
  vpc_id            = aws_vpc.tadka_twist_vpc.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "eu-central-1a"

  tags = {
    Name = "tadka-twist-private-subnet-1"
    Tier = "Private"
  }
}

resource "aws_subnet" "private_subnet_2" {
  vpc_id            = aws_vpc.tadka_twist_vpc.id
  cidr_block        = "10.0.4.0/24"
  availability_zone = "eu-central-1b"

  tags = {
    Name = "tadka-twist-private-subnet-2"
    Tier = "Private"
  }
}
