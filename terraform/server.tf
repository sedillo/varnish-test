resource "aws_security_group" "varnish" {
  name        = "varnish_security_group"
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
    Name = "varnish_sg"
  }
}

resource "aws_instance" "varnish" {
  ami                    = "ami-0f8e81a3da6e2510a"
  instance_type          = "t2.large" # choose an appropriate instance type
  vpc_security_group_ids = [aws_security_group.varnish.id]
  subnet_id              = aws_subnet.main.id
  key_name               = aws_key_pair.deployer.key_name

  associate_public_ip_address = true


  tags = {
    Name = "Varnish"
  }

  user_data = <<-EOF
              #!/bin/bash
              sudo apt-get update
              EOF
}

