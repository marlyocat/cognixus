output "nodejs_public_ips" {
  description = "Public IP addresses of the Node.js application instances"
  value       = aws_instance.nodejs_app[*].public_ip
}