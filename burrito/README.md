# Burrito Service


### General

* Description: a fake service to demonstrate the terraform wrapper functionality.



### Pre-Flight

1. Install/Configure `awscli`
2. Install/Configure `terraform 1.x`
3. Install `envsubst` (if it doesn't exist on your system)

### Usage

1. In `terminal`, browse to `taccoform-wrapper-demo/burrito/workspaces/prod`
2. Run `ls` in the existing folder, you should only see a symlink to the `tee-eff.sh` script
3. Run `./tee-eff.sh render`
4. Open the newly rendered `provider.tf` and `burrito_base.tf` files to review what has been created.

_Note: Terraform won't be able to run because the s3 bucket will not be valid for you. To make it work, change the `TF_STATE_BUCKET_NAME` variable in the `scripts/tee-eff.sh` script_


* Example output:

```bash
❯ ./tee-eff.sh render
***SETTING VARIABLES***
Module Name:  base
Repo Name:    taccoform-wrapper-demo
Repo Path:    REDACTED/taccoform-wrapper-demo
Service Path: burrito/workspaces/prod/base
Service:      burrito
Environment:  prod
Template Path: REDACTED/taccoform-wrapper-demo/burrito/modules/base

removing any existing terraform files in current working directory

***RENDERING TEMPLATE FILES***
File Name: burrito_base.tf
module "base" {
    source = "../../../modules/base"

    env = "prod"
}

File Name: provider.tf
terraform {
    backend "s3" {
        bucket = "taccoform-tf-backend-prod"
        key    = "taccoform-wrapper-demo/burrito/workspaces/prod/base/terraform.tfstate"
        region = ""
    }

}


provider "aws" {
    region = ""

    default_tags {
        tags = {
            Terraform_Workspace = "taccoform-wrapper-demo/burrito/workspaces/prod/base"
            Environment         = "prod"
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
```
