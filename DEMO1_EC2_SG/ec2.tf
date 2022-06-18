terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.15.1"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}


resource "aws_instance" "web-server" {
  ami = var.image
  instance_type = var.instance
  vpc_security_group_ids = [ aws_security_group.allow-ssh.id ]
}

resource "aws_security_group" "allow-ssh" {
  ingress = [ {
    cidr_blocks = [ "0.0.0.0/0" ]
    description = "ssh port to be open"
    from_port = 22
    ipv6_cidr_blocks = []
    prefix_list_ids = []
    protocol = "tcp"
    security_groups = []
    self = false
    to_port = 22
  } ]
  egress = [ {
    cidr_blocks = [ "0.0.0.0/0" ]
    description = "outbound rule"
    from_port = 0
    ipv6_cidr_blocks = []
    prefix_list_ids = []
    protocol = "-1"
    security_groups = []
    self = false
    to_port = 0
  } ]

}