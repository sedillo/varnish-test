resource "aws_security_group" "client" {
  name        = "client_security_group"
  description = "Security group for Varnish server with SSH access"
  vpc_id      = aws_vpc.main.id  # Replace with your VPC ID reference

  # SSH access from anywhere
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # This allows SSH access from any IP; consider restricting it
  }

  # Outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "client_sg"
  }
}

resource "aws_instance" "client" {
  ami                    = "ami-0f8e81a3da6e2510a" # replace with your preferred AMI ID
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.client.id]
  subnet_id              = aws_subnet.main.id
  key_name               = aws_key_pair.deployer.key_name

  associate_public_ip_address = true

  tags = {
    Name = "ClientInstance"
  }

  user_data = <<-EOF
              #!/bin/bash
              sudo apt-get update
              sudo apt-get install -y haproxy
              # You should configure HAProxy here, or pull its configuration from a remote source.
              sudo systemctl restart haproxy
              EOF
}

