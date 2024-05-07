provider "context" {
  enabled   = var.enabled
  delimiter = "-"
  property_order = [
    "namespace",
    "ou",
    "environment",
    "region",
    "workload",
    "discriminator"
  ]
  properties = {
    namespace = {
      required   = true
      max_length = 3
    }
    tenant = {
      required = true
    }
    ou = {
      required = true
    }
    workload = {
      required = true
    }
    region = {
      required = true
    }
    environment = {
      required         = true
      validation_regex = "^(dev|test|prod)$"
    }
    discriminator = {
      required = false
    }
  }
  tags_key_case = "title"
  values = {
    namespace   = "eg"
    tenant      = "acme"
    ou          = "core"
    environment = "test"
    workload    = "example"
    region      = "ue2"
  }
}

provider "restapi" {
  uri = format("%s/artifactory/%s", local.artifactory_base_uri, var.artifactory_repository)

  headers = {
    "Authorization" = local.enabled == true ? format("Bearer %s", var.artifactory_auth_token) : ""
    "Content-Type"  = "application/json"
  }

  write_returns_object = true
  create_method        = "PUT"
  update_method        = "PUT"
}

provider "artifactory" {
  url           = format("%s/artifactory", local.artifactory_base_uri)
  access_token  = var.artifactory_auth_token
  check_license = false
}
