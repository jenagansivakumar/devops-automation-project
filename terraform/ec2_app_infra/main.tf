terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
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

resource "aws_subnet" "subnets" {
  for_each = var.subnet_config
  vpc_id   = aws_vpc.multistack_devops.id
  cidr_block = each.value.cidr_block
  availability_zone = var.availability_zones[each.key]

  tags = {
    Name = each.key
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.multistack_devops.id
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.multistack_devops.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.subnets["public_subnet"].id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.multistack_devops.id
}

resource "aws_route_table_association" "private" {
  subnet_id      = aws_subnet.subnets["private_subnet"].id
  route_table_id = aws_route_table.private.id
}

resource "aws_security_group" "alb_sg" {
  vpc_id = aws_vpc.multistack_devops.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ALB-Security-Group"
  }
}

resource "aws_security_group" "frontend_sg" {
  vpc_id = aws_vpc.multistack_devops.id

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.alb_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Frontend-Security-Group"
  }
}

resource "aws_security_group" "backend_sg" {
  vpc_id = aws_vpc.multistack_devops.id

  ingress {
    from_port       = 6379
    to_port         = 6379
    protocol        = "tcp"
    security_groups = [aws_security_group.frontend_sg.id]
  }

  egress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  tags = {
    Name = "Backend-Security-Group"
  }
}

resource "aws_security_group" "db_sg" {
  vpc_id = aws_vpc.multistack_devops.id

  ingress {
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [aws_security_group.backend_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Database-Security-Group"
  }
}

resource "aws_instance" "frontend" {
  ami           = "ami-0abcdef1234567890"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.subnets["public_subnet"].id
  security_groups = [
    aws_security_group.frontend_sg.id
  ]

  tags = {
    Name = "Frontend-Instance"
  }
}
resource "aws_instance" "backend" {
  ami           = "ami-0abcdef1234567890" 
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.subnets["private_subnet"].id
  security_groups = [
    aws_security_group.backend_sg.id
  ]

  tags = {
    Name = "Backend-Instance"
  }
}


resource "aws_instance" "database" {
  ami           = "ami-0abcdef1234567890"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.subnets["private_subnet"].id
  security_groups = [
    aws_security_group.db_sg.id
  ]

  tags = {
    Name = "Database-Instance"
  }
}
