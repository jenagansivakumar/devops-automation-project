resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.voting_app_vpc.id
  cidr_block              = var.subnets.public.cidr_block
  availability_zone       = var.subnets.public.availability_zone
  map_public_ip_on_launch = true
}

resource "aws_subnet" "private_subnet_a" {
  vpc_id            = aws_vpc.voting_app_vpc.id
  cidr_block        = var.subnets.private_a.cidr_block
  availability_zone = var.subnets.private_a.availability_zone
}

resource "aws_subnet" "private_subnet_b" {
  vpc_id            = aws_vpc.voting_app_vpc.id
  cidr_block        = var.subnets.private_b.cidr_block
  availability_zone = var.subnets.private_b.availability_zone
}

resource "aws_subnet" "private_subnet_c" {
  vpc_id            = aws_vpc.voting_app_vpc.id
  cidr_block        = var.subnets.private_c.cidr_block
  availability_zone = var.subnets.private_c.availability_zone
}