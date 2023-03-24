terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "us-west-2"
}

resource "aws_instance" "app_server" {
  ami           = "ami-08d70e59c07c61a3a"
  instance_type = "t2.micro"

  tags = merge({
    Name = var.instance_name
    }, {
    another-key          = "another_val"
    git_commit           = "f9c4d285fbed024f64b368fb423ff393711dd4ee"
    git_file             = "terraform/aws/playload-ii/main.tf"
    git_last_modified_at = "2023-03-24 02:22:24"
    git_last_modified_by = "estebanpbuday@gmail.com"
    git_modifiers        = "estebanpbuday"
    git_org              = "lep511"
    git_repo             = "terragoat"
    somekey              = "somevalue"
    yor_trace            = "aa015154-5562-46eb-8d46-420e691dbfd7"
  })
}

# variables.tf

variable "instance_name" {
  description = "Value of the Name tag for the EC2 instance"
  type        = string
  default     = "ExampleAppServerInstance"
}
