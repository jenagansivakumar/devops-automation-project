resource "aws_vpc" "voting-app-vpc" {
  cidr_block = "10.0.0.0/16"
}