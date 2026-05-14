# IP publiques des 3 instances MongoDB
output "instance_ips" {
  value       = aws_instance.mongo[*].public_ip
  description = "Liste des IP publiques des nodes MongoDB"
}