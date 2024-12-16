resource "aws_security_group" "alb_sg" {
  name        = var.sg.alb.name
  description = var.sg.alb.description
  vpc_id      = aws_vpc.voting_app_vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "vote_sg" {
  name        = var.sg.vote.name
  description = var.sg.vote.description
  vpc_id      = aws_vpc.voting_app_vpc.id

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.alb_sg.id] # Allow traffic from ALB
  }
}

resource "aws_security_group" "redis_worker_sg" {
  name        = var.sg.worker.name
  description = var.sg.worker.description
  vpc_id      = aws_vpc.voting_app_vpc.id

  ingress {
    from_port       = 6379
    to_port         = 6379
    protocol        = "tcp"
    security_groups = [aws_security_group.vote_sg.id] # Allow traffic from Vote service
  }
}

resource "aws_security_group" "postgres_sg" {
  name        = var.sg.postgres.name
  description = var.sg.postgres.description
  vpc_id      = aws_vpc.voting_app_vpc.id

  ingress {
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [aws_security_group.redis_worker_sg.id] # Allow traffic from Redis Worker service
  }
}
