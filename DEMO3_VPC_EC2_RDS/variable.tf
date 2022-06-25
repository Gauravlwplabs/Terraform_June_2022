
variable "Ingress" {
  description = "Variable for security rule for public security group"
  type = list(object({
    description = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_block  = list(string)
  }))
}

variable "instancetype" {
  type        = string
  description = "Instance type to be used"
}

variable "az" {
  type = list(string)
}

variable "password" {
  type      = string
  sensitive = true
}