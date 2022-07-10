resource "aws_instance" "jumpserver" {
  ami = data.aws_ami.jumpserver.id
  instance_type = var.type
  availability_zone = var.az
  subnet_id = aws_subnet.lamp-public-subnet.id
  key_name = var.key_name
  tags = {
    "Name" = "Jumpserver"
  }
  vpc_security_group_ids = [ aws_security_group.jumpserver-sg.id ]
}

resource "aws_instance" "appserver" {
  ami = data.aws_ami.jumpserver.id
  instance_type = var.type
  availability_zone = var.az
  subnet_id = aws_subnet.lamp-private-app-subnet.id
  tags = {
    "Name" = "appserver"
  }
  vpc_security_group_ids = [ aws_security_group.appserver-sg.id ]
  key_name = var.key_name
}