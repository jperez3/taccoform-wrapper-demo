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
3. Run `./tee-eff.sh init`
4. Open the newly rendered `provider.tf` and `burrito_base.tf` files to review what has been created.

_Note: Terraform won't be able to run because the s3 bucket will not be valid for you. To make it work, change the `TF_STATE_BUCKET_NAME` variable in the `scripts/tee-eff.sh` script
