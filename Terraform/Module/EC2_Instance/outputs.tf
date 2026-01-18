
output "public_ip" {
  value = aws_instance.my-instance.public_ip
}

output "id" {
  value =  aws_instance.my-instance.id
}