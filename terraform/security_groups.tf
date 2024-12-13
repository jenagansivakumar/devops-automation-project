resource "aws_security_group" "alb_sg" {
  name        = "alb_security_group"
  description = "Allows incoming HTTP/HTTPS from the internet."
  vpc_id      = aws_vpc.voting-app-vpc.id

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
  name        = "app_security_group"
  description = "Allows inbound traffic only from the ALB (on HTTP ports). Outbound should allow connections to Redis and Postgres."
  vpc_id      = aws_vpc.voting-app-vpc.id

  ingress {
    from_port               = 80
    to_port                 = 80
    protocol                = "tcp"
    security_groups         = [aws_security_group.alb_sg.id] # Allow traffic from ALB
  }
}

resource "aws_security_group" "redis_worker_sg" {
  name        = "redis_worker_security_group"
  description = "Allows inbound traffic from Vote/Result EC2 to Redis port (6379), and allows outbound to Postgres."
  vpc_id      = aws_vpc.voting-app-vpc.id

  ingress {
    from_port               = 6379
    to_port                 = 6379
    protocol                = "tcp"
    security_groups         = [aws_security_group.vote_sg.id] # Allow traffic from Vote service
  }
}

resource "aws_security_group" "postgres_sg" {
  name        = "postgres_security_group"
  description = "Allows inbound traffic on port 5432 only from the Worker SG (and possibly from Vote/Result if needed directly)."
  vpc_id      = aws_vpc.voting-app-vpc.id

  ingress {
    from_port               = 5432
    to_port                 = 5432
    protocol                = "tcp"
    security_groups         = [aws_security_group.redis_worker_sg.id] # Allow traffic from Redis Worker service
  }
}
