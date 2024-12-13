terraform {
    required_providers {
      aws = {
        source = "hashicorp/aws"
        version = "~> 5.0"
      }
    }
}

resource "aws_vpc" "multistack_devops" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "ec2-app-vpc"
  }
}


resource "aws_subnet" "name" {
  
}