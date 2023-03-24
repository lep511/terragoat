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
    another-key = "another_val"
    somekey     = "somevalue"
    yor_trace   = "8a4b413b-5cb7-4ad8-ac41-b0af515fd441"
  })
}