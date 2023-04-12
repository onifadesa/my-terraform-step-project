#Define the provider
provider "aws" {
  region = "us-east-2"
}

#create a VM
resource "aws_instance" "webserver" {
  ami                    = "ami-00eeedc4036573771"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.instance_sg.id]

  user_data = <<-EOF
              #!/bin/bash
              echo "Welcome To a New World" > index.html
              nohup busybox httpd -f -p 8080 &
              EOF
  user_data_replace_on_change = true
  tags = {
    "Name" = "Terraform-Webserver"
  }
}

#Create SG for webserver access from anywhere
resource "aws_security_group" "instance_sg" {
  name = "terraform-weserver-sg"

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

}
