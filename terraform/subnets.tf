resource "aws_subnet" "public_subnet" {
  vpc_id = aws_vpc.voting-app-vpc.id
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone = "eu-north-1a"
}

resource "aws_subnet" "private_subnet_a" {
  vpc_id = aws_vpc.voting-app-vpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "eu-north-1a"
}

resource "aws_subnet" "private_subnet_b" {
  vpc_id = aws_vpc.voting-app-vpc.id
  cidr_block = "10.0.3.0/24"
  availability_zone = "eu-north-1b"
}

resource "aws_subnet" "private_subnet_c" {
  vpc_id = aws_vpc.voting-app-vpc.id
  cidr_block = "10.0.4.0/24"
  availability_zone = "eu-north-1c"
}