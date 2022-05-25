terraform {
  required_version = ">= 0.13"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.39.0"
    }
  }
}

provider "aws" {
  region = "eu-central-1"
  default_tags {
    tags = {
      environment = "Dev"
      project     = "IOB Challenge"
      owner       = "Yngred Galvao"
    }
  }
}
