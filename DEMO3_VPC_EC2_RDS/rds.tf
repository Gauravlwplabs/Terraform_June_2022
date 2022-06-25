resource "aws_db_instance" "db_3tier" {
  allocated_storage      = 20
  engine                 = "mysql"
  engine_version         = "8.0.28"
  instance_class         = "db.t3.micro"
  db_name                = "mydb"
  username               = "admin"
  password               = var.password
  skip_final_snapshot    = true
  vpc_security_group_ids = [aws_security_group.sg_db.id]
  db_subnet_group_name   = aws_db_subnet_group.default.id
}

resource "aws_db_subnet_group" "default" {
  name       = "main"
  subnet_ids = [lookup({ for x, y in aws_subnet.subnets_us-east_1a : x => y.id }, "private_subnet_for_myvpc_1"), lookup({ for x, y in aws_subnet.subnets_us-east_1b : x => y.id }, "private_subnet_for_myvpc_2")]

  tags = {
    Name = "My DB subnet group"
  }
}

resource "aws_security_group" "sg_db" {
  name        = "allow_tls_db"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.ThreetierVPC.id

  ingress {
    description     = "TLS from VPC"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.allow_tls_private.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_tls_db"
  }
}
