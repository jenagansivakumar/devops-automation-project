resource "aws_lb" "app_lb" {
 name = "voting-app-lb"
 internal = false 
 load_balancer_type = "application"
 security_groups = [aws_security_group.alb_sg.id]
 subnets = [aws_subnet.public_subnet.id,aws_subnet.private_subnet_b.id]

 enable_deletion_protection = false
 enable_cross_zone_load_balancing = true 
 idle_timeout = 60 
}
