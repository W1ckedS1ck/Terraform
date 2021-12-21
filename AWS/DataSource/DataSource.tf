provider "aws" {
  access_key = "AKIAVW4O6LWCEL35GXF3"
  secret_key = "pR+"
  region = "eu-central-1"
}

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