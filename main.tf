terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.25.0"
    }
  }
  backend "s3" {
    bucket="mytfsamplebucket"
    key="terraform.tfstate"
    region="ap-south-1"
    dynamodb_table="tf-sample"
  }
}
provider "aws" {
#   # Configuration options
  region     = "ap-south-1"
#   #access_key = ""
#   #secret_key = ""
}
# variable "instance_type" {}
# locals {
#   env = "${terraform.workspace}"
# }
# resource "aws_instance" "web" {
#   count = 2
#   ami           = "ami-0a6ed6689998f32a5"
#   instance_type = var.instance_type
#   tags = {
# #     # Name = "TF-${count.index+1}"
# #     # Name = "${local.env}-${count.index+1}"
#     Name = "TF-${terraform.workspace}-${count.index+1}"
#   }
# }
# Creating AWS VPC
resource "aws_vpc" "TFVPC" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "TF-VPC"
  }
}