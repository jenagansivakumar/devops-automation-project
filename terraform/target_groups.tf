resource "aws_lb_target_group" "vote_result_tg" {
 name = "vote-tg"
 port = "80"
 protocol = "HTTP"

 health_check {
 path = "/health-check-path"
 interval = 30
 timeout = 5
 healthy_threshold = 5
 unhealthy_threshold = 3
}

 vpc_id= aws_vpc.voting_app_vpc.id 
}
