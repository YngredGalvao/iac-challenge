#variable for name of the resources based on privacy
locals {
  public  = "public"
  private = "private"
}

#variable for name of the resources
variable "name" {
  default = "awslab"
}

#variable for CIDR block 
variable "vpc_cidr_block" {
  default = "172.16.0.0/16"
}

#variable for CIDR block of the public subnet
variable "public_subnet_a_cidr_block" {
  default = "172.16.64.0/18"
}

#variable for CIDR block of the private subnet
variable "private_subnet_a_cidr_block" {
  default = "172.16.128.0/18"
}

#variable for CIDR block of the public subnet
variable "public_subnet_b_cidr_block" {
  default = "172.16.192.0/18"
}

#variable for CIDR block of the private subnet
variable "private_subnet_b_cidr_block" {
  default = "172.16.0.0/18"
}

#variable for the availability zone
variable "availability_zone_a" {
  default = "us-east-2a"
}

#variable for the availability zone
variable "availability_zone_b" {
  default = "us-east-2b"
}
