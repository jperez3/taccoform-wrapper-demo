terraform {
    backend "s3" {
        bucket = "$TF_STATE_BUCKET_NAME-$ENV"
        key    = "$REPO_NAME/$SERVICE_PATH/terraform.tfstate"
        region = "$BUCKET_REGION"
    }

}


provider "aws" {
    region = "$AWS_REGION"

    default_tags {
        tags = {
            Terraform_Workspace = "$REPO_NAME/$SERVICE_PATH"
            Environment         = "$ENV"
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
