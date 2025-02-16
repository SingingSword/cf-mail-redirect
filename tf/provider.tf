# Terraform configuation for OCI and Cloudflare
# state is on a bucket on OCI; credentials are in the AWS format, but they refer to OCI
# please not the bucket URL, clearly pointing to Oracle's S3 compatible namespace
terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "5.1.0"
    }
  }
  backend "s3" {
    bucket = "statefiles"
    region = "eu-milan-1"
    key = "cloudflare-redirect-tf.tfstate"
    skip_region_validation = true
    skip_credentials_validation = true
    skip_requesting_account_id = true
    use_path_style = true
    skip_metadata_api_check = true
    skip_s3_checksum = true
    shared_credentials_files = [ "../.credentials" ]
    endpoints = {
      s3 = "https://axcumkmd4dc9.compat.objectstorage.eu-milan-1.oraclecloud.com"
    }
  }
}

provider "cloudflare" {
  api_token = var.cloudflare_api_token
}
