
resource "tls_private_key" "devops-kp" {

  algorithm = "RSA"

  rsa_bits  = 4096

}

resource "local_file" "private_key" {

  content  = tls_private_key.devops-kp.private_key_pem

  filename = "/Users/izzatfarhan/devops-kp.pem"

  file_permission = "0600"

}


resource "aws_key_pair" "devops-kp" {

  key_name   = "devops-kp"

  public_key = tls_private_key.devops-kp.public_key_openssh


}


resource "aws_security_group" "web_sg" {
  name = "web-sg"

    ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Prometheus"
    from_port = 9090
    to_port = 9090
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress = {
    description = "Grafana"
    from_port = 3000
    to_port = 3000
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "myec2" {
    ami = "ami-01dc51e87421923b6"
    instance_type = "t3.micro"
    key_name   = aws_key_pair.devops-kp.key_name
    vpc_security_group_ids = [aws_security_group.web_sg.id]
    
    
  tags = {
    Name = "production-cloud-infra"
  }
}


