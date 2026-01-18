
output "public_ip" {
  value = aws_instance.ExampleInstance.public_ip
}

output "id" {
  value = aws_instance.ExampleInstance.id
}