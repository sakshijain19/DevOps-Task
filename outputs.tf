
output "public_ip" {
  value = aws_instance.my_ec2.public_ip
}

output "id" {
  value = aws_instance.my_ec2.id
}