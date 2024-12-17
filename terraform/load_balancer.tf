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

resource "aws_lb_listener" "http_listener" {
  load_balancer_arn = aws_lb.app_lb.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    type = "forward"
    forward {
      target_group {
        arn = aws_lb_target_group.tg1.arn
      }
    }
  }
}
resource "aws_lb_listener" "tcp_listener" {
  load_balancer_arn = aws_lb.app_lb.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    type = "forward"
    forward {
      target_group {
        arn = aws_lb_target_group.tg2.arn
      }
    }
  }
}