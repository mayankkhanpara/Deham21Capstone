provider "aws" {
  region = "eu-central-1" # Frankfurt
}

resource "aws_vpc" "tadka_twist_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "tadka-twist-vpc"
  }
}
