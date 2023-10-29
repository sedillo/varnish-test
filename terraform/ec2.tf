resource "aws_instance" "client" {
  ami                    = "ami-0f8e81a3da6e2510a" # replace with your preferred AMI ID
  instance_type          = "t2.micro"
  vpc_security_group_ids = [
                             aws_security_group.egress_all.id,
                             aws_security_group.ingress_ssh.id,
                             aws_security_group.ingress_node_exporter.id,
                           ]
  subnet_id              = aws_subnet.main.id
  key_name               = aws_key_pair.deployer.key_name

  associate_public_ip_address = true

  tags = {
    Name = "ClientInstance"
  }

  user_data = <<-EOF
              #!/bin/bash
              sudo apt-get update
              EOF
}

resource "aws_instance" "monitor" {
  ami                    = "ami-0f8e81a3da6e2510a"
  instance_type          = "t2.medium" # choose an appropriate instance type
  vpc_security_group_ids = [
                             aws_security_group.egress_all.id,
                             aws_security_group.ingress_ssh.id,
                             aws_security_group.ingress_mon_stack.id,
                             aws_security_group.ingress_node_exporter.id,
                           ]
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

resource "aws_instance" "varnish" {
  ami                    = "ami-0f8e81a3da6e2510a"
  instance_type          = "t2.large" # choose an appropriate instance type
  vpc_security_group_ids = [
                             aws_security_group.egress_all.id,
                             aws_security_group.ingress_ssh.id,
                             aws_security_group.ingress_node_exporter.id,
                           ]
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

