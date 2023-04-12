#Define the provider
provider "aws" {
    region = "us-east-2"
  }

#create a VM
resource "aws_instance" "webserver" {
    ami = "ami-00eeedc4036573771"
    instance_type = "t2.micro"

    tags = {
      "Name" = "Terraform-Webserver"
    } 
}