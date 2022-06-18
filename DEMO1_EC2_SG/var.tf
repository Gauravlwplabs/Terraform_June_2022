variable "image" {
  description = "it is AMI-ID used to create instance"
  type = string
  default = "ami-079b5e5b3971bd10d"
}

variable "instance" {
  description = "instance type"
  type = string
}