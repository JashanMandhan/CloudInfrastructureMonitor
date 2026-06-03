output "instance_public_ip" {
  description = "Public IP of the EC2 instance"
  value       = aws_instance.app_server.public_ip
}

output "instance_id" {
  description = "EC2 Instance ID"
  value       = aws_instance.app_server.id
}

output "security_group_id" {
  description = "Security Group ID"
  value       = aws_security_group.app_sg.id
}

output "app_url" {
  description = "Application URL"
  value       = "http://${aws_instance.app_server.public_ip}:3000"
}

output "prometheus_url" {
  description = "Prometheus URL"
  value       = "http://${aws_instance.app_server.public_ip}:9090"
}

output "grafana_url" {
  description = "Grafana URL"
  value       = "http://${aws_instance.app_server.public_ip}:3001"
}