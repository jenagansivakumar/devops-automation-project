resource "aws_instance" "vote_instance" {
  ami           = var.ami_id
  instance_type = var.instance_type

  subnet_id              = aws_subnet.private_subnet_a.id
  vpc_security_group_ids = [aws_security_group.vote_sg.id]

  tags = {
    Name = var.instances.vote.name
  }
}
resource "aws_instance" "master_instance" {
  ami           = var.ami_id
  instance_type = var.instance_type

  subnet_id              = aws_subnet.public_subnet.id
  vpc_security_group_ids = [aws_security_group.public_sg.id]

  tags = {
    Name = "master_instance"
  }
}

resource "aws_instance" "redis_worker_instance" {
  ami           = var.ami_id
  instance_type = var.instance_type

  subnet_id              = aws_subnet.private_subnet_b.id
  vpc_security_group_ids = [aws_security_group.redis_worker_sg.id]

  tags = {
    Name = var.instances.worker.name
  }
}

resource "aws_instance" "postgres_instance" {
  ami           = var.ami_id
  instance_type = var.instance_type

  subnet_id = aws_subnet.private_subnet_c.id

  vpc_security_group_ids = [aws_security_group.postgres_sg.id]

  tags = {
    Name = var.instances.postgres.name
  }
}
