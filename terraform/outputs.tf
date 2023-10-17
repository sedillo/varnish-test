output "varnish_public_ip" {
  value = aws_instance.varnish.public_ip
  description = "The public IP address of the Varnish server."
}

output "client_public_ip" {
  value = aws_instance.client.public_ip
  description = "The public IP address of the client instance."
}

