/*
    API Calls using Terraform and the CURL Provider.
*/
terraform {

  required_providers {

    curl = {
      source  = "anschoewe/curl"
      version = "1.0.2"
    }

    random = {
      source  = "hashicorp/random"
      version = "3.4.3"
    }

  }
  # About the Mastercard provider: https://registry.terraform.io/providers/Mastercard/restapi/latest/docs

  /* required_version = ">= 1.3.9" */
  # About versioning in Terraform: https://developer.hashicorp.com/terraform/tutorials/configuration-language/versions
}

provider "curl" {
}

provider "random" {
}

resource "random_string" "random" {
  length           = 16
  special          = true
  override_special = "/@£$}*"
}

data "curl" "shouldideploy" {
  http_method = "GET"
  uri         = "https://shouldideploy.today/api?tz=UTC"
}

locals {
  json_data = jsondecode(data.curl.shouldideploy.response)
}

output "api_response" {
  value = local.json_data
}

output "random_number" {
  value = random_string.random.result
}