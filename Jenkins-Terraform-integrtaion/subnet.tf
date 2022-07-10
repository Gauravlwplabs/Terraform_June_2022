resource "aws_subnet" "lamp-public-subnet" {
  vpc_id     = aws_vpc.lamp.id
  cidr_block = cidrsubnet(var.cidr, 4,2)
  tags = {
    Name = "lamp-public-subnet"
  }
  map_public_ip_on_launch = true
  availability_zone = var.az
}

resource "aws_subnet" "lamp-public-subnet1" {
  vpc_id     = aws_vpc.lamp.id
  cidr_block = cidrsubnet(var.cidr, 4,3)
  tags = {
    Name = "lamp-public-subnet1"
  }
  map_public_ip_on_launch = true
  availability_zone = "us-east-1b"
}

resource "aws_subnet" "lamp-private-app-subnet" {
  vpc_id     = aws_vpc.lamp.id
  cidr_block=cidrsubnet(var.cidr,4,0)
  tags = {
    Name = "lamp-private-app-subnet"
  }
  availability_zone = var.az
}

resource "aws_subnet" "lamp-private-db-subnet" {
  vpc_id     = aws_vpc.lamp.id
  for_each = {"us-east-1a":cidrsubnet(var.cidr,4,6),"us-east-1b":cidrsubnet(var.cidr,4,4)}
  cidr_block = each.value
  tags = {
    Name = "lamp-private-${each.key}-subnet"
  }
  availability_zone = each.key
}