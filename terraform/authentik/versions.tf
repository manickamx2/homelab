terraform {
  required_version = ">= 1.10.0"

  required_providers {
    authentik = {
      source  = "goauthentik/authentik"
      version = "~> 2025.10"
    }
  }

  backend "s3" {
    bucket = "terraform-state"
    key    = "homelab/authentik/terraform.tfstate"
    region = "us-east-1"

    endpoints = {
      s3 = "https://minio.internal.manickamx2.com"
    }

    use_path_style              = true
    use_lockfile                = true
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    skip_region_validation      = true
    skip_requesting_account_id  = true
  }
}
