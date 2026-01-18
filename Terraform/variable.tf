variable "region" {
    default = "us-east-1"
}
variable "cidr_block" {
    default = "10.0.0.0/16"
}
variable "public_subnet_cidr" {
    default = "10.0.0.0/24"
}
variable "private_subnet_cidr" {
    default = "10.0.1.0/24"
}
variable "ami_id" {
    default = "ami-0ecb62995f68bb549"
}
variable "instance_type" {
    default = "t3.micro"
}
variable "sg_id" {
type = list(string)
}

variable "key" {
    default = "id_rsa"
}
variable "project" {
default = "Cloud"
}
variable "env" {
default = "dev"
}