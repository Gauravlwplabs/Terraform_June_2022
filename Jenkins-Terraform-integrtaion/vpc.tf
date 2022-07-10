resource "aws_vpc" "lamp" {
  cidr_block       = var.cidr
  instance_tenancy = "default"

  tags = {
    Name = "lamp"
  }
}
