resource "aws_security_group" "monitor" {
  name        = "monitor_sg"
  description = "Security group for monitoring server"
  vpc_id      = aws_vpc.main.id  # Replace with your VPC ID reference

  ingress {
    from_port   = 9090
    to_port     = 9090
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # This allows SSH access from any IP; consider restricting it
  }
  ingress {
    from_port   = 9100
    to_port     = 9100
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # This allows SSH access from any IP; consider restricting it
  }
  ingress {
    from_port   = 9191
    to_port     = 9191
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # This allows SSH access from any IP; consider restricting it
  }
  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # This allows SSH access from any IP; consider restricting it
  }
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
    Name = "monitor_sg"
  }
}

resource "aws_instance" "monitor" {
  ami                    = "ami-0f8e81a3da6e2510a"
  instance_type          = "t2.medium" # choose an appropriate instance type
  vpc_security_group_ids = [aws_security_group.monitor.id]
  subnet_id              = aws_subnet.main.id
  key_name               = aws_key_pair.deployer.key_name

  associate_public_ip_address = true

  tags = {
    Name = "Monitor EC2"
  }

  user_data = <<-EOF
              #!/bin/bash
              sudo apt-get update
              EOF
}

