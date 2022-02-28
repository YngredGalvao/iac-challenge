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
variable "public_subnet_cidr_block" {
  default = "172.16.1.0/24"
}

#variable for CIDR block of the private subnet
variable "private_subnet_cidr_block" {
  default = "172.16.2.0/24"
}

#variable for AMI iD

variable "ami_id" {
  default = "ami-0eb7496c2e0403237"
}

#variable for the availability zone
variable "availability_zone" {
  default = "eu-central-1a"
}
