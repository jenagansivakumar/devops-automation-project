resource "aws_instance" "vote_instance" {
  ami = "ami-05edb7c94b324f73c"
  instance_type = "t3.micro"
  
  subnet_id = aws_subnet.private_subnet_a.id
  vpc_security_group_ids = [aws_security_group.vote_sg.id]

  tags = {
    Name = "vote-ec2"
  }
}

resource "aws_instance" "redis_worker_instance" {
  ami = "ami-05edb7c94b324f73c"
  instance_type = "t3.micro"

  subnet_id = aws_subnet.private_subnet_b.id
  vpc_security_group_ids = [aws_security_group.redis_worker_sg.id]

  tags = {
    Name = "redis-worker-ec2"
   }
}

resource "aws_instance" "postgres_instance" {
   ami = "ami-05edb7c94b324f73c"
   instance_type = "t3.micro"

   subnet_id = "${aws_subnet.private_subnet_c.id}"
   
   vpc_security_group_ids = [aws_security_group.postgres_sg.id]

   tags = {
      Name = "postgres-ec2"
   }
}
