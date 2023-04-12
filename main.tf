#Define the provider
provider "aws" {
    region = "us-east-2"
  }

#create a VM
resource "aws_instance" "webserver" {
    ami = "ami-00eeedc4036573771"
    instance_type = "t2.micro"

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
