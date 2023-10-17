resource "tls_private_key" "ansible_ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "deployer" {
  key_name   = "ansible-deployer-key"
  public_key = tls_private_key.ansible_ssh_key.public_key_openssh
}

output "private_key" {
  value     = tls_private_key.ansible_ssh_key.private_key_pem
  sensitive = true
}

resource "local_file" "private_key_pem" {
    content = tls_private_key.ansible_ssh_key.private_key_pem
    filename          = "${path.module}/../ansible/ansible_private_key.pem"
    file_permission   = "0400"
}

