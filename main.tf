terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
  required_version = ">= 1.2.0"
}
provider "aws" {
  profile = "default"
  region  = "us-east-1"
}

# Defina um grupo de segurança - 1
resource "aws_security_group" "senior_security_group_1" {
  name        = "senior_security_group_1"
  description = "senior_security_group_1"

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

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

# Defina um grupo de segurança - 2
resource "aws_security_group" "senior_security_group_2" {
  name        = "senior_security_group_2"
  description = "senior_security_group_2"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 15672
    to_port     = 15672
    protocol    = "tcp"
    security_groups = [aws_security_group.senior_security_group_1.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Defina uma instância EC2
resource "aws_instance" "senior_instance_nginx" {
  ami           = "ami-0c7217cdde317cfec"  # Substitua pela AMI desejada
  instance_type = "t2.micro"
  key_name = "senior"

  vpc_security_group_ids = [aws_security_group.senior_security_group_1.id]

 tags = {
    Name = "senior_instance_nginx"
  }
}

# Defina uma instância EC2 - 2
resource "aws_instance" "senior_instance_rabbitmq" {
  ami           = "ami-0c7217cdde317cfec"  # Substitua pela AMI desejada
  instance_type = "t2.micro"
  key_name = "senior"

  vpc_security_group_ids = [aws_security_group.senior_security_group_2.id]

  tags = {
    Name = "senior_instance_rabbitmq"
  }
}

