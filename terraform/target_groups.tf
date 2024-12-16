resource "aws_lb_target_group" "vote_result_tg" {
  name     = var.tg.name
  port     = var.tg.port
  protocol = var.tg.protocol

  health_check {
    path                = var.tg.path
    interval            = var.tg.interval
    timeout             = var.tg.timeout
    healthy_threshold   = var.tg.healthy_threshold
    unhealthy_threshold = var.tg.unhealthy_threshold
  }

  vpc_id = aws_vpc.voting_app_vpc.id
}
