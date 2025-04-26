# Security Group
resource "aws_security_group" "jenkins_SG" {
  name        = "jenkins-SG"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.cloudphp_staging_vpc.id

  ingress {
    description      = "Allow HTTP"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description      = "Allow SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description      = "Allow custom HTTP"
    from_port        = 8080
    to_port          = 8080
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    description      = "Allow all outbound"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
}

# Ubuntu AMI
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical (Ubuntu)
  filter {
    name   = "name"
    values = [var.ubuntu_ami_filter]
  }
}


# Jenkins Instance
resource "aws_instance" "jenkins" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.instance_type
  key_name                    = var.key_name
  vpc_security_group_ids      = [aws_security_group.jenkins_SG.id]
  subnet_id                   = aws_subnet.pub_sub_1.id
  associate_public_ip_address = true
  user_data = <<-EOF
             #!/bin/bash
             sudo apt update -y
             sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
             https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
             echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc]" \
             https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
             /etc/apt/sources.list.d/jenkins.list > /dev/null
             sudo apt-get update
             sudo apt-get install jenkins -yy
             EOF

}


