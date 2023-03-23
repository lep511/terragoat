variable "awsprops" {
  type = "map"
  default = {
    region       = "us-east-1"
    vpc          = "vpc-5234832d"
    ami          = "ami-0c1bea58988a989155"
    itype        = "t2.micro"
    subnet       = "subnet-81896c8e"
    publicip     = true
    keyname      = "myseckey"
    secgroupname = "IAC-Sec-Group"
  }
}

provider "aws" {
  region = lookup(var.awsprops, "region")
}

resource "aws_security_group" "project-iac-sg" {
  name        = lookup(var.awsprops, "secgroupname")
  description = lookup(var.awsprops, "secgroupname")
  vpc_id      = lookup(var.awsprops, "vpc")

  // To Allow SSH Transport
  ingress {
    from_port   = 22
    protocol    = "tcp"
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  // To Allow Port 80 Transport
  ingress {
    from_port   = 80
    protocol    = ""
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  lifecycle {
    create_before_destroy = true
  }
  tags = {
    git_commit           = "249dc07b03ee9d279748855bef68f56b36db01c3"
    git_file             = "terraform/aws/ec2_v2.tf"
    git_last_modified_at = "2023-03-23 14:32:13"
    git_last_modified_by = "46011885+lep511@users.noreply.github.com"
    git_modifiers        = "46011885+lep511"
    git_org              = "lep511"
    git_repo             = "terragoat"
    yor_trace            = "4a0056ca-d769-467e-b6f3-a07f45bab1fb"
  }
}


resource "aws_instance" "project-iac" {
  ami                         = lookup(var.awsprops, "ami")
  instance_type               = lookup(var.awsprops, "itype")
  subnet_id                   = lookup(var.awsprops, "subnet") #FFXsubnet2
  associate_public_ip_address = lookup(var.awsprops, "publicip")
  key_name                    = lookup(var.awsprops, "keyname")


  vpc_security_group_ids = [
    aws_security_group.project-iac-sg.id
  ]
  root_block_device {
    delete_on_termination = true
    iops                  = 150
    volume_size           = 50
    volume_type           = "gp2"
  }
  tags = merge({
    Name        = "SERVER01"
    Environment = "DEV"
    OS          = "UBUNTU"
    Managed     = "IAC"
    }, {
    git_commit           = "249dc07b03ee9d279748855bef68f56b36db01c3"
    git_file             = "terraform/aws/ec2_v2.tf"
    git_last_modified_at = "2023-03-23 14:32:13"
    git_last_modified_by = "46011885+lep511@users.noreply.github.com"
    git_modifiers        = "46011885+lep511"
    git_org              = "lep511"
    git_repo             = "terragoat"
    yor_trace            = "54bbd160-dc25-4834-93b9-9a901c1d6916"
  })

  depends_on = [aws_security_group.project-iac-sg]
}


output "ec2instance" {
  value = aws_instance.project-iac.public_ip
}

