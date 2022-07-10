resource "aws_security_group" "jumpserver-sg" {
  name        = "jumpserver-sg"
  description = "Allow SSH traffic"
  vpc_id      = aws_vpc.lamp.id

  ingress {
    description      = "TLS from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }

  tags = {
    Name = "jumpserver-sg"
  }
}
resource "aws_security_group" "alb-sg" {
  name        = "alb-sg"
  description = "Allow SSH traffic"
  vpc_id      = aws_vpc.lamp.id

  ingress {
    description      = "TLS from VPC"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }

  tags = {
    Name = "alb-sg"
  }
}
resource "aws_security_group" "appserver-sg" {
  name        = "appserver-sg"
  description = "Allow SSH traffic"
  vpc_id      = aws_vpc.lamp.id

  ingress {
    description      = "TLS from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    security_groups = [aws_security_group.jumpserver-sg.id]
  }
  ingress {
    description      = "TLS from VPC"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    security_groups = [aws_security_group.alb-sg.id]

  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]

  }

  tags = {
    Name = "appserver-sg"
  }

}

resource "aws_security_group" "db-sg" {
  name        = "db-sg"
  description = "Allow SSH traffic"
  vpc_id      = aws_vpc.lamp.id
  ingress {
    description      = "TLS from VPC"
    from_port        = 3306
    to_port          = 3306
    protocol         = "tcp"
    security_groups = [aws_security_group.appserver-sg.id]

  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]

  }

  tags = {
    Name = "db-sg"
  }

}