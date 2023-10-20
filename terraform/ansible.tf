provider "local" {
  // Configuration options
}

resource "local_file" "AnsibleInventory" {
  content = <<-EOF
    [varnish]
    ${aws_instance.varnish.public_ip} ansible_user=ubuntu ansible_ssh_private_key_file=./ansible_private_key.pem

    [monitor]
    ${aws_instance.monitor.public_ip} ansible_user=ubuntu ansible_ssh_private_key_file=./ansible_private_key.pem

    [client]
    ${aws_instance.client.public_ip} ansible_user=ubuntu ansible_ssh_private_key_file=./ansible_private_key.pem
  EOF

  filename = "${path.module}/../ansible/inventory.ini"
}

