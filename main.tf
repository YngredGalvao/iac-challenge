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
  region = "us-east-2"
  access_key = "AKIAXR6MQET5H7C4SAHK"
  secret_key = "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"
  default_tags {
    tags = {
      environment = "Dev"
      project     = "IOB Challenge"
      owner       = "Yngred Galvao"
    }
  }
}
