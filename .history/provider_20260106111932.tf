terraform {
  required_providers {
    genesyscloud = {
      source = "mypurecloud/genesyscloud"
    }
  }
}

provider "genesyscloud" {
  sdk_debug          = true
  oauthclient_id     = var.genesys_oauthclient_id
  oauthclient_secret = var.genesys_oauthclient_secret
  aws_region         = var.genesys_region
}
