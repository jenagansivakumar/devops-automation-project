resource "aws_lb" "app_lb" {
  name               = var.alb_name
  internal           = var.alb_internal
  load_balancer_type = var.alb_type
  security_groups    = [aws_security_group.alb_sg.id]
  subnets = [
    aws_subnet.public_subnet.id,
    aws_subnet.private_subnet_b.id
  ]

  enable_deletion_protection       = var.alb_deletion_protection
  enable_cross_zone_load_balancing = var.alb_cross_zone
  idle_timeout                     = var.alb_idle_timeout
}
