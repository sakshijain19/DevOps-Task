output "pvtsubnet_id" {
value = aws_subnet.pvtsubnet.id
}
output "pubsubnet_id" {
value = aws_subnet.pubsubnet.id
}
output "vpc_id" {
value = aws_vpc.myvpc.id
}