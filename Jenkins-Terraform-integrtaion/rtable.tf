resource "aws_route_table" "lamp_public_RT" {
  vpc_id = aws_vpc.lamp.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.lamp_igw.id
  }

  tags = {
    Name = "lamp_public_RT"
  }
}

resource "aws_route_table" "lamp_private_app_RT" {
  vpc_id = aws_vpc.lamp.id
  tags = {
    Name = "lamp_private_app_RT"
  }
}

resource "aws_route_table" "lamp_private_db_RT" {
  vpc_id = aws_vpc.lamp.id
  tags = {
    Name = "lamp_private_db_RT"
  }
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.lamp-public-subnet.id
  route_table_id = aws_route_table.lamp_public_RT.id
}

resource "aws_route_table_association" "private_app" {
  route_table_id = aws_route_table.lamp_private_app_RT.id
  subnet_id = aws_subnet.lamp-private-app-subnet.id
}

resource "aws_route_table_association" "private_db" {
  count=length([ for each in aws_subnet.lamp-private-db-subnet: each.id])
  route_table_id = aws_route_table.lamp_private_db_RT.id
  subnet_id = element([ for each in aws_subnet.lamp-private-db-subnet: each.id],count.index)
}