# Start t2.micro instance in AWS

provider "aws" {
  access_key = "AKIAVW4O6LWCEL35GXF3"
  secret_key = "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"
  region     = "eu-central-1"
}

resource "aws_instance" "Ubuntu" {
  #count = 1
  ami                    = "ami-0d527b8c289b4af7f" # ubuntu lts
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.My_app.id]                          # This is the reference for resource [ "aws_security_group" "My_app" ]
                                                                                   # which will be created at next block
  user_data = file("script.sh")                                                           # Load our script to run
  tags = {
    "Name"    = "AWS_Instance"
    "Owner"   = "Vitali Kuts"
    "Project" = "TERRAform"
  }
  lifecycle {                                                                             # prevent instance from recreation
    #  prevent_destroy = true
    #  ignore_changes = ["ami"]
    #  create_before_destroy = true                                                       # Need to set up elastic ip first
  }
}

resource "aws_instance" "DataBase" {
  ami           = "ami-0d527b8c289b4af7f" # ubuntu lts
  instance_type = "t2.micro"
  tags = {
    "Name" = "AWS_DataBase"
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
    for_each = ["80", "443", "8080", "22"]
    content {
      description = "open port 80"
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