variable "ami_id" {
  default = "ami-0ecb62995f68bb549"
}
variable "instance_type" {
  default = "t3.micro"
}
variable "vpc_security_group_ids" {
  default = ["sg-088e5ceffeadaf431"]
}