terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  backend "s3" {
    bucket = "tf-state-533267232987"
    region = "us-east-1"
    key    = "terraform/state/todo-app/terraform.tfstate"
    dynamodb_table = "tf_state_lockid"
  }
}

provider "aws" {
  region = var.aws_region
}
