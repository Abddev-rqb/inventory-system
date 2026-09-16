output "ec2_public_ip" {
  description = "Public IP of the inventory server"
  value       = aws_instance.inventory.public_ip
}

output "ec2_public_dns" {
  description = "Public DNS of the inventory server"
  value       = aws_instance.inventory.public_dns
}

output "ssh_command" {
  description = "SSH command template"
  value       = "ssh ubuntu@${aws_instance.inventory.public_ip}"
}
