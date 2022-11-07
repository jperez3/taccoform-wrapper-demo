terraform {
    backend "s3" {
        bucket = "taccoform-tf-backend-dev"
        key    = "taccoform-wrapper-demo/burrito/workspaces/dev/base/terraform.tfstate"
        region = ""
    }

}


provider "aws" {
    region = ""

    default_tags {
        tags = {
            Terraform_Workspace = "taccoform-wrapper-demo/burrito/workspaces/dev/base"
            Environment         = "dev"
        }
    }
}


terraform {
    required_providers {
        aws = {
            source  = "hashicorp/aws"
            version = "~> 4.0"
        }
    }

    required_version = "~> 1.0"
}
