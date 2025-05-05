terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "remote" {
    organization = "tadka-twist-org"
    workspaces {
      name = "tadka-infra"
    }
  }

  required_version = ">= 1.3.0"
}

provider "aws" {
  region = "eu-central-1"  # Frankfurt
}
