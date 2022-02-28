#Private and public security group protocol/ports rules
locals {
  private_sg = {
    db = {
      cidr_block = ["172.16.1.0/24"]
      protocol   = "tcp"
      from_port       = "3110"
      to_port         = "3110"
    }
    ssh = {
      cidr_block = ["172.16.1.0/24"]
      protocol   = "tcp"
      from_port       = "22"
      to_port         = "22"
    }
    ping = {
      cidr_block = ["172.16.1.0/24"]
      protocol   = "icmp"
      from_port       = "-1"
      to_port         = "-1"
    }
  }

  public_sg = {
    ssh = {
      cidr_block = ["0.0.0.0/0"]
      protocol   = "tcp"
      from_port       = "22"
      to_port    = "22"
    }
    https = {
      cidr_block = ["0.0.0.0/0"]
      protocol   = "tcp"
      from_port       = "443"
      to_port    = "443"
    }
    ping = {
      cidr_block = ["0.0.0.0/0"]
      protocol   = "icmp"
      from_port       = "-1"
      to_port         = "-1"
    }
    http = {
      cidr_block = ["0.0.0.0/0"]
      protocol   = "tcp"
      from_port       = "3110"
      to_port         = "3110"
    }
  }
}