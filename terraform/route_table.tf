resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.voting_app_vpc.id

  route {
    cidr_block = var.rt_cidr_block
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = var.rt_name
  }
}

resource "aws_route_table_association" "public_subnet" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.voting_app_vpc.id
  
  tags = {
    Name = "private-route-table"
    }
}

resource "aws_route" "private_route_table" {
  route_table_id         = aws_route_table.private_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat_gateway.id
}

