resource "aws_lb_target_group" "tg1" {
  name     = "berliners1"
  port     = 80
  protocol = "HTTP"

  health_check {
    path                = "/health-check-path"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 3
  }

  vpc_id = aws_vpc.voting_app_vpc.id
}
resource "aws_lb_target_group" "tg2" {
  name     = "berliners2"
  port     = 80
  protocol = "HTTP"

  health_check {
    path                = "/health-check-path"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 3
  }

  vpc_id = aws_vpc.voting_app_vpc.id
}