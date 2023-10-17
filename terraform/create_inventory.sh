#!/bin/bash

# Fetch IPs from Terraform output and create an inventory file for Ansible
VARNISH_IP=$(terraform output -raw varnish_public_ip)
CLIENT_IP=$(terraform output -raw client_public_ip)

# Write to inventory file
cat > ../ansible/inventory.ini <<EOF
[varnish]
$VARNISH_IP ansible_user=ubuntu ansible_ssh_private_key_file=./ansible_private_key.pem

[client]
$CLIENT_IP ansible_user=ubuntu ansible_ssh_private_key_file=./ansible_private_key.pem
EOF

