resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.voting_app_vpc.id

  tags = {
    Name = var.igw
  }
}


