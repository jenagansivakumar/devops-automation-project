resource "aws_lb_target_group" "tg1" {
  name     = "berliners1"
  port     = var.tg.berliners1.port
  protocol = var.tg.berliners1.protocol

  health_check {
    path                = var.tg.berliners1.path
    interval            = var.tg.berliners1.interval
    timeout             = var.tg.berliners1.timeout
    healthy_threshold   = var.tg.berliners1.healthy_threshold
    unhealthy_threshold = var.tg.berliners1.unhealthy_threshold
  }

  vpc_id = aws_vpc.voting_app_vpc.id
}
resource "aws_lb_target_group" "tg2" {
  name     = "berliners2"
  port     = var.tg.berliners2.port
  protocol = var.tg.berliners2.protocol

  health_check {
    path                = var.tg.berliners2.path
    interval            = var.tg.berliners2.interval
    timeout             = var.tg.berliners2.timeout
    healthy_threshold   = var.tg.berliners2.healthy_threshold
    unhealthy_threshold = var.tg.berliners2.unhealthy_threshold
  }

  vpc_id = aws_vpc.voting_app_vpc.id
}