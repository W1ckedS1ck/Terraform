# Extend our output with this file.

output "instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.Ubuntu.public_ip
}