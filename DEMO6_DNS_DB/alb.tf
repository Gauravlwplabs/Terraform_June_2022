
resource "aws_lb" "alb_3tier" {
  name               = "demoalb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb_sg.id]
  subnets            = [lookup({ for x, y in aws_subnet.subnets_us-east_1a : x => y.id }, "public_subnet_for_myvpc_1"), lookup({ for x, y in aws_subnet.subnets_us-east_1b : x => y.id }, "public_subnet_for_myvpc_2")]

}

resource "aws_security_group" "lb_sg" {
  name        = "lb-sg"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.ThreetierVPC.id

  ingress {
    description = "TLS from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "alb_sg"
  }
}

resource "aws_lb_target_group" "test" {
  name     = "tf-example-lb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.ThreetierVPC.id
}

resource "aws_lb_target_group_attachment" "test" {
  target_group_arn = aws_lb_target_group.test.arn
  target_id        = aws_instance.application.id
  port             = 80
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.alb_3tier.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.test.arn
  }
}