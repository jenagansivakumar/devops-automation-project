region        = "eu-north-1"
ami_id        = "ami-05edb7c94b324f73c"
instance_type = "t3.micro"
availability_zone = {
  public_subnet  = "eu-north-1a"
  private_subnet = "eu-north-1b"
}

vpc_name       = "voting-app-vpc"
vpc_cidr_block = "10.0.0.0/16"

subnets = {
  public = {
    cidr_block        = "10.0.0.0/18"
    availability_zone = "eu-north-1a"
  }
  private_a = {
    cidr_block        = "10.0.128.0/18"
    availability_zone = "eu-north-1a"
  }
  private_b = {
    cidr_block        = "10.0.192.0/18"
    availability_zone = "eu-north-1b"
  }
  private_c = {
    cidr_block        = "10.0.64.0/18"
    availability_zone = "eu-north-1c"
  }
}

tg = {
  name                = "vote-tg"
  port                = "80"
  protocol            = "HTTP"
  path                = "/health-check-path"
  interval            = 30
  timeout             = 5
  healthy_threshold   = 5
  unhealthy_threshold = 3
}

sg = {
  alb = {
    name        = "alb-sg"
    description = "Allow incomming HTTP/HTTPS from the internet."
  }
  vote = {
    name        = "vote-sg"
    description = "Allows inbound traffic only from the ALB (on HTTP ports). Outbound should allow connections to Redis and Postgres."
  }
  worker = {
    name        = "redis_worker_sg"
    description = "Allows inbound traffic from Vote/Result EC2 to Redis port (6379), and allows outbound to Postgres."
  }
  postgres = {
    name        = "postgres-sg"
    description = "Allows inbound traffic on port 5432 only from the Worker SG (and possibly from Vote/Result if needed directly)."
  }
}

instances = {
  vote = {
    name = "vote-ec2"
  }
  worker = {
    name = "redis-worker-ec2"
  }
  postgres = {
    name = "postgres-ec2"
  }
}

rt_name                 = "public-route-table"
rt_cidr_block           = "0.0.0.0/0"
alb_name                = "voting-app-lb"
alb_type                = "application"
alb_internal            = false
alb_deletion_protection = false
alb_cross_zone          = true
alb_idle_timeout        = 60
igw                     = "voting-app-igw"

 