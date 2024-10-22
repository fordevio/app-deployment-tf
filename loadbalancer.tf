// Loadbalancer to distribute traffic between the two instances
resource "aws_lb" "aws_lb" {
  name               = "awslb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = [aws_subnet.public_a.id, aws_subnet.public_b.id]

  enable_deletion_protection = false

  idle_timeout               = 60
  drop_invalid_header_fields = true
}

//  Target group to route traffic to the instances
resource "aws_lb_target_group" "aws_lb_target_group" {
  name     = "aws-lb-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    port                = "traffic-port"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

// Listener to listen to incoming traffic
resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.aws_lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.aws_lb_target_group.arn
  }
}

resource "aws_lb_target_group_attachment" "aws_lb_tg_attc_a" {
  target_group_arn = aws_lb_target_group.aws_lb_target_group.arn
  target_id        = aws_instance.private_instance_a.id
  port             = 80

}

resource "aws_lb_target_group_attachment" "aws_lb_tg_attc_b" {
  target_group_arn = aws_lb_target_group.aws_lb_target_group.arn
  target_id        = aws_instance.private_instance_b.id
  port             = 80
}