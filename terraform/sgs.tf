resource "aws_security_group" "ingress_node_exporter" {
  name        = "ingress_node_exporter"
  description = "Security group for monitoring server"
  vpc_id      = aws_vpc.main.id  # Replace with your VPC ID reference

  ingress {
    from_port   = 9100
    to_port     = 9100
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # This allows SSH access from any IP; consider restricting it
  }
  tags = {
    Name = "ingress_node_exporter"
  }
}

resource "aws_security_group" "ingress_mon_stack" {
  name        = "ingress_mon_stack"
  description = "Security group for monitoring server"
  vpc_id      = aws_vpc.main.id  # Replace with your VPC ID reference

  ingress {
    from_port   = 9090
    to_port     = 9090
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
  tags = {
    Name = "ingress_mon_stack"
  }
}

resource "aws_security_group" "ingress_ssh" {
  name        = "in_ssh"
  description = "Security group for monitoring server"
  vpc_id      = aws_vpc.main.id  # Replace with your VPC ID reference

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # This allows SSH access from any IP; consider restricting it
  }
  tags = {
    Name = "ingress_ssh"
  }
}

resource "aws_security_group" "egress_all" {
  name        = "egress_all"
  description = "Security group for monitoring server"
  vpc_id      = aws_vpc.main.id  # Replace with your VPC ID reference
  # Outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "egress_all"
  }
}

