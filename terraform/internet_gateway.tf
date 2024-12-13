resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.voting-app-vpc.id

    tags = {
      Name = "gui-igw"
    }
}