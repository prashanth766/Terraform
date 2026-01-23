output "privateip" {
    value = aws_instance.name.private_ip
  
}
output "az" {
    value = aws_instance.name.availability_zone
  
}