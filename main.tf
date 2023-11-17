terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.25.0"
    }
  }
}
provider "aws" {
#   # Configuration options
  region     = "ap-south-1"
#   #access_key = ""
#   #secret_key = ""
}
variable "instance_type" {}
resource "aws_instance" "web" {
  count = 2
  ami           = "ami-0a6ed6689998f32a5"
  instance_type = var.instance_type

  tags = {
    Name = "TF-${count.index+1}"
  }
}