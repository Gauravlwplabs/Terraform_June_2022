instancetype = "t2.micro"
Ingress = [{
  cidr_block  = ["0.0.0.0/0"]
  description = "opening port 22 for SSH"
  from_port   = 22
  protocol    = "tcp"
  to_port     = 22
  },
  {
    cidr_block  = ["0.0.0.0/0"]
    description = "opening port 80 for http"
    from_port   = 80
    protocol    = "tcp"
    to_port     = 80
  },
]

  