resource "aws_db_subnet_group" "lampdbsubnetgroup" {
  name       = "lamp_subnet_group"
  subnet_ids = [for each_subnet in aws_subnet.lamp-private-db-subnet: each_subnet.id]
  tags = {
    Name = "lampdbsubnetgroup"
  }
}

resource "aws_db_instance" "lamp_db_server" {
  allocated_storage    = 10
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t3.micro"
  username             = var.user
  password             = var.pass
  skip_final_snapshot  = true
  db_subnet_group_name = aws_db_subnet_group.lampdbsubnetgroup.id
  vpc_security_group_ids = [ aws_security_group.db-sg.id ]
  availability_zone = var.az
  tags = {
    "Name" = "lamp_db_server"
  }
}