variable "ami_id" {
  type    = string
  default = "ami-04fb5919f7d072943"
}

variable "app_name" {
  type    = string
  default = "ansible_image"
}

locals {
    app_name = "ansible_image"
}

source "amazon-ebs" "ansible_image" {
  ami_name      = "PACKER-DEMO-${local.app_name}"
  instance_type = "t2.micro"
  region        = "us-east-1"
  source_ami    = "${var.ami_id}"
  ssh_username  = "ubuntu"
  ssh_private_key_file="my-key.pem"
  tags = {
    Env  = "DEMO"
    Name = "PACKER-DEMO-${var.app_name}"
  }
}

build {
  sources = ["source.amazon-ebs.ansible_image"]

  provisioner "shell" {
    inline=["sudo apt update -y",
    "sudo apt install ansible -y",
    "sudo apt install apache2 -y"
    ]
  }
}