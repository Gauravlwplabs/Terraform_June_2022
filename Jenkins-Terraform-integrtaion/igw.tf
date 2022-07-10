resource "aws_internet_gateway" "lamp_igw" {
  vpc_id = aws_vpc.lamp.id

  tags = {
    Name = "lamp_igw"
  }
}