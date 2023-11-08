# Generate a random string for the S3 bucket name
resource "random_string" "k8s_name" {
  length  = 9
  special = false
  upper   = false
  lower   = true
}

# Create an S3 bucket with the generated name
resource "aws_s3_bucket" "k8s_bucket" {
  bucket        = "k8s-${random_string.k8s_name.result}"
  force_destroy = true
}

# Set the S3 bucket ACL to private
resource "aws_s3_bucket_acl" "k8s_bucket_acl" {
  bucket = aws_s3_bucket.k8s_bucket.id
  acl    = "private"
}

# Define the S3 bucket ownership controls
resource "aws_s3_bucket_ownership_controls" "k8s_bucket_ownership" {
  bucket = aws_s3_bucket.k8s_bucket.id

  rule {
    object_ownership = "ObjectWriter"
  }
}

resource "aws_instance" "k8s_master" {
  ami                    = var.ubuntu_ami
  subnet_id              = aws_subnet.main.id
  instance_type          = var.k8s_size
  key_name               = aws_key_pair.deployer.key_name

  associate_public_ip_address = true
  vpc_security_group_ids = [
                             aws_security_group.egress_all.id,
                             aws_security_group.ingress_ssh.id,
                             aws_security_group.ingress_node_exporter.id,
                             aws_security_group.k8s_control_plane_sg.id,
                           ]

  count                  = var.k8s_workers

  tags = {
    Name = "k8s_masters"
  }

  user_data = <<-EOF
              #!/bin/bash
              sudo apt-get update
              EOF

  depends_on = [
    aws_s3_bucket.k8s_bucket,
  ]
}

resource "aws_instance" "k8s_worker" {
  ami                    = var.ubuntu_ami
  instance_type          = var.k8s_size
  key_name               = aws_key_pair.deployer.key_name
  count                  = var.k8s_workers

  # Networking options
  subnet_id              = aws_subnet.main.id
  associate_public_ip_address = true
  vpc_security_group_ids = [
                             aws_security_group.egress_all.id,
                             aws_security_group.ingress_ssh.id,
                             aws_security_group.ingress_node_exporter.id,
                             aws_security_group.k8s_data_plane_sg.id,
                           ]

  tags = {
    Name = "k8s worker"
  }

  user_data = <<-EOF
              #!/bin/bash
              sudo apt-get update
              EOF

  depends_on = [
    aws_instance.k8s_master,
  ]
}

