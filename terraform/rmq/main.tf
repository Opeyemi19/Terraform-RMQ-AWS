provider "aws" {
  region = "us-east-1"
  profile = var.profile
}

resource "aws_instance" "rmq" {
  ami                    = "ami-0747bdcabd34c712a"
  instance_type          = "t2.micro"
  key_name               = "rabbitmq"
  vpc_security_group_ids = [aws_security_group.instance_sg.id]

  tags = {
    Name = var.name
    group = var.group
  }
}

resource "aws_security_group" "instance_sg" {
  name = "rabbitmq-sg-web"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
      from_port = 15672
      to_port = 15672
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }
}