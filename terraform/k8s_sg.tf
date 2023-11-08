resource "aws_security_group" "k8s_data_plane_sg" {
  name   = "K8S Data Plane Ports"
  vpc_id = aws_vpc.main.id

  ingress {
    from_port   = 10250
    to_port     = 10250
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 30000
    to_port     = 32767
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "k8s_data_plane_sg"
  }
}

resource "aws_security_group" "k8s_control_plane_sg" {
  name   = "K8S Control Plane Ports"
  vpc_id = aws_vpc.main.id

  ingress {
    from_port   = 6443
    to_port     = 6443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 2379
    to_port     = 2380
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "k8s_control_plane_sg"
  }
}
