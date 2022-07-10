resource "aws_lb" "lampalb" {
  name               = "lamp-app-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb-sg.id]
  subnets            = [aws_subnet.lamp-public-subnet.id,aws_subnet.lamp-public-subnet1.id]


}

resource "aws_lb_target_group" "lamp-tg" {
  name     = "lamp-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.lamp.id
}

resource "aws_lb_target_group_attachment" "lamp-tg-attachment" {
  target_group_arn = aws_lb_target_group.lamp-tg.arn
  target_id        = aws_instance.appserver.id
  port             = 80
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.lampalb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.lamp-tg.arn
  }
}