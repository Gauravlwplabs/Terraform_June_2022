data "aws_ami" "jumpserver" {
   owners = ["self"]
   name_regex = "^Jump"
   most_recent = true
}