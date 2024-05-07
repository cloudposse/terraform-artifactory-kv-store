terraform {
  required_version = ">= 1.0"

  required_providers {
    restapi = {
      source  = "Mastercard/restapi"
      version = ">= 1"
    }
    artifactory = {
      source  = "jfrog/artifactory"
      version = ">= 10"
    }
    context = {
      source  = "cloudposse/context"
      version = ">= 0.0.0"
    }
  }
}
