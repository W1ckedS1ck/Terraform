# Start instances in AWS

provider "aws" {
  region = var.region
  shared_credentials_file = "credentials"
  profile                 = "vitalik"
 # alias = "MyOwnRegion"
}
data "aws_ami" "latest_ubuntu" {
  owners = ["099720109477"]
  most_recent = true
  filter {
    name = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
}
terraform {
  backend "s3" {
    profile        = "profile"
    bucket         = "temp-terr-states"
    key            = "terraform.tfstate"
    region         = "us-east-1"                                                          # do not use vars here
    encrypt        = true
  }
}
resource "aws_instance" "Ubuntu" {
  #count = 1
  ami                    = data.aws_ami.latest_ubuntu.id                                       # ubuntu lts
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.My_app.id]                          # This is the reference for resource [ "aws_security_group" "My_app" ]
                                                                                   # which will be created at next block
  user_data = file("script.sh")                                                           # Load our script to run
  tags = {
    "Name"    = "AWS_Instance_build_by_Terraform"
    "Owner"   = "Vitali Kuts"
    "Project" = "TERRAform"
  }
  lifecycle {                                                                             # prevent instance from recreation
    #  prevent_destroy = true
    #  ignore_changes = ["ami"]
    #  create_before_destroy = true                                                       # Need to set up elastic ip first
  }
}
#/*
resource "aws_instance" "DataBase" {
#  provider = aws.MyOwnRegion
  ami           = data.aws_ami.latest_ubuntu.id                                                 # ubuntu lts
  instance_type = var.instance_type
  tags = {
    "Name" = "AWS_DataBase_build_by_Terraform"
  }
  depends_on = [aws_instance.Ubuntu]                                                      # DB will be created after Ubuntu
}
/*
resource "aws_eip" "aws_static_ip" {                                                      # aws_eip used for zero downlime
  instance = aws_instance.Ubuntu.id
}
*/

resource "aws_security_group" "My_app" {
  name        = "security_group for my_app"
  description = "La-la-la. LOL."

  dynamic "ingress" {                                                                     # dynamic can create bunch of task
    for_each = var.ports
    content {
    #  description = "open port ${var.ports}"
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      # ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]
    }
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    # ipv6_cidr_blocks = ["::/0"]
  }
  tags = {
    "Name" = "AWS_Security_Group"
  }
}