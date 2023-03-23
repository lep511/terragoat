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
  ami           = "ami-830c94e3"
  instance_type = "t2.micro"

  tags = {
    Name                 = "ExampleAppServerInstance"
    git_commit           = "73822d27440c2390973077ccb2b6f42b1be99573"
    git_file             = "terraform/aws/s3_new.tf"
    git_last_modified_at = "2023-03-23 14:04:44"
    git_last_modified_by = "estebanpbuday@gmail.com"
    git_modifiers        = "estebanpbuday"
    git_org              = "lep511"
    git_repo             = "terragoat"
    yor_trace            = "90e129ff-7de0-40a4-b607-72d3079bde92"
  }
}
