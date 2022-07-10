variable "region" {
  type = string
  default = "us-east-1"
}

variable "cidr" {
  type = string
  default = "10.0.0.0/20"
}

variable "az" {
  type = string
  default = "us-east-1a"
}

variable "type" {
  type = string
  default = "t2.micro"

}

variable "key_name" {
  type = string
  default = "US-east-1"
}

variable "user" {
  type = string
  default = "admin"
}

variable "pass" {
  type = string
  default = "India1947"
  sensitive = true
}

variable "az-db" {
  type = list(string)
  default = [ "us-east-1a","us-east-1b" ]
}
