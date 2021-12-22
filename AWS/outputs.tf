# Extend our output with this file.

output "Ubuntu_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.Ubuntu.public_ip
}
output "DataBase_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.DataBase.public_ip
}
output "Region" {
  description = "Region of the EC2 instance"
  value       = aws_instance.Ubuntu.availability_zone
}