resource "aws_vpc" "voting_app_vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
    Name = "voting-app-vpc"
  }
}
