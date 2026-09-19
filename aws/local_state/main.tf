# Terraform Settings Block
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.67"
    }
  }

  required_version = ">= 1.2.0"
}
# Provider Block
provider "aws" {
  region  = "us-east-1"
}
# Resource Block
resource "aws_instance" "app_server" {
  ami           = "ami-0006118602dfc1c09"
  instance_type = "t3.micro"

  tags = {
    Name = "Terraform_Demo"
  }
}


# Commands to run the Terraform scripts.
# terraform init
# terraform validate
# terraform plan
# terraform apply
# terraform destroy
