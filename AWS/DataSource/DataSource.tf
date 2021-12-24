provider "aws" {
  access_key = "AKIAVW4O6LWCFOTXYANP"
  secret_key = "lUW7dD8TjCkuRzhi8+"
  region     = "eu-central-1"
}
/*
data "aws_availability_zones" "available" {
#  state = "available"
}
data "aws_caller_identity" "current"{}

output "available_zones" {
  value = data.aws_availability_zones.available.names
}
output "aws_caller_identity" {
  value = data.aws_caller_identity.current.account_id
}
*/

data "aws_ami" "latest_ubuntu" {
  owners      = ["099720109477"]
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
}

output "AWS_latest_ubuntu_ID" {
  value = data.aws_ami.latest_ubuntu.id
}
output "AWS_latest_ubuntu_name" {
  value = data.aws_ami.latest_ubuntu.name
}