# Start t2.micro instance in AWS

provider "aws" {
  access_key = "AKIAVW4O6LWCEL35GXF3"
  secret_key = "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"
  region = "eu-central-1"
}
resource "aws_instance" "Ubuntu" {
  count = 1
  ami = "ami-0d527b8c289b4af7f" # ubuntu lts
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.My_app.id] # This is the reference for resource [ "aws_security_group" "My_app" ]
                                                          # which will be created at next block
  user_data = <<EOF
#!/bin/bash
apt update -y
EOF

  tags = {
    "Name"    = "AWS_Instance"
    "Owner"   = "Vitali Kuts"
    "Project" = "TERRAform"
  }
}
resource "aws_security_group" "My_app" {
  name        = "security_group for my_app"
  description = "La-la-la. LOL."

  ingress {
    description      = "open port 80"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
   # ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
   # ipv6_cidr_blocks = ["::/0"]
  }
}