variable "region" {
  description = "Enter AWS region to proceed"                                   # type = string
  default     = "eu-central-1"
}
variable "instance_type" {
  description = "Enter instance type to proceed"
  default     = "t2.micro"
}
variable "ports" {
  description = "Enter ports to be opened"                                      # Type = list
  default     = ["80", "443", "8080", "22", "8080"]
}