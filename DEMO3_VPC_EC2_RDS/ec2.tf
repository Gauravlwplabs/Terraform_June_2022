data "aws_ami" "amazon_ami" {
  most_recent = true

  filter {
    name   = "name"
    values = ["Image_Terraform"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["self"] # Canonical
}

resource "aws_security_group" "allow_tls_public" {
  name        = "allow_tls_public"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.ThreetierVPC.id

  dynamic "ingress" {
    for_each = var.Ingress
    content {
      description = ingress.value["description"]
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_block
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_tls_publicSG"
  }
}

resource "aws_security_group" "allow_tls_private" {
  name        = "allow_tls_private"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.ThreetierVPC.id

  ingress {
    description     = "TLS from VPC"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.allow_tls_public.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_tls_privateSG"
  }
}

resource "aws_instance" "web" {
  ami                    = data.aws_ami.amazon_ami.id
  instance_type          = var.instancetype
  vpc_security_group_ids = [aws_security_group.allow_tls_public.id]
  tags = {
    Name = "web-server"
  }
  availability_zone           = "us-east-1a"
  subnet_id                   = lookup({ for x, y in aws_subnet.subnets_us-east_1a : x => y.id }, "public_subnet_for_myvpc_1")
  key_name                    = "my-key"
  associate_public_ip_address = true
}

resource "aws_instance" "application" {
  ami                    = data.aws_ami.amazon_ami.id
  instance_type          = var.instancetype
  vpc_security_group_ids = [aws_security_group.allow_tls_private.id]
  tags = {
    Name = "application-server"
  }
  key_name          = "my-key"
  availability_zone = "us-east-1a"
  subnet_id         = lookup({ for x, y in aws_subnet.subnets_us-east_1a : x => y.id }, "private_subnet_for_myvpc_1")
}